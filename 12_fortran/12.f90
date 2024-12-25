! compile with gfortran -O3  -ffast-math -flto -o 12 12.f90
program aocd_2024_12
    character, dimension(:, :), allocatable :: data, data_copy
    character, dimension(:, :), allocatable :: visited
    character :: letter
    integer :: k, i, j, area, n, total, score

    ! read once
    call read_file_to_array('12.in', data, n)
    allocate(visited(n, n))
    allocate(data_copy(n, n))
    data_copy = data

    do k = 1, 2
        data = data_copy
        total = 0
        do i = 1, n
            do j = 1, n
                letter = data(i, j)
                if (letter == ' ') cycle  ! Skip if the cell is already visited
                visited = ' '  ! reset whole array
                call connected_copy(data, i, j, n, letter, visited)
                area = count(visited == 'x')
                if (k == 2) then
                    score = nr_sides(visited, n)
                else
                    score = perimeter(visited, n)
                end if
                total = total + area * score
            end do
        end do
        print *, "Level: ", k, " ", total
    end do
    deallocate(data)

contains
    function count_continuous(data, bitmask) result(total)
        integer, dimension(:, :), intent(in) :: data
        integer, intent(in) :: bitmask
        integer :: total
        integer :: i, j
        logical :: inside

        total = 0
        do i = 1, size(data, 1)
            inside = .false.
            do j = 1, size(data, 2)
                if (iand(data(i, j), bitmask) /= 0 .and. .not. inside) then
                    inside = .true.
                    total = total + 1
                else if (iand(data(i, j), bitmask) == 0) then
                    inside = .false.
                end if
            end do
        end do
    end function count_continuous

    function nr_sides(visited, n) result(result)
        character, dimension(:, :), intent(in) :: visited
        integer, intent(in) :: n
        integer :: result
        integer, dimension(:, :), allocatable :: padded_data
        integer :: i, j

        allocate(padded_data(n + 2, n + 2))
        padded_data = 0

        do i = 1, n
            do j = 1, n
                if (visited(i, j) == 'x') then
                    padded_data(i + 1, j + 1) = 1
                end if
            end do
        end do

        do i = 2, n + 1
            do j = 2, n + 1
                if (padded_data(i, j) == 1) then
                    if (padded_data(i, j + 1) /= 1) padded_data(i, j + 1) = ior(padded_data(i, j + 1), 2)
                    if (padded_data(i, j - 1) /= 1) padded_data(i, j - 1) = ior(padded_data(i, j - 1), 4)
                    if (padded_data(i + 1, j) /= 1) padded_data(i + 1, j) = ior(padded_data(i + 1, j), 8)
                    if (padded_data(i - 1, j) /= 1) padded_data(i - 1, j) = ior(padded_data(i - 1, j), 16)
                end if
            end do
        end do

        result = count_continuous(transpose(padded_data), 2) + count_continuous(transpose(padded_data), 4) + count_continuous(padded_data, 8) + count_continuous(padded_data, 16)
        deallocate(padded_data)
    end function nr_sides

    function perimeter(array, n) result(cnt)
        character, dimension(:, :), intent(in) :: array
        integer, intent(in) :: n
        integer :: cnt
        integer :: i, j

        cnt = 0
        do i = 1, n
            do j = 1, n
                if (array(i, j) == 'x') then
                    if (j == n .or. array(i, j + 1) /= 'x') cnt = cnt + 1
                    if (j == 1 .or. array(i, j - 1) /= 'x') cnt = cnt + 1
                    if (i == n .or. array(i + 1, j) /= 'x') cnt = cnt + 1
                    if (i == 1 .or. array(i - 1, j) /= 'x') cnt = cnt + 1
                end if
            end do
        end do
    end function perimeter

    subroutine read_file_to_array(filename, array, n)
        character(len = *), intent(in) :: filename
        character, dimension(:, :), allocatable, intent(out) :: array
        integer, intent(out) :: n
        character(len = 1000) :: line
        integer :: i, length

        open(unit = 10, file = filename, status = 'old', action = 'read')
        read(10, '(A)') line
        n = len_trim(line)
        allocate(array(n, n))

        array(1, :) = transfer(line(1:n), array(1, :))
        do i = 2, n
            read(10, '(A)') line
            array(i, :) = transfer(line(1:n), array(i, :))
        end do
        close(10)
    end subroutine read_file_to_array

    subroutine print_array(array, n)
        character, dimension(:, :), intent(in) :: array
        integer, intent(in) :: n
        integer :: i

        do i = 1, n
            print *, array(i, :)
        end do
    end subroutine print_array

    recursive subroutine connected_copy(data, x, y, n, letter, visited)
        character, dimension(:, :), intent(inout) :: data, visited
        integer, intent(in) :: x, y, n
        character, intent(in) :: letter
        integer :: nx, ny

        if (x >= 1 .and. y >= 1 .and. x <= n .and. y <= n) then
            if (data(x, y) == letter .and. visited(x, y) == ' ') then
                visited(x, y) = 'x'
                data(x, y) = ' '
                call connected_copy(data, x, y + 1, n, letter, visited)
                call connected_copy(data, x + 1, y, n, letter, visited)
                call connected_copy(data, x, y - 1, n, letter, visited)
                call connected_copy(data, x - 1, y, n, letter, visited)
            end if
        end if
    end subroutine connected_copy
end program aocd_2024_12