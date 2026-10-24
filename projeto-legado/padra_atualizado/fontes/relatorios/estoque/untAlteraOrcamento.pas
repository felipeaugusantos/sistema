unit untAlteraOrcamento;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiOrdena, DB, UniClientDataSet, UniDataSetProvider, 
   Uni, AppEvnts, Menus, StdCtrls, EditFocus, Mask,
  MaskEditFocus, Grids, DBGridCitel, DBGrids, Buttons, ExtCtrls, ComCtrls, BitBtnLockedIncrem,
  MemDS, DBAccess, Datasnap.DBClient, Datasnap.Provider, frxClass,
  frxExportCSVTestabilidade, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, cxProgressBar;

type
  TfrmAlteraOrcamento = class(TfrmPaiOrdena)
    Label1: TLabel;
    Label2: TLabel;
    prbProgesso: TcxProgressBar;
    btnExcluir: TBitBtnLocked;
    btnAlterar: TBitBtnLocked;
    btnGravar: TBitBtnLocked;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure dbgConsultaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnGravarClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure dbgConsultaColExit(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    strSQLGen : String;
    strCodCli : String;
    blnConfirma : Boolean;
    objGeraOr: Pointer;
    strNumDoc: String;
    strEspDoc: String;
    strAutInc: String;
    blnErro: Boolean;

  protected
    function fGetSql(blnLike: Boolean): String; Override;
  end;

implementation

uses untPai, untFuncoesSimples, untRelGeraOr;

{$R *.dfm}

procedure TfrmAlteraOrcamento.FormShow(Sender: TObject);
begin
  inherited;

  lflLastField.intIndCol := 1;
  lflLastField.strNomCam := dbgConsulta.Columns[1].FieldName;
  lflLastField.strNomCol := dbgConsulta.Columns[1].Title.Caption;
  lflLastField.ftyTipCam := ftString;

  fAbreConsulta(TRUE);

  TFloatField(cdsConsulta.FieldByName('FDO_UNITAR')).DisplayFormat := '#,##0.00';
  TFloatField(cdsConsulta.FieldByName('FDO_TOTITE')).DisplayFormat := '#,##0.00';

  TFloatField(cdsConsulta.Fieldbyname('SALDCD')).DisplayFormat := '#,##0.000';
  TFloatField(cdsConsulta.Fieldbyname('SALDOS')).DisplayFormat := '#,##0.000';
  TFloatField(cdsConsulta.Fieldbyname('MLTCOM')).DisplayFormat := '#,##0.00';
  TFloatField(cdsConsulta.Fieldbyname('ESTMIN')).DisplayFormat := '#,##0.000';
end;

function TfrmAlteraOrcamento.fGetSql(blnLike: Boolean): String;
Begin
  Result := strSQLgen;
End;

procedure TfrmAlteraOrcamento.FormCreate(Sender: TObject);
begin
  inherited;
  blnSempreRelerBanco := FALSE;
  blnTemSelecao       := FALSE;
end;

procedure TfrmAlteraOrcamento.dbgConsultaColExit(Sender: TObject);
var key: Word;
begin
  Key := VK_RETURN;
  If cdsConsulta.State = dsEdit then
    dbgConsultaKeyDown(dbgConsulta, Key, [ssLeft]);

end;

procedure TfrmAlteraOrcamento.dbgConsultaKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
Var
  fltQtdAnt : Double;
begin
  inherited;
  Case Key Of

    VK_DELETE : btnExcluir.Click;
    VK_F10    : Begin
                  btnGravar.Click;
                  Key := 0;
                End; 

    VK_RETURN : If cdsConsulta.State = dsEdit Then
                Begin
                  fltQtdAnt := cdsConsulta.FieldByName('FDO_QTDITE').AsFloat;
                  cdsConsulta.Post;
                  dbgConsulta.Columns[3].ReadOnly := True;
                  dbgConsulta.Options := dbgConsulta.Options - [dgEditing];

                  If cdsConsulta.FieldByName('FDO_QTDITE').AsFloat > 0 Then
                  Begin
                    If (Frac(cdsConsulta.FieldByName('FDO_QTDITE').AsFloat) <> 0 ) And (cdsConsulta.FieldByName('UNI_ITEFRA').AsString = 'N') Then
                    Begin
                      fMensagem('', 'Não é permitido informar valor fracionado para esse item!', ['&O k']);
                      blnErro := True;
                      cdsConsulta.Edit;
                      cdsConsulta.FieldByName('FDO_QTDITE').AsFloat := fltQtdAnt;
                      cdsConsulta.FieldByName('FDO_QTDITE').FocusControl;
                      cdsConsulta.Post;
                      exit;
                    End
                    Else
                    Begin
                      cdsConsulta.Edit;
                      cdsConsulta.FieldByName('FDO_TOTITE').AsFloat := cdsConsulta.FieldByName('FDO_QTDITE').AsFloat * cdsConsulta.FieldByName('FDO_UNITAR').AsFloat;
                      cdsConsulta.Post;
                      cdsConsulta.Next;
                      cdsConsulta.FieldByName('FDO_QTDITE').FocusControl;
                    End;
                  End
                  Else
                  Begin
                    fMensagem('', 'Quantidade deve ser maior que zero (0)!', ['&O k']);
                    blnErro := True;
                    cdsConsulta.Edit;
                    cdsConsulta.FieldByName('FDO_QTDITE').AsFloat := fltQtdAnt;
                    cdsConsulta.FieldByName('FDO_QTDITE').FocusControl;
                    cdsConsulta.Post;
                    exit;
                  End;
                End
                Else
                  btnAlterar.Click;

    VK_ESCAPE : If cdsConsulta.State = dsEdit Then
                  cdsConsulta.Cancel

    Else
                inherited;

  End;
end;

procedure TfrmAlteraOrcamento.btnGravarClick(Sender: TObject);
var Key: Word;
begin
  If cdsConsulta.State = dsEdit Then
  begin
    blnErro := False;
    Key := VK_RETURN;
    dbgConsultaKeyDown(dbgConsulta, Key, [ssLeft]);
    cdsConsulta.Edit;
    cdsConsulta.FieldByName('FDO_QTDITE').FocusControl;
    If blnErro Then
      Exit;
  End;
  inherited;
  blnConfirma := True;
  strCodCli   := cdsConsulta.fieldbyname('FDO_CODCLI').AsString;

  dbgConsulta.Enabled := False;
  pnlBotoes.Enabled   := False;
  pnlTail.Visible := True;
  TRelGeraOR(objGeraOr).pAlteraPedido(cdsConsulta, strNumDoc, strEspDoc, strAutInc, prbProgesso);
  pnlTail.Visible := False;
  dbgConsulta.Enabled := True;
  pnlBotoes.Enabled   := True;

  Close;
end;

procedure TfrmAlteraOrcamento.btnSairClick(Sender: TObject);
begin
  inherited;
  blnConfirma := False;
end;

procedure TfrmAlteraOrcamento.btnExcluirClick(Sender: TObject);
begin
  inherited;
  If Not cdsConsulta.IsEmpty Then
    cdsConsulta.Delete;
end;

procedure TfrmAlteraOrcamento.btnAlterarClick(Sender: TObject);
Var
  fltQtdAnt : Double;
begin
  inherited;
  If cdsConsulta.State = dsEdit Then
  Begin
    fltQtdAnt := cdsConsulta.FieldByName('FDO_QTDITE').AsFloat;
    cdsConsulta.Post;
    dbgConsulta.Columns[3].ReadOnly := True;
    dbgConsulta.Options := dbgConsulta.Options - [dgEditing];

    If cdsConsulta.FieldByName('FDO_QTDITE').AsFloat > 0 Then
    Begin
      cdsConsulta.Edit;
      cdsConsulta.FieldByName('FDO_TOTITE').AsFloat := cdsConsulta.FieldByName('FDO_QTDITE').AsFloat * cdsConsulta.FieldByName('FDO_UNITAR').AsFloat;
      cdsConsulta.Post;
      cdsConsulta.FieldByName('FDO_QTDITE').FocusControl;
    End
    Else
    Begin
      fMensagem('', 'Quantidade deve ser maior que zero (0)!', ['&O k']);
      cdsConsulta.Edit;
      cdsConsulta.FieldByName('FDO_QTDITE').AsFloat := fltQtdAnt;
      cdsConsulta.Post;
      cdsConsulta.FieldByName('FDO_QTDITE').FocusControl;
      exit;
    End;
  End
  Else
  Begin
    If cdsConsulta.Active And (SameText(dbgConsulta.SelectedField.FieldName,'FDO_QTDITE')) Then
    Begin
      dbgConsulta.Columns[3].ReadOnly := False;
      dbgConsulta.Options := dbgConsulta.Options + [dgEditing];
      cdsConsulta.Edit;
    End;
  End;

end;

end.
