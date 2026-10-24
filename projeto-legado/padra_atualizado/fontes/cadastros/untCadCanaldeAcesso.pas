unit untCadCanaldeAcesso;

interface

uses
  Windows, Classes, Controls, Forms, untPaiCad, AppEvnts, Menus, ComCtrls, StdCtrls,
  Buttons, ExtCtrls, DBCtrls, DBEditFocus, untCadCac, Uni, DB, BitBtnLockedIncrem,
  Mask, frxClass, frxExportCSVTestabilidade, Vcl.Dialogs;

type
  TfrmCadCanaldeAcesso = class(TfrmPaiCad)
    dtsCadCac: TDataSource;
    pnDados: TPanel;
    Label2: TLabel;
    dbeCodCac: TDBEditFocus;
    dbeNomCac: TDBEditFocus;
    Label3: TLabel;
    Label34: TLabel;
    dbeCorFun: TDBEditFocus;
    cldCores: TColorDialog;
    pnlCategoriaContele: TPanel;
    lblIdCatContele: TLabel;
    btnCatContele: TBitBtnLocked;
    dbeIdCatContele: TDBEditFocus;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure Label34Click(Sender: TObject);
    procedure btnCatConteleClick(Sender: TObject);
  private
    { Private declarations }
    objCadCac : TCadCac;
  Protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    procedure pInicializaIndices; override;

  public
    { Public declarations }
  end;


implementation

uses SysUtils, untFuncoesSimples, untConsultas, untTypesSistema,
  untConsultaIdContele;

{$R *.dfm}

procedure TfrmCadCanaldeAcesso.btnAlterarClick(Sender: TObject);
begin
  inherited;

  dbeCodCac.Enabled := False;
  If dbeNomCac.Enabled Then
    pSetFocus(dbeNomCac);

end;

procedure TfrmCadCanaldeAcesso.btnCatConteleClick(Sender: TObject);
var
  frmConsultaIDContele: TfrmConsultaIDContele;
begin
  pCriarFormularios(TfrmConsultaIDContele, frmConsultaIDContele);
  try
    frmConsultaIDContele.InfoConsultar := apiCategories;
    frmConsultaIDContele.ShowModal;
    if frmConsultaIDContele.ModalResult = mrOk then
      dbeIdCatContele.Text := frmConsultaIDContele.strInfoRetornar;
  finally
    pFreeAndNil(frmConsultaIDContele);
  end;
end;

procedure TfrmCadCanaldeAcesso.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[untCadCanaldeAcesso.btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
    fCommit
  Else
    fRollBack;

end;

procedure TfrmCadCanaldeAcesso.btnGravarClick(Sender: TObject);
begin
  If (Not fValidacoesBotaoGravarPai) Then
    Exit;

  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[untCadCanaldeAcesso.btnGravarClick]');
    End;
  End;

  If blnGravou Then
    fCommit
  Else
    fRollBack;
end;

procedure TfrmCadCanaldeAcesso.btnIncluirClick(Sender: TObject);
begin
  inherited;

  If blnUsaProCodigo Then
    pHabilitaCodigo(dbeCodCac, dbeNomCac, False)
  Else
    pHabilitaCodigo(dbeCodCac, dbeCodCac, True);
end;

procedure TfrmCadCanaldeAcesso.btnPesquisaClick(Sender: TObject);
  Var
    chrKey: Char;
    arrCanal : TConsultasArray;
begin
  {************************************}
  {* NOVA CONSULTA DE CANAL DE ACESSO *}
  {*********************************DP*}
  chrKey := '/';
  If fPesqCanalAcesso(Self, Nil, Nil, qryTabela, chrKey, arrCanal) Then
    pSetFocus(btnAlterar);
end;

procedure TfrmCadCanaldeAcesso.FormCreate(Sender: TObject);
begin
  objCadCac := TCadCac.Create(Self);
  inherited;
  strNomeTabela := 'CADCAC';
  strNomeCampo  := 'CAC_CODCAC';
  qryTabela     := objCadCac.qryTabela;
  dtsCadCac.DataSet := qryTabela;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodCac;

end;

procedure TfrmCadCanaldeAcesso.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(objCadCac);
end;

procedure TfrmCadCanaldeAcesso.FormShow(Sender: TObject);
begin
  inherited;
  If (Not (fCfgSis('EMPGER', varBoolean))) Then
  Begin
    btnIncluir.Enabled := False;
    btnAlterar.Enabled := False;
    btnExcluir.Enabled := False;
  End;

  pnlCategoriaContele.Visible := fCfgSis('APICON', varBoolean);
end;

function TfrmCadCanaldeAcesso.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin

  Result := True;
  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    Try
      {*****************************************}
      {* VALIDA O CÓDIGO DO CANAL              *}
      {**************************************DP*}
      If (Sender = dbeCodCac) Then
      Begin
        If dbeCodCac.Enabled Then
          objCadCac.strCodCac := dbeCodCac.Text;

        If blnBuscaPorChave Then
        Begin
          If Not fBuscaPorCamposChave Then
          Begin
            pLimparCampos;
          End
          Else
          Begin
            dbeCodCac.Enabled := False;
            If dbeNomCac.Enabled Then
            Begin
              pSetFocus(dbeNomCac);
              blnMudarFoco := False;
            End;
          End;
        End;

      End

      {*****************************************}
      {* VALIDA O NOME DO CANAL DE ACESSO      *}
      {**************************************DP*}
      Else If (Sender = dbeNomCac) Then
      Begin
        objCadCac.strNomCac := dbeNomCac.Text;
      End

      Else If (Sender = dbeIdCatContele) Then
      Begin
        objCadCac.strIdCont := dbeIdCatContele.Text;
      End;

    Except
      On E: Exception Do
      Begin
        fMensagem('',E.Message,['&OK']);
        Result := False;
      End;
    End;

  End;

  If Not Result Then
    pSetFocus(Sender);

end;

procedure TfrmCadCanaldeAcesso.Label34Click(Sender: TObject);
begin
  inherited;
  if not (qryTabela.State in dsEditModes) then Exit;


  cldCores.Color := StrToIntDef(TDBEditFocus(TLabel(Sender).FocusControl).Field.AsString,0);
  If (cldCores.Execute) Then
  Begin
    TDBEditFocus(TLabel(Sender).FocusControl).Field.AsString := IntToStr(cldCores.Color);
  End;
end;

procedure TfrmCadCanaldeAcesso.pInicializaIndices;
begin
  inherited;

  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCamInd.Add('CAC_NOMCAC');
  stlCamInd.Add('CAC_CODCAC');
  stlCamInd.Add('CAC_IDCONT');

  stlDesInd.Add('Nome');
  stlDesInd.Add('Código');
  stlDesInd.Add('Código Contele');

end;

end.
