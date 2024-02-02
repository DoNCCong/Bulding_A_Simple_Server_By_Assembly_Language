# By DoNCCong
# My channel: https://www.youtube.com/@mindsetcoder
# as -o Server.o Server.s && ld -o Server Server.o
# Server Running on 0.0.0.0 9999
# Connect the server: nc 0.0.0.0 9999
# If having some errors about the network connection, you can use the command "sudo tcpkill host 0.0.0.0 port 9999"
.intel_syntax noprefix
.globl _start

.section .text

_start:
    #socket
    mov rdi, 2   #AF_INET
    mov rsi, 1  #SOCK_STREAM
    mov rdx, 0   #IPPROTO_IP
    mov rax, 41
    syscall

    #bind
    mov rdi, 3   #
    lea rsi, [rip+sockaddr_in]  #SOCK_STREAM
    mov rdx, 0x10   #IPPROTO_IP
    mov rax, 49
    syscall

    #listen
    mov rdi, 3   #
    mov rsi, 0  #SOCK_STREAM
    mov rax, 50
    syscall

    #accept
    mov rdi, 3
    mov rsi, 0x00
    mov rdx, 0x00
    mov rax, 43
    syscall
	
    #write
    mov rdi, 4
    lea rsi, [rip+response]
    mov rdx, 19
    mov rax, 1
    syscall

	


    
    #read
    mov rdi, 4
    mov rsi, rsp
    mov rdx, 200
    mov rax, 0
    syscall
        
    #open
    lea rdi, [rip+file]
    mov rsi, 0
    mov rdx, 0
    mov rax, 2
    syscall

    #read edit
    mov rdi, 5
    lea rsi, [rsp-300]
    mov rdx, 200
    mov rax, 0
    syscall
    mov r12, rax

    #close
    mov rdi, 5
    mov rax, 3
    syscall

    #write
    mov rdi, 4
    lea rsi, [rsp-300]
    mov rdx, r12
    mov rax, 1
    syscall

    #close
    mov rdi, 4
    mov rax, 3
    syscall

    #exit
    mov rdi, 0
    mov rax, 60     # SYS_exit
    syscall

.section .data
    sockaddr_in:
    	.2byte 2
    	.2byte 0x0f27
    	.4byte 0
    	.8byte 0
    response: 
        .string "***I'm Server***\n"
    file:
        .string "./info.txt"
        
