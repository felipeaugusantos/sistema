unit untConsultaCompIbge;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untConsultaComp, DB,  
  Uni, ExtCtrls, StdCtrls, ComCtrls, Buttons, Grids, DBGridCitel, DBGrids;

type
  TfrmConsultaCompIbge = class(TfrmConsultaComp)
    procedure btnConfirmaClick(Sender: TObject);
  private
  protected
    procedure pSalvaOrdemGrid;
    procedure pMarDesRegistro;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmConsultaCompIbge: TfrmConsultaCompIbge;

implementation

uses untFuncoesSimples;

{$R *.dfm}

procedure TfrmConsultaCompIbge.btnConfirmaClick(Sender: TObject);
  Var
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
  strSQL := strSQL + '  * ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + strNomTabela;
  strSQL := strSQL + ' WHERE ';
  If(qryConsulta.IsEmpty) Then
  Begin
    strSQL := strSQL + ' FALSE ';
  End
  Else
  Begin
    strSQL := strSQL + ' IBG_CODMUN = ' + QuotedStr(qryConsulta.FieldByName('IBG_CODMUN').AsString);
  End;

  bkmUltAcesso := qryConsulta.GetBookMark;

  With qryTabConsulta Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    Open;
  End;

  pSalvaOrdemGrid;

  blnConfirma := True;
  Close;
end;

procedure TfrmConsultaCompIbge.pMarDesRegistro;
  Var
    qryGen: TUniQuery;
begin

  Try
    qryGen := fCriaQuery;

    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(' UPDATE   ');
      SQL.Add(strNomTabela);
      SQL.Add(' SET      ');

      If qryConsulta.FieldByName('MARDES').AsString = 'D' Then
        SQL.Add('  MARDES = "M" ')
      Else
        SQL.Add('  MARDES = "D" ');

      SQL.Add(' WHERE    ');
      SQL.Add('   IBG_CODMUN = :AUTINC ');

      ParamByName('AUTINC').AsString := qryConsulta.FieldByName('IBG_CODMUN').AsString;
      ExecSQL;
      Close;
      dbgConsulta.Refresh;
    End;

  Finally
    FreeAndNil(qryGen);
  End;
end;

procedure TfrmConsultaCompIbge.pSalvaOrdemGrid;
begin
  If (Pos(Copy(strNomeForm,1,Length(strNomeForm)-1),'frmCadCtaPagarCADPAG') > 0) Then
    dbgConsulta.Columns.SaveToFile('frmCadCtaPagarCADPAG')
  Else If (Pos(strNomeForm, 'frmCadCtaReceberCADREC') > 0)  Then
    dbgConsulta.Columns.SaveToFile('frmCadCtaReceberCADREC');
end;

end.
