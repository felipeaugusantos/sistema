unit untCxGridHelper;

interface
uses cxGrid, cxGridLevel, cxGridTableView;

type
  TcxGridRowEstado = (tcxColapsa, tcxExpande);

type
  TcxGridHelper = class helper for TcxGrid
  public
    procedure pCollapseExpandcxGrid(TcxEstado: TcxGridRowEstado);
  end;

implementation

procedure TcxGridHelper.pCollapseExpandcxGrid(TcxEstado: TcxGridRowEstado);
var
  i: Integer;
begin
  If TcxEstado = tcxColapsa Then
    self.FocusedView.DataController.Groups.FullCollapse
  Else
    self.FocusedView.DataController.Groups.FullExpand;

  If (TcxGridLevel(self.FocusedView.Level).Count > 0) And (self.FocusedView Is TcxGridTableView) Then
  begin
    For i:=0 to TcxGridTableView(self.FocusedView).ViewData.RowCount - 1 Do
    Begin
      If TcxEstado = tcxColapsa Then
        TcxGridTableView(self.FocusedView).ViewData.Rows[i].Collapse(True)
      Else
        TcxGridTableView(self.FocusedView).ViewData.Rows[i].Expand(True);
    End;
  End;
end;

end.
