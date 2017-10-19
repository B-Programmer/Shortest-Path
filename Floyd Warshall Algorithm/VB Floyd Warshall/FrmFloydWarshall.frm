VERSION 5.00
Begin VB.Form FrmFloydWarshall 
   Caption         =   "VB 6.0 implementation of Floyd Warshall Algorithm"
   ClientHeight    =   8595
   ClientLeft      =   120
   ClientTop       =   450
   ClientWidth     =   13125
   LinkTopic       =   "Form1"
   ScaleHeight     =   8595
   ScaleWidth      =   13125
   StartUpPosition =   3  'Windows Default
   Begin VB.Frame Frame1 
      Height          =   1215
      Left            =   720
      TabIndex        =   1
      Top             =   7320
      Width           =   11775
      Begin VB.CommandButton CmdStart 
         Caption         =   "&Start"
         BeginProperty Font 
            Name            =   "Palatino Linotype"
            Size            =   20.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   735
         Left            =   600
         TabIndex        =   4
         Top             =   360
         Width           =   3015
      End
      Begin VB.CommandButton CmdReset 
         Caption         =   "&Reset"
         BeginProperty Font 
            Name            =   "Palatino Linotype"
            Size            =   20.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   735
         Left            =   4560
         TabIndex        =   3
         Top             =   360
         Width           =   3015
      End
      Begin VB.CommandButton CmdCancel 
         Caption         =   "&Cancel"
         BeginProperty Font 
            Name            =   "Palatino Linotype"
            Size            =   20.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   735
         Left            =   8520
         TabIndex        =   2
         Top             =   360
         Width           =   3015
      End
   End
   Begin VB.TextBox TxtOutput 
      BeginProperty Font 
         Name            =   "Courier New"
         Size            =   12
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   7095
      Left            =   120
      Locked          =   -1  'True
      MultiLine       =   -1  'True
      ScrollBars      =   3  'Both
      TabIndex        =   0
      Top             =   120
      Width           =   12975
   End
End
Attribute VB_Name = "FrmFloydWarshall"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
' A VB 6.0 -PROGRAMMING LANGUAGE IMPLEMENTATION OF FLOYD WARSHALL SHORTEST PATH ALGORITHM
Const MAXNODE = 10
Const INFINTY = 9999
Const nulll = -1
'*Procedure to compute shortest path weight for each edges
Private Sub ComputeShortestPath(ByRef edge() As Integer, ByRef dist() As Integer, ByRef Nextt() As Integer, ByVal n As Integer)
                 Dim i As Integer, j As Integer, k As Integer, u As Integer, v As Integer
               '/* initialize dist */
               For u = 1 To n
               
                     For v = 1 To n
                     
                        If (edge(u, v) = 0) Then
                            dist(u, v) = INFINTY
                            Nextt(u, v) = nulll
                        Else
                         dist(u, v) = edge(u, v): Nextt(u, v) = v
                        End If
                     Next v
                     
               Next u
               '/* Update dist with standard Floyd-Warshall implementation */
               For k = 1 To n
               
                 For i = 1 To n
                 
                    For j = 1 To n
                    
                        If (dist(i, j) > dist(i, k) + dist(k, j)) Then
                            dist(i, j) = dist(i, k) + dist(k, j)
                            Nextt(i, j) = Nextt(i, k)
                        End If
                    Next j
                     
                 Next i
               Next k
          
End Sub
   '*Procedure for finding the shortest path *
Private Sub FindShortestPath(ByRef dist() As Integer, ByRef Nodes() As String, ByRef Nextt() As Integer, ByVal M As Integer)
    Dim source As String, j As Integer, u As Integer, v As Integer, target As String, cost As Integer
    Const nulll As Integer = -1
    Dim path() As Integer, k As Integer
    Dim found As Boolean
    
    
    found = False
                
    '* Dynamically Allocate Array *
    ReDim path(M)
    
    
    '*Read in source and target node
    TxtOutput.Text = TxtOutput.Text & vbCrLf & "Read in the Source Node/Vertex: "
    source = Left(InputBox("Read in the Source Node/Vertex: ", "Floyd Warshall"), 1)
    TxtOutput.Text = TxtOutput.Text & vbCrLf & source
    TxtOutput.Text = TxtOutput.Text & vbCrLf & "Read in the Target Node/Vertex: "
    target = Left(InputBox("Read in the target Node/Vertex: ", "Floyd Warshall"), 1)
    TxtOutput.Text = TxtOutput.Text & vbCrLf & target
           
               
    '* Verify source *
    For j = 1 To M
       If (source = Nodes(j)) Then
            u = j
            found = True
            'break
       End If
    Next j

        If (found = False) Then
            TxtOutput.Text = TxtOutput.Text & vbCrLf & "Wrong Input! Source Node not found; No path found: "
            Return
        End If
             
          found = False
         '* Verify target *
        For j = 1 To M
           If (target = Nodes(j)) Then
                v = j
                found = True
                'break
           End If
        Next j

        If (found = False) Then
            TxtOutput.Text = TxtOutput.Text & vbCrLf & "Wrong Input! Target Node not found; No path found: "
            Return
        End If
            
        cost = dist(u, v) 'get the shortest distance between the source and target
        'procedure to construct path
             
        
           If (Nextt(u, v) = nulll) Then
             TxtOutput.Text = TxtOutput.Text & vbCrLf & "Failure, No path found! " & vbCrLf
             Return
           End If
             
             
             
             '//getting the shortest path
             k = 1
             path(k) = u
             While (u <> v) '//construct the shortest path with a stack S
                 u = Nextt(u, v)
                 k = k + 1: path(k) = u
             Wend
                 ' //display shortest path
                TxtOutput.Text = TxtOutput.Text & vbCrLf & vbCrLf & "Successful, A Path Found!!! \nThe Shortest Path between " + source + " and " + target + " is: " & vbCrLf + source + "--->"
                For j = 2 To k - 1
                TxtOutput.Text = TxtOutput.Text & Nodes(path(j)) & "--->"
                Next j
                TxtOutput.Text = TxtOutput.Text & Nodes(path(k))
                TxtOutput.Text = TxtOutput.Text & vbCrLf & "The weight/cost of the shortest path between Node: " & source & " and Node: " & target & " is " & cost
       
End Sub
    '*Procedure for reading Nodes *
Private Sub readNodes(ByRef Nodes() As String, ByVal M As Integer)
Dim j As Integer
  TxtOutput.Text = TxtOutput.Text & vbCrLf & "Read in the names of all Nodes/Vertices in the graph"
  MsgBox "Read in the names of all Nodes/Vertices in the graph", vbOKOnly, "Floyd Warshall"
  ReDim Nodes(M)
  For j = 1 To M
      Nodes(j) = InputBox("Read in the names of Node/Vertex " & j & " : ", "Floyd Warshall")
      Nodes(j) = Left$(Nodes(j), 1)
      TxtOutput.Text = TxtOutput.Text & vbCrLf & "Read in the names of Node/Vertex " & j & " : " & Nodes(j)
  Next j
  
End Sub
    '*Procedure for reading weight *
Private Sub readWeight(ByRef W() As Integer, ByRef Nodes() As String, ByVal n As Integer)
Dim j As Integer, i As Integer
  TxtOutput.Text = TxtOutput.Text & vbCrLf & "Read in the weights/costs of all edges between 2 Vertices in the graph"
  MsgBox "Read in the weights/costs of all edges between 2 Vertices in the graph:", vbOKOnly, "Floyd Warshall"
  For i = 1 To n
     For j = 1 To n
         W(i, j) = Val(InputBox("Read in the weight/cost of edge between Node " & Nodes(i) & " and Node " & Nodes(j) & ": ", "Floyd Warshall"))
         TxtOutput.Text = TxtOutput.Text & vbCrLf & "Read in the weight/cost of edge between Node " & Nodes(i) & " and Node " & Nodes(j) & ": " & W(i, j)
       '  If (W(i, j) = 0) Then W(i, j) = INFINTY
     Next j
  Next i
End Sub
    '*Procedure to generate Itemset *

    '* Procedure to display the weight/cost table*
Private Sub DisplayWeight(ByRef W() As Integer, ByVal n As Integer)
Dim i  As Integer, j As Integer
    TxtOutput.Text = TxtOutput.Text & vbCrLf & "The weights/costs Table of all edges between 2 Vertices in the graph: "
    For i = 1 To n
        TxtOutput.Text = TxtOutput.Text & vbCrLf
        For j = 1 To n
                TxtOutput.Text = TxtOutput.Text & W(i, j) & "    "
            
        Next j
    Next i
  
    
End Sub
    '* Procedure to display the shortest path weight/cost table*
Private Sub DisplayShortestPath(ByRef dist() As Integer, ByVal n As Integer)
Dim i  As Integer, j As Integer
    TxtOutput.Text = TxtOutput.Text & vbCrLf & "The Shortest path costs Table of all edges between 2 Vertices in the graph: "
    For i = 1 To n
        TxtOutput.Text = TxtOutput.Text & vbCrLf
        For j = 1 To n
            If (dist(i, j) = INFINTY) Then
                TxtOutput.Text = TxtOutput.Text & "INF   "
            Else
                TxtOutput.Text = TxtOutput.Text & dist(i, j) & "    "
            End If
        Next j
    Next i
End Sub
Private Sub CmdCancel_Click()
End
End Sub

Private Sub CmdReset_Click()
TxtOutput.Text = ""
CmdStart.Enabled = True
End Sub

Private Sub CmdStart_Click()
 '*Begin the main procedure for implementing Floyd Warshall Algorithm *
 
Dim Node() As String, Weight(MAXNODE, MAXNODE) As Integer, dist(MAXNODE, MAXNODE) As Integer, Nextt(MAXNODE, MAXNODE) As Integer

Dim noOfNodes As Integer, Ch As Integer, source As String * 1, target As String * 1
            
    TxtOutput.Text = TxtOutput.Text & "Welcome to VB 6.0 Program developed to implement Floyd Warshall Algorithm:"
    TxtOutput.Text = TxtOutput.Text & vbCrLf & "...................................................................."
    TxtOutput.Text = TxtOutput.Text & vbCrLf & "Read in Number of Vertices/Nodes in Graph: "
    noOfNodes = Val(InputBox("Read in Number of Vertices/Nodes in Graph: ", "Floyd Warshall"))
    TxtOutput.Text = TxtOutput.Text + Str(noOfNodes)
    If (noOfNodes <= 0 Or noOfNodes > MAXNODE) Then
       TxtOutput.Text = TxtOutput.Text & vbCrLf & "Wrong Input! Please, Read in correct digit from 1 to 10:"
            
    Else
       Call readNodes(Node, noOfNodes)
       Call readWeight(Weight, Node, noOfNodes)
       Call DisplayWeight(Weight, noOfNodes)
       Call ComputeShortestPath(Weight, dist, Nextt, noOfNodes)
       Call DisplayShortestPath(dist, noOfNodes)
       TxtOutput.Text = TxtOutput.Text & vbCrLf & "Do you wish to find Shortest Path between two Vertices/Nodes in  the Graph: "
       TxtOutput.Text = TxtOutput.Text & vbCrLf & "Press 1 -> Yes"
       TxtOutput.Text = TxtOutput.Text & vbCrLf & "Press 0 or any other digit -> No"
       Ch = Val(InputBox("Press 1 -> Yes,  Press 0 or any other digit -> No", "Floyd Warshall"))
       TxtOutput.Text = TxtOutput.Text & vbCrLf & Str(Ch)
       If (Ch = 1) Then
           Call FindShortestPath(dist, Node, Nextt, noOfNodes)
                
       End If
    End If
    TxtOutput.Text = TxtOutput.Text & vbCrLf & "****** Press any Key to Continue ******"
CmdStart.Enabled = False
End Sub



