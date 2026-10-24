unit untPnlDadosCliente;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Mask, DBCtrls, DBEditFocus, ExtCtrls, UniClientDataSet, DB,
  BitBtnLockedIncrem, EditFocus, MemoFocus, DBMemoFocus;

type
  TfrmPnlDadosCliente = class(TForm)
    pnlDadosCliente: TPanel;
    Label7: TLabel;
    Label8: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    dbeFone01: TDBEditFocus;
    dbeFone02: TDBEditFocus;
    dbeStatus: TDBEditFocus;
    dbeUltCom: TDBEditFocus;
    GroupBox1: TGroupBox;
    Label3: TLabel;
    Label4: TLabel;
    Label6: TLabel;
    Label5: TLabel;
    Label12: TLabel;
    dbeEndere: TDBEditFocus;
    dbeBairro: TDBEditFocus;
    dbeNumCep: TDBEditFocus;
    dbeCidade: TDBEditFocus;
    dbeEstado: TDBEditFocus;
    GroupBox2: TGroupBox;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    dbeEndCob: TDBEditFocus;
    dbeBaiCob: TDBEditFocus;
    dbeCepCob: TDBEditFocus;
    dbeCidCob: TDBEditFocus;
    dbeEstCob: TDBEditFocus;
    GroupBox3: TGroupBox;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    dbeEndEnt: TDBEditFocus;
    dbeBaiEnt: TDBEditFocus;
    dbeCepEnt: TDBEditFocus;
    dbeCidEnt: TDBEditFocus;
    dbeEstEnt: TDBEditFocus;
    dbeContat: TDBEditFocus;
    dbeNumCel: TDBEditFocus;
    dbeFax: TDBEditFocus;
    dbeIES: TDBEditFocus;
    dtsConsulta: TDataSource;
    btnResFin: TBitBtnLocked;
    Label9: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    dbeEmail2: TDBEditFocus;
    dbeEmail1: TDBEditFocus;
    pnlLegendaCadCli: TPanel;
    Shape1: TShape;
    Shape2: TShape;
    lblPendencia: TLabel;
    lblInativo: TLabel;
    edtCNPJ: TEditFocus;
    lblObs: TLabel;
    memObserv: TDBMemoFocus;
    pnlImgCli: TPanel;
    imgCli: TImage;
    lblErrImg: TLabel;
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnResFinClick(Sender: TObject);
    procedure imgCliDblClick(Sender: TObject);
  private
    { Private declarations }
    blnImgCli : Boolean;

    procedure pSetaMascaraCampo;
    procedure pConsultaAfterOpen(DataSet: TDataSet);
    procedure pConsultaAfterScroll(DataSet: TDataSet);
    procedure pVisualizacaoObs;

    Function fValidaCampos(arrCampo: Array Of String): Boolean;

    procedure pLimpaCamposSemSQL;

  public
    { Public declarations }
    cdsConsulta: TUniClientDataSet;
    blnFaturamento: boolean;
    blnApenasLegenda : Boolean;
    blnFatManConsertoEquip: Boolean;
    constructor Create(AOwner: TComponent); reintroduce; virtual;
  end;

  TfrmPnlDadosClienteClass = Class Of TfrmPnlDadosCliente;

var
  frmPnlDadosCliente: TfrmPnlDadosCliente;

implementation

uses
  MaskUtils, untFuncoesSimples, untFuncoesGenerica, untResFinanceiro, untImagens,
  untConstantes, untFuncoesImagem, untTypesSistema;

{$R *.dfm}

{ TfrmPnlDadosCliente }

procedure TfrmPnlDadosCliente.btnResFinClick(Sender: TObject);
begin
  If Not fVerificaAcessoSistema('RESFIN') Then
  Begin
    fMensagem('', 'Operador não tem direito de acesso ao Resumo Financeiro!', ['&O k']);
    Exit;
  End;

  If Not fValidaCampos(['CLI_CODCLI']) Then
    Exit;

  Try
    pCriarFormularios(TfrmResFinanceiro,frmResFinanceiro);

    If Not fEmptyStr(cdsConsulta.FieldByName('CLI_CODCLI').AsString) Then
      frmResFinanceiro.strCodCli := cdsConsulta.FieldByName('CLI_CODCLI').AsString;

    frmResFinanceiro.ShowModal;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '');
    End;
  End;

  pFreeAndNil(frmResFinanceiro);
end;

constructor TfrmPnlDadosCliente.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  blnImgCli         := fCfgSis('IMGCLI') = 'S';
  pnlImgCli.Visible := blnImgCli;

  if not blnImgCli then
    memObserv.Height := memObserv.Height
                      + 72;
end;

procedure TfrmPnlDadosCliente.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  Case Key Of
    VK_F7: Begin
             If btnResFin.Visible Then
               btnResFin.Click;
             Key := 0;
           End;
  End;
end;

Function TfrmPnlDadosCliente.fValidaCampos(arrCampo: Array Of String): Boolean;

  Function fExisteCampo(Const AstrNome: String): Boolean;
  Var
    intFld: Integer;
  Begin
    Result := False;
    For intFld := 0 To cdsConsulta.Fields.Count - 1 Do
      If SameText(cdsConsulta.Fields[intFld].FieldName, AstrNome) Then
        Exit(True);
  End;

Var
  intContador: Integer;
Begin
  Result := False;

  If (Not Assigned(cdsConsulta)) Or (Not cdsConsulta.Active) Then
    Exit;

  If cdsConsulta.Fields.Count = 0 Then
    Exit;

  For intContador := Low(arrCampo) To High(arrCampo) Do
    If Not fExisteCampo(arrCampo[intContador]) Then
      Exit;

  Result := True;
End;


procedure TfrmPnlDadosCliente.imgCliDblClick(Sender: TObject);
begin
  try
    if blnImgCli and (not cdsConsulta.IsEmpty) then
      TfrmImagens.pAbrirImagens(tiCliente, cdsConsulta.FieldByName('CLI_CODCLI').AsString, True);
  Except

    On E: ExceptionAutCom do
      pMensagemOk(E.Message);

    On E: Exception do
      pMensagensErro(E.Message, '[imgCliDblClick]');

  End;
end;

procedure TfrmPnlDadosCliente.pLimpaCamposSemSQL;
Begin
  If cdsConsulta.Active Then
  Begin

    If Not fValidaCampos(['CLI_ENDERE']) Then
      dbeEndere.DataField := '';

    If Not fValidaCampos(['CLI_BAIRRO']) Then
      dbeBairro.DataField := '';

    If Not fValidaCampos(['CLI_NOMCID']) Then
      dbeCidade.DataField := '';

    If Not fValidaCampos(['CLI_ESTADO']) Then
      dbeEstado.DataField := '';

    If Not fValidaCampos(['CLI_ENDCOB']) Then
      dbeEndCob.DataField := '';

    If Not fValidaCampos(['CLI_BAICOB']) Then
      dbeBaiCob.DataField := '';

    If Not fValidaCampos(['CID_CIDCOB']) Then
      dbeCidCob.DataField := '';

    If Not fValidaCampos(['CID_ESTCOB']) Then
      dbeEstCob.DataField := '';

    If Not fValidaCampos(['CLI_CEPCOB']) Then
      dbeCepCob.DataField := '';

    If Not fValidaCampos(['CLI_ENDENT']) Then
      dbeEndEnt.DataField := '';

    If Not fValidaCampos(['CLI_BAIENT']) Then
      dbeBaiEnt.DataField := '';

    If Not fValidaCampos(['CID_CIDENT']) Then
      dbeCidEnt.DataField := '';

    If Not fValidaCampos(['CID_ESTENT']) Then
      dbeEstEnt.DataField := '';

    If Not fValidaCampos(['CLI_CEPENT']) Then
      dbeCepEnt.DataField := '';

    If Not fValidaCampos(['CLI_OBSERV']) Then
      memObserv.DataField := '';

    If Not fValidaCampos(['CLI_FONE01']) Then
      dbeFone01.DataField := '';

    If Not fValidaCampos(['CLI_FONE02']) Then
      dbeFone02.DataField := '';

    If Not fValidaCampos(['CLI_CONTAT']) Then
      dbeContat.DataField := '';

    If Not fValidaCampos(['CLI_CELULA']) Then
      dbeNumCel.DataField := '';

    If Not fValidaCampos(['CLI_F_A_X_']) Then
      dbeFax.DataField := '';

    If Not fValidaCampos(['CLI_EMAIL_']) Then
      dbeEmail1.DataField := '';

    If Not fValidaCampos(['CLI_EMAIL2']) Then
      dbeEmail2.DataField := '';

    If Not fValidaCampos(['CLI_I_E_S_']) Then
      dbeIES.DataField := '';

    If Not fValidaCampos(['CLI_STATUS']) Then
      dbeStatus.DataField := '';

    If Not fValidaCampos(['CLI_ULTCOM']) Then
      dbeUltCom.DataField := '';
  End;

End;

procedure TfrmPnlDadosCliente.FormShow(Sender: TObject);
begin
  dtsConsulta.DataSet := cdsConsulta;

  pLimpaCamposSemSQL;

  pSetaMascaraCampo;

  cdsConsulta.AfterOpen   := pConsultaAfterOpen;
  cdsConsulta.AfterScroll := pConsultaAfterScroll;

  pVisualizacaoObs;

  If blnApenasLegenda Then
  Begin
    pnlLegendaCadCli.Visible  := True;
    pnlDadosCliente.Visible   := False;
  End;
end;

procedure TfrmPnlDadosCliente.pConsultaAfterScroll(DataSet: TDataSet);
Begin
  With DataSet Do
  Begin
    If IsEmpty Then
      Exit;

  If Not fValidaCampos(['CLI_CGCCPF', 'CLI_C_G_C_']) Then
    Exit;

    If FieldByName('CLI_CGCCPF').AsString = '1' Then
      edtCNPJ.Text := FormatMaskText(fRetMascaraC_G_C_(fSetaPais, C_G_C_), FieldByName('CLI_C_G_C_').AsString)
    Else
      edtCNPJ.Text := FormatMaskText(fRetMascaraC_G_C_(fSetaPais, C_P_F_), FieldByName('CLI_C_G_C_').AsString);

    if blnImgCli then
    begin
      Case fCarregaImagemCliente(FieldByName('CLI_CODCLI').AsString, imgCli.Picture) of
        riOk   :
        Begin
          imgCli.Visible := True;
          lblErrImg.Visible := False;
        End;
        riErro :
        Begin
          imgCli.Visible := False;
          lblErrImg.Visible := True;
        End;
        riNulo :
        Begin
          imgCli.Visible := False;
          lblErrImg.Visible := False;
        End;
      End;
    end;
  End;
End;

procedure TfrmPnlDadosCliente.pConsultaAfterOpen(DataSet: TDataSet);
begin
  pSetaMascaraCampo;
end;

procedure TfrmPnlDadosCliente.pSetaMascaraCampo;
Begin


  With cdsConsulta Do
  Begin
    If fValidaCampos(['CLI_C_E_P_']) Then
      FieldByName('CLI_C_E_P_').EditMask := '99999-999;0;';

    If fValidaCampos(['CLI_CEPCOB']) Then
      FieldByName('CLI_CEPCOB').EditMask := '99999-999;0;';

    If fValidaCampos(['CLI_CEPENT']) Then
      FieldByName('CLI_CEPENT').EditMask := '99999-999;0;';

    If fValidaCampos(['CLI_FONE01']) Then
      FieldByName('CLI_FONE01').EditMask := fRetMascaraFonePais;

    If fValidaCampos(['CLI_FONE02']) Then
      FieldByName('CLI_FONE02').EditMask := fRetMascaraFonePais;

    If fValidaCampos(['CLI_CELULA']) Then
      FieldByName('CLI_CELULA').EditMask := fRetMascaraFonePais;

    If fValidaCampos(['CLI_F_A_X_']) Then
      FieldByName('CLI_F_A_X_').EditMask := fRetMascaraFonePais;
  End;

end;

procedure TfrmPnlDadosCliente.pVisualizacaoObs;
begin
  if blnFaturamento or blnFatManConsertoEquip then
  begin
    memObserv.visible := true;
    lblObs.visible    := true;
  end;
end;

end.
