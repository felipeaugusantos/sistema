unit untExcBocaCaixa;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiOrdena, DB, UniClientDataSet, UniDataSetProvider, 
   Uni, AppEvnts, Menus, StdCtrls, EditFocus, Mask,
  MaskEditFocus, Grids, DBGridCitel, DBGrids, Buttons, ExtCtrls, BitBtnLockedIncrem, MemDS,
  DBAccess, Datasnap.DBClient, Datasnap.Provider, frxClass,
  frxExportCSVTestabilidade;

type
  TfrmExcBocaCaixa = class(TfrmPaiOrdena)
    btnGravar: TBitBtnLocked;
    btnMarcaTodos: TBitBtnLocked;
    procedure FormShow(Sender: TObject);
    procedure btnMarcaTodosClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnGravarClick(Sender: TObject);
    procedure cdsConsultaAfterScroll(DataSet: TDataSet);
  private
    { Private declarations }
  protected
    function fGetSql(blnLike: Boolean): String; Override;
    function fAbreConsulta(blnLike: Boolean): Boolean; Override;
    function fGetOrderBy: String; Override;
  public
    { Public declarations }
  end;

var
  frmExcBocaCaixa: TfrmExcBocaCaixa;

implementation

uses
  untFuncoesSimples;

{$R *.dfm}

{ TfrmExcBocaCaixa }

function TfrmExcBocaCaixa.fAbreConsulta(blnLike: Boolean): Boolean;
begin
  Result := inherited fAbreConsulta(blnLike);
end;

function TfrmExcBocaCaixa.fGetOrderBy: String;
begin
  Result := 'ORDER BY 1, 2, 3, 4, 5';
end;

function TfrmExcBocaCaixa.fGetSql(blnLike: Boolean): String;
var
  strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  B.BCA_CODEMP, ';
  strSQL := strSQL + '  C.ITE_CODGRU, ';
  strSQL := strSQL + '  B.BCA_CODITE, ';
  strSQL := strSQL + '  C.ITE_DESITE, ';
  strSQL := strSQL + '  M.MAR_DESMAR, ';
  strSQL := strSQL + '  U.UNI_SIGUNI, ';
  strSQL := strSQL + '  FORMAT(I.ITE_PRECUS, 2) AS ITE_PRECUS, ';
  strSQL := strSQL + '  FORMAT(I.ITE_PREVE1, 2) AS ITE_PREVE1, ';
  strSQL := strSQL + '  FORMAT(B.BCA_PREMIN, 2) AS BCA_PREMIN, ';
  strSQL := strSQL + '  FORMAT(B.BCA_COMVAR, 2) AS BCA_COMVAR, ';
  strSQL := strSQL + '  B.AUTOINCREM ';
  strSQL := strSQL + 'FROM      ';
  strSQL := strSQL + '  CADBCA B, ';
  strSQL := strSQL + '  CADITE C, ';
  strSQL := strSQL + '  ITEGER I, ';
  strSQL := strSQL + '  CADMAR M, ';
  strSQL := strSQL + '  CADUNI U ';
  strSQL := strSQL + 'WHERE     ';
  strSQL := strSQL + '  B.BCA_CODITE = C.ITE_CODITE AND ';
  strSQL := strSQL + '  C.ITE_CODITE = I.ITE_CODITE AND ';
  strSQL := strSQL + '  C.ITE_CODUNI = U.UNI_CODUNI AND ';
  strSQL := strSQL + '  C.ITE_CODMAR = M.MAR_CODMAR AND ';
  strSQL := strSQL + '  I.ITE_CODEMP = ' + QuotedStr(VS_strCodEmp);
  Result := strSQL;
end;

procedure TfrmExcBocaCaixa.FormShow(Sender: TObject);
begin
  inherited;
  blnSempreRelerBanco    := False;
  lflLastField.intIndCol := 0;
  lflLastField.strNomCam := dbgConsulta.Columns[0].FieldName;
  lflLastField.strNomCol := dbgConsulta.Columns[0].Title.Caption;
  lflLastField.ftyTipCam := ftString;
  fAbreConsulta(True);
  dbgConsulta.Repaint;
end;

procedure TfrmExcBocaCaixa.btnMarcaTodosClick(Sender: TObject);
begin
  inherited;
  With cdsConsulta Do
  Begin
    DisableControls;
    First;
    While Not Eof Do
    Begin
      pAddListaQuery;
      Next;
    End;
    EnableControls;
  End;
  dbgConsulta.Repaint;
end;

procedure TfrmExcBocaCaixa.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_F6  : btnMarcaTodos.Click;
    VK_F10 : btnGravar.Click;
  End;
end;

procedure TfrmExcBocaCaixa.btnGravarClick(Sender: TObject);
begin
  inherited;
  If (Not cdsConsulta.Active) Or (cdsConsulta.IsEmpty) Then
    Exit;
  If (stlListSelecao.Count = 0) Then
  Begin
    fMensagem('', 'Nenhum registro selecionado!', ['&Ok']);
    Exit;
  End;
  If (fMensagem('', 'Confirma a exclusão dos registros selecionados?', ['&Sim', '&Não']) = 2) Then
    Exit;
  ModalResult := mrOk;
end;

procedure TfrmExcBocaCaixa.cdsConsultaAfterScroll(DataSet: TDataSet);
begin
  inherited;
  dbgConsulta.Repaint;
end;

end.
