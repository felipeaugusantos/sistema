unit untRelFatDemonstracaoCamp;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiRelatorio, Grids, DBGridCitel, DBGrids, DB, untTypesSistema, Uni, RLFilters,
  RLDraftFilter, Menus, StdCtrls, EditFocus, QColorLabel, Buttons, ExtCtrls, Mask,
  MaskEditFocus, DateUtils, StrUtils, UniClientDataSet, UniDataSetProvider,
  frxDesgn, frxClass, frxDBSet, frxDMPExport, frxExportPDF, frxExportHTML,
  frxExportXLS, frxExportRTF, AppEvnts, BitBtnLockedIncrem, frxExportCSVTestabilidade,
  untICamGer;

type
  TfrmRelFatDemostracaoCamp = class(TfrmPaiRelatorio)
    Label11: TLabel;
    lblDesDtaIni: TLabel;
    lblDesDtaFin: TLabel;
    Label12: TLabel;
    mskDtaIni: TMaskEditFocus;
    mskDtaFin: TMaskEditFocus;
    Label2: TLabel;
    edtCodCli: TEditFocus;
    edtDesCli: TEditFocus;
    Label147: TLabel;
    edtDesRed: TEditFocus;
    Label3: TLabel;
    Label4: TLabel;
    edtCodRed: TEditFocus;
    rdgStatus: TRadioGroup;
    edtCodCam: TEditFocus;
    edtDesCam: TEditFocus;
    lstClaFis: TMemo;
    Label6: TLabel;
    lblEmpresa: TLabel;
    edtCodEmp: TEditFocus;
    edtDesEmp: TEditFocus;
    procedure edtCodRedKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodRedExit(Sender: TObject);
    procedure edtCodCliKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodCliExit(Sender: TObject);
    procedure edtCodCamKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodCamExit(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure pAtualizaClaFis;
    procedure btnImprimirClick(Sender: TObject);
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodEmpExit(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }

    arrRedeLojas: TConsultasArray;
    arrClientes : TConsultasArray;
    arrCampanha : TConsultasArray;
    arrEmpresa  : TConsultasArray;

    QryRel : TUniQuery;

  protected

    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; Override;

  end;

var
  frmRelFatDemostracaoCamp: TfrmRelFatDemostracaoCamp;

implementation

uses untFuncoesFactory, untIFuncoes, untClassPanelCx;

{$R *.dfm}

function TfrmRelFatDemostracaoCamp.fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean;
  Var
    intIndex : Integer;
begin

  Result := True;

  {*********************}
  {* VALIDA DATAS      *}
  {******************LU*}
  If (Sender = mskDtaIni) Or (Sender = mskDtaFin) Then
  Begin
    If fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
    Begin
      fMensagem('', 'O campo Data Inicial deve ser preenchido!', ['&O k']);
      Result := False;
      If (Sender = mskDtaFin) Then
        Sender := mskDtaIni;
    End
    Else
    Begin
      If (Sender = mskDtaFin) Then
      Begin
        If fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) Then
        Begin
          fMensagem('', 'O campo Data Final deve ser preenchido!', ['&O k']);
          Result := False;
        End
        Else
        Begin
          If StrToDate(mskDtaIni.Text) > StrToDate(mskDtaFin.Text) Then
          Begin
            fMensagem('','A data inicial deve ser menor que a data final!',['&O K']);
            Result := False;
          End;
        End;
      End
    End;

  End

  Else If (Sender = edtCodEmp) Then
  Begin

    If Not fEmptyStr(edtCodEmp.Text) Then
    Begin
      If Length(arrEmpresa) > 0 Then
      Begin
        For intIndex := Low(arrEmpresa) To High(arrEmpresa) Do
        Begin
          If Pos(arrEmpresa[intIndex].strCodigo, strEmpAcessoUsuarioLogado) <= 0 Then
          Begin
            fMensagem('ATENÇÃO!', 'Usuário sem permissão de acesso a Empresa ' + arrEmpresa[intIndex].strCodigo + '!', ['&O k']);
            Result := False;
            Break;
          End;
        End;
      End
      Else If Pos(edtCodEmp.Text, strEmpAcessoUsuarioLogado) <= 0 Then
      Begin    
        fMensagem('ATENÇÃO!', 'Usuário sem permissão de acesso a essa Empresa!', ['&O k']);
        Result := False;
      End;
    End
    Else
    Begin
      fMensagem('','O código da Empresa deve ser informado!',['&OK']);
      Result := False;
    End;
    
  End;

  
  If Not Result Then
    pSetFocus(Sender);

end;

{*******************************************}
{* CONSULTA REDE DE LOJAS                  *}
{****************************************RL*}
procedure TfrmRelFatDemostracaoCamp.edtCodRedKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  {**********************************}
  {* NOVA CONSULTA DE REDE DE LOJAS *}
  {*******************************RV*}
  If fPesqRedeLojas(Self, edtCodRed, edtDesRed, Nil, Key, arrRedeLojas, False) Then
  Begin
    If fValidaCampos(edtCodRed, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmRelFatDemostracaoCamp.edtCodRedExit(Sender: TObject);
begin
  inherited;

  pEdtCodSelectExit(edtCodRed, edtDesRed, arrRedeLojas, Nil, fRetNomeRedeLoja, 'da rede de lojas');

  If Not fEmptyStr(edtCodRed.Text) Then
  Begin
    edtDesCli.Clear;
    edtCodCli.Clear;
    edtCodCli.ReadOnly := True;
  End
  Else
  Begin
    edtCodCli.Enabled  := True;
    edtCodCli.ReadOnly := False;
  End;

end;

{*******************************************}
{* CONSULTA CLIENTES                       *}
{****************************************RL*}
procedure TfrmRelFatDemostracaoCamp.edtCodCliKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE CLIENTES   *}
  {****************************RV*}
  If fPesqCliente(conCliSimples, Self, edtCodCli, edtDesCli, Nil, Key, arrClientes, False) Then
  Begin
    If fValidaCampos(edtCodCli, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmRelFatDemostracaoCamp.edtCodCliExit(Sender: TObject);
begin
  inherited;

  If Not edtCodCli.ReadOnly Then
    pEdtCodSelectExit(edtCodCli, edtDesCli, arrClientes, Nil, fRetNomCliente, 'do cliente');

end;

{*******************************************}
{* CONSULTA CAMPANHA                       *}
{****************************************RL*}
procedure TfrmRelFatDemostracaoCamp.edtCodCamKeyPress(Sender: TObject;
  var Key: Char);

begin
  inherited;

  If fPesqCampanha(Self, edtCodCam, edtDesCam, nil, Key, arrCampanha) Then
  Begin
    fValidaCampos(edtCodCam,False);
    self.SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmRelFatDemostracaoCamp.edtCodCamExit(Sender: TObject);
  Var
    objCamGer : ICamGer;
begin
  inherited;
  objCamGer := fGetCamGer(Self);

  objCamGer.pCarregaCamGer(edtCodCam.Text);

  If Not fEmptyStr(edtCodCam.Text) Then
  Begin
    If fEmptyStr(objCamGer.strDesCmg) Then
    Begin
      fMensagem('', 'Campanha não encontrada!', ['&Ok']);
      edtCodCam.Clear;
      edtDesCam.Clear;
      pSetFocus(edtCodCam)
    End
    Else
      edtDesCam.Text := objCamGer.strDesCmg;
  End
  Else
    edtDesCam.Text := 'TODAS';
end;

procedure TfrmRelFatDemostracaoCamp.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  If (Key = VK_RETURN) Then
    If (ActiveControl.Parent = rdgStatus) Then
      SelectNext(ActiveControl, True, True);

end;

procedure TfrmRelFatDemostracaoCamp.FormCreate(Sender: TObject);
begin
  inherited;
  pAtualizaClaFis;
  mskDtaIni.Text := DateToStr(VS_Date);
  mskDtaFin.Text := DateToStr(VS_Date);
end;

procedure TfrmRelFatDemostracaoCamp.pAtualizaClaFis;
  Var
    strClaFis: String;
Begin
  //'5102_5403_5405_5655_5656_6102_6108_6404_6405_6655_6656_'

  strClaFis := VS_strClaVen;

  While Not fEmptyStr(strClaFis) Do
  Begin
    Application.ProcessMessages;

    lstClaFis.Lines.Add(LeftStr(strClaFis,4));

    strClaFis := RightStr(strClaFis, Length(strClaFis)-5 );
  End;

End;


procedure TfrmRelFatDemostracaoCamp.btnImprimirClick(Sender: TObject);
  Var
    objCamGer : ICamGer;
begin

  If Not fVerificaCampos Then
    Exit;

  pnlInfo.Caption := 'Gerando Relatório...';
  pnlInfo.Repaint;

  blnPerFil := False;

  inherited;

  If blnImprime Then
  Begin
    objCamGer := fGetCamGer(Self);
    Try

      objCamGer.pImprimirRelatorio(StrToDate(mskDtaIni.Text),
                                   StrToDate(mskDtaFin.Text),
                                   edtCodRed.Text,
                                   edtCodCli.Text,
                                   edtCodCam.Text,
                                   rdgStatus.ItemIndex,
                                   edtDestino.Text,
                                   edtCodEmp.Text);

    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message,'[TfrmRelFatDemostracaoCamp.btnImprimirClick]');
      End;
    End;

    If objCamGer.cdsCamGer.IsEmpty Then
      pTabelaVazia;
  End;

  btnImprimir.Enabled := True;
  pnlInfo.Caption     := '';
  pSetFocus(mskDtaIni);

end;

{*******************************************}
{* CONSULTA EMPRESA                        *}
{****************************************RL*}
procedure TfrmRelFatDemostracaoCamp.edtCodEmpKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE EMPRESAS   *}
  {****************************RV*}
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtDesEmp, Nil, Key, arrEmpresa, False, True) Then
  Begin
    If fValidaCampos(edtCodEmp,False) Then
      Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelFatDemostracaoCamp.edtCodEmpExit(Sender: TObject);
begin
  inherited;

  pEdtCodSelectExit(edtCodEmp, edtDesEmp, arrEmpresa, fRetNomeEmpresa, Nil, 'da empresa');

end;

procedure TfrmRelFatDemostracaoCamp.FormShow(Sender: TObject);
begin
  edtCodEmp.Text := VS_strCodEmp;
  edtDesEmp.Text := fRetNomeEmpresa;

  {***********************************}
  {* EXIBE O SHAPE Q IDENTIFICA SE O *}
  {* RELATÓRIO POSSUI CONSULTAS COM  *}
  {* MULTISELEÇÃO                    *}
  {***08/02/2008*******************ER*}
  shpMultSel.Visible := True;
  inherited;
end;

end.

