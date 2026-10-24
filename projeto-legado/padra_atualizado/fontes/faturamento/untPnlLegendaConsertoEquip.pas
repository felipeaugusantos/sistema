unit untPnlLegendaConsertoEquip;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Uni,
  Dialogs, StdCtrls, Buttons, Mask, DBCtrls, DBEditFocus, ExtCtrls, UniClientDataSet, DB,
  BitBtnLockedIncrem, EditFocus, untDisparaEmailAut, untFuncoesSimples,
  untConsultaCxGridNova, untClassPanelCx;

type
  TfrmPnlLegendaConsertoEquip = class(TForm)
    pnlDadosCliente: TPanel;
    btnGerarPDF: TBitBtnLocked;
    btnEnviarEmail: TBitBtnLocked;
    pnlLegenda: TPanel;
    pnlLegendaCadCli: TPanel;
    shpVencido: TShape;
    shpAVencer: TShape;
    lblLegenda: TLabel;
    lblPendencia: TLabel;
    lblInativo: TLabel;
    btnSituacaoEquipamento: TBitBtnLocked;
    procedure FormCreate(Sender: TObject);
    procedure btnGerarPDFClick(Sender: TObject);
    procedure btnEnviarEmailClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnSituacaoEquipamentoClick(Sender: TObject);
  private
    { Private declarations }
    strClienteSelecionado: string;
    procedure pEnviarOSEmail(strArquivo: string);
    function fGetStatusOS(strNumOse, strCodEmp : String) : String;
    function fValidaClienteSelecionado: Boolean;
  public
    { Public declarations }
    cdsConsulta: TUniClientDataSet;
    objPanel   : TPanelCX;
    blnNegociacao: Boolean;
    strCodCli: String;
    procedure pIniciouNavegacaoGridConsulta;
    procedure pParouNavegacaoGridConsulta;
    constructor Create(AOwner: TComponent); reintroduce; virtual;

    procedure OnBeforeListaSelecaoAdd(strValue: String; Var blnAdd: boolean);
    procedure OnAfterListaSelecaoRemove(strValue: String);
  end;

  TfrmPnlLegendaConsertoEquipClass = Class Of TfrmPnlLegendaConsertoEquip;

var
  frmPnlLegendaConsertoEquip: TfrmPnlLegendaConsertoEquip;

implementation

uses
  MaskUtils, untFuncoesGenerica, untLegendasItem,
  untEditorFastImpressao, untTypesSistema, untConsertoEquipamento,
  untTermoResponsabilidadeHelper, untDigEmail, untPesqAux, untTEnvioEmail,
  untSituacaoEquipamento, untFuncoes, untConsulta;

{$R *.dfm}

{ TfrmPnlDadosCliente }

procedure TfrmPnlLegendaConsertoEquip.btnEnviarEmailClick(Sender: TObject);
  Var
    objImpressao: TEditorFastImpressao;
    strEsp: string;
    blnOk: Boolean;
    strPDF: string;
    strTpLayout: string;

  procedure pImprimir(tpArquivo: TTipoArquivo; strEspecie: string; var StrPDFRet: string);
  Begin
    objImpressao := TEditorFastImpressao.Create(Nil);
    try
      With objImpressao Do
      Begin
        recDocume.strNumDoc := cdsConsulta.FieldByName('EQU_NUMOSE').AsString;
        recDocume.strCodEmp := cdsConsulta.FieldByName('EQU_CODEMP').AsString;
        recDocume.strEspDoc := strEspecie;

        If strEspecie = 'OS' Then
          tpeTipoEtiqueta := tpeOrdemServico
        Else If strEspecie = 'OSTR' Then
          tpeTipoEtiqueta := tpeOrdemServicoTermoResp
        Else If strEspecie = 'OSTD' Then
          tpeTipoEtiqueta := tpeOrdemServicoTermoDev
        Else If strEspecie = 'OSOE' Then
          tpeTipoEtiqueta := tpeOrdemServicoOrdExecucao;

        recDocume.intQtdImp := 1;
        recDocume.blnReimpr := False;
        recDocume.blnDocCan := False;
        recDocume.blnQtdOri := False;
        recDocume.blnConfir := False;
        recDocume.blnDocSep := False;
        recDocume.blnImpExpedicao := False;
        recDocume.blnFilEmp := False;
        recDocume.blnImpFil := False;
        recDocume.blnSepFut := False;
        recDocume.blnEnt_CD := False;
        recDocume.blnSimples               := False;
        recDocume.blnSempreEntr            := False;
        recDocume.blnNaoSelImp             := True;
        recDocume.blnRequisicao            := False;
        recDocume.blnLocFisEmpEmi          := False;
        recDocume.blnAgruparItensSeparacao := False;
        recDocume.strCodCli := cdsConsulta.FieldByName('EQU_CODCLI').AsString;

        blnOk := fImprimeDocumento(tpArquivo, '', '');

        If tpArquivo = tpaPDF Then
          StrPDFRet := strArqPDF;
      End;

    Finally
      FreeAndNil(objImpressao);
    End;
  End;

begin
  inherited;

  If (cdsConsulta.IsEmpty) Then
  Begin
    pMensagemOk('Selecione uma O.S. para realizar o envio do e-mail!');
    //pSetForegroundWindowsConsulta;
    Exit;
  End;

  try
    VS_frmConsulta.AlphaBlend := true;
    VS_frmConsulta.AlphaBlendValue := 0;

    blnOK := False;
    strTpLayout := 'Ordem de Serviço';
    strEsp := 'OS';

    pImprimir(tpaPDF, strEsp, strPDF);

    If blnOk Then
      pEnviarOSEmail(strPDF);

    If Not blnOk Then
      pMensagemOk('Layout ' + strTpLayout + ' não está configurado.');

  finally
    VS_frmConsulta.AlphaBlend := false;
    VS_frmConsulta.AlphaBlendValue := 255;
  end;
  //pSetForegroundWindowsConsulta;
end;

procedure TfrmPnlLegendaConsertoEquip.btnGerarPDFClick(Sender: TObject);
  Var
    objImpressao: TEditorFastImpressao;
    strEsp: string;
    blnOk: Boolean;
    strPDF: string;
    strTpLayout: string;

  procedure pImprimir(tpArquivo: TTipoArquivo; strEspecie: string; var StrPDFRet: string);
  Begin
    objImpressao := TEditorFastImpressao.Create(Nil);
    try
      With objImpressao Do
      Begin
        recDocume.strNumDoc := cdsConsulta.FieldByName('EQU_NUMOSE').AsString;
        recDocume.strCodEmp := cdsConsulta.FieldByName('EQU_CODEMP').AsString;
        recDocume.strEspDoc := strEspecie;

        If strEspecie = 'OS' Then
          tpeTipoEtiqueta := tpeOrdemServico
        Else If strEspecie = 'OSTR' Then
          tpeTipoEtiqueta := tpeOrdemServicoTermoResp
        Else If strEspecie = 'OSTD' Then
          tpeTipoEtiqueta := tpeOrdemServicoTermoDev
        Else If strEspecie = 'OSOE' Then
          tpeTipoEtiqueta := tpeOrdemServicoOrdExecucao
        Else If strEspecie = 'OSIM' Then
          tpeTipoEtiqueta := tpeOrdemServicoImagem;

        recDocume.intQtdImp := 1;
        recDocume.blnReimpr := False;
        recDocume.blnDocCan := False;
        recDocume.blnQtdOri := False;
        recDocume.blnConfir := False;
        recDocume.blnDocSep := False;
        recDocume.blnImpExpedicao := False;
        recDocume.blnFilEmp := False;
        recDocume.blnImpFil := False;
        recDocume.blnSepFut := False;
        recDocume.blnEnt_CD := False;
        recDocume.blnSimples               := False;
        recDocume.blnSempreEntr            := False;
        recDocume.blnVisPdf                := True;
        recDocume.blnGerPdf                := True;
        recDocume.blnNaoSelImp             := True;
        recDocume.blnRequisicao            := False;
        recDocume.blnLocFisEmpEmi          := False;
        recDocume.blnAgruparItensSeparacao := False;
        recDocume.strCodCli := cdsConsulta.FieldByName('EQU_CODCLI').AsString;

        blnOk := fImprimeDocumento(tpArquivo, '', '');
      End;

    Finally
      FreeAndNil(objImpressao);
    End;
  End;

begin
  inherited;

  If (cdsConsulta.IsEmpty) Then
  Begin
    pMensagemOk('Selecione uma O.S. para realizar a geração do PDF!');
//    pSetForegroundWindowsConsulta;
    Exit;
  End;

  blnOK := False;
  strTpLayout := 'Ordem de Serviço';
  strEsp := 'OS';

  pImprimir(tpaNormal, strEsp, strPDF);

  If Not blnOk Then
    pMensagemOk('Layout ' + strTpLayout + ' não está configurado.');

  If blnOk and fCfgSis('TERCEQ', varBoolean) Then Begin
    If TTermoResposabilidade.fExisteArqModTermoResponsabilidade Then
      TTermoResposabilidade.fGeraTermoResponsabilidade(cdsConsulta.FieldByName('EQU_NUMOSE').AsString,
                                                       cdsConsulta.FieldByName('EQU_CODEMP').AsString,
                                                       StrToDate(cdsConsulta.FieldByName('EQU_DTAENT').AsString),
                                                       '',
                                                       0,
                                                       Self)
    Else Begin
      strEsp := 'OSTR';
      pImprimir(tpaNormal, strEsp, strPDF);

      If not blnOk Then
        strTpLayout := 'Termo de Responsabilidade';

      If Not blnOk Then
        pMensagemOk('Layout ' + strTpLayout + ' não está configurado.');
    End;
  End;

  If blnOk then
  Begin
    If fCampoTabela('LAY_TIPLAY', 'LAYETI', ['LAY_TIPLAY'], [110]) = 110 Then
    Begin
      strEsp := 'OSIM';
      pImprimir(tpaNormal, strEsp, strPDF);

      If Not blnOk Then
        strTpLayout := 'Ordem de Serviço - Imagens';

      If Not blnOk Then
        pMensagemOk('Layout ' + strTpLayout + ' não está configurado.');
    End;
  End;

  //pSetForegroundWindowsConsulta;
end;

procedure TfrmPnlLegendaConsertoEquip.btnSituacaoEquipamentoClick(Sender: TObject);
var
  frmSituacaoEquipamento : TfrmSituacaoEquipamento;
begin

  inherited;

  If Not btnSituacaoEquipamento.Visible Then
    Exit;

  pCriarFormularios(TfrmSituacaoEquipamento, frmSituacaoEquipamento);

  Try

    {OS}
    frmSituacaoEquipamento.strNumOse := cdsConsulta.FieldByName('EQU_NUMOSE').AsString;
    frmSituacaoEquipamento.strCodEmp := cdsConsulta.FieldByName('EQU_CODEMP').AsString;

    If (frmSituacaoEquipamento.ShowModal = mrOk) Then
    Begin
      fMensagem('', 'Situação do equipamento atualizada com sucesso.', ['&Ok']);
      cdsConsulta.Refresh;
    End;

  Finally
    FreeAndNil(frmSituacaoEquipamento);
  End;

end;

constructor TfrmPnlLegendaConsertoEquip.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

function TfrmPnlLegendaConsertoEquip.fGetStatusOS(strNumOse, strCodEmp: String): String;
var
  qryAux : TUniQuery;
const
  strSQL = 'SELECT EQU_STATUS FROM EQUGER WHERE EQU_NUMOSE = :NUMOSE AND EQU_CODEMP = :CODEMP';
begin

  Result := '';

  If fEmptyStr(strNumOse) Then
    Exit;

  If fEmptyStr(strCodEmp) Then
    Exit;

  qryAux := fCriaQuery(Self);

  Try

    qryAux.Close;
    qryAux.SQL.Add(strSQL);
    qryAux.ParamByName('NUMOSE').AsString := strNumOse;
    qryAux.ParamByName('CODEMP').AsString := strCodEmp;
    qryAux.Open;

    If Not qryAux.IsEmpty Then
      Result := qryAux.FieldByName('EQU_STATUS').AsString;

  Finally
    FreeAndNil(qryAux);
  End;

end;

procedure TfrmPnlLegendaConsertoEquip.FormCreate(Sender: TObject);
begin
  shpAVencer.Brush.Color := clOrange;
  shpVencido.Brush.Color := clRed;
end;

procedure TfrmPnlLegendaConsertoEquip.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  Case Key Of
    VK_F7 : btnSituacaoEquipamento.Click;
    VK_F8 : btnGerarPDF.Click;
    VK_F9 : btnEnviarEmail.Click;
  End;

  Case Key Of
    VK_F7,
    VK_F8,
    VK_F9: Key := 0;
  End;
end;

function TfrmPnlLegendaConsertoEquip.fValidaClienteSelecionado: Boolean;
begin
  Result := True;

  if (not fEmptyStr(strCodCli)) and (not SameText(strCodCli, cdsConsulta.FieldByName('EQU_CODCLI').AsString)) then
  begin
    Result := False;
    fMensagem('Aviso', 'A OS selecionada não pode ser incluída na negociação pois já foram inseridas OS''s de outro cliente.', ['&OK']);
  end;

  if Result and (not fEmptyStr(strClienteSelecionado)) and (not SameText(strClienteSelecionado, cdsConsulta.FieldByName('EQU_CODCLI').AsString)) then
  begin
    Result := False;
    fMensagem('Aviso', 'Para executar este processo é preciso selecionar documentos que pertencem ao mesmo cliente.', ['&OK']);
  end;
end;

procedure TfrmPnlLegendaConsertoEquip.OnAfterListaSelecaoRemove(strValue: String);
begin
  if (objPanel.stlListaSelecao.Count = 0) then
    strClienteSelecionado := '';
end;

procedure TfrmPnlLegendaConsertoEquip.OnBeforeListaSelecaoAdd(strValue: String; var blnAdd: boolean);
begin
  blnAdd := fValidaClienteSelecionado;

  if blnAdd and blnNegociacao then
  begin
    if (cdsConsulta.FieldByName('EQU_STATUS').AsString = 'E') then
    begin
      blnAdd := False;
      fMensagem('ATENÇÃO', 'A OS selecionada ainda não teve o orçamento realizado e por isso, não pode ser negociada.', ['&Ok']);
    end;

    if blnAdd and (cdsConsulta.FieldByName('EQU_STATUS').AsString <> 'E') and (cdsConsulta.FieldByName('EQU_STATUS').AsString <> 'F') then
    begin
      blnAdd := False;
      fMensagem('ATENÇÃO', 'Não é possível negociar a OS selecionada pois a mesma se encontra com status: ' + cdsConsulta.FieldByName('STATUS_').AsString + '.', ['&Ok']);
    end;
  end;

  if blnAdd and fEmptyStr(strClienteSelecionado) then
    strClienteSelecionado := cdsConsulta.FieldByName('EQU_CODCLI').AsString;
end;

procedure TfrmPnlLegendaConsertoEquip.pEnviarOSEmail(strArquivo: string);
  Var
    strArqHtml          : String;
    strTexto            : String;
    strAssunto          : String;
    strDestinatario     : String;
    strEmailDestinatario: String;
    strTipExp: String;
    blnConfirma: Boolean;
    qryTmp: TUniQuery;
    arrArquivos, arrDestinatarios : TStringArray;
    EnvioEmail    : TEmaAut;
    strCorpoEmail : TStringArray;
begin

  qryTmp := fCriaQuery;
  try
    Try
      pPesquisaCadCli(Nil, qryTmp, cdsConsulta.FieldByName('EQU_CODCLI').AsString);

      strAssunto := '';
      strDestinatario      := qryTmp.FieldByName('CLI_NOMCLI').AsString;
      strEmailDestinatario := qryTmp.FieldByName('CLI_EMAIL_').AsString;

      pCriarFormularios(TfrmDigEmail, frmDigEmail);
      try
        frmDigEmail.edtEmail.Text   := strEmailDestinatario;
        frmDigEmail.edtContato.Text := strDestinatario;
        blnConfirma := (frmDigEmail.ShowModal = mrOk);

        If (blnConfirma) Then
        Begin
          strDestinatario      := frmDigEmail.edtContato.Text;
          strEmailDestinatario := frmDigEmail.edtEmail.Text;
          strTipExp            := 'P';
        End;
      finally
        pFreeAndNil(frmDigEmail);
      end;
    Except
      On E: Exception Do
      Begin
        blnConfirma := False;
        pMensagensErro(E.Message, '[TfrmPnlLegendaConsertoEquip.pEnviarOSEmail]');
      End;
    End;
  finally
    FreeAndNil(qryTmp);
  end;

  If (Not blnConfirma) Then
    Exit;

  strArqHtml := strArquivo;
  If (Not fEmptyStr(strArqHtml)) Then
  Begin
    EnvioEmail := TEmaAut.Create(Nil);
    try
      EnvioEmail.FCodigo := '001';
      EnvioEmail.FCodGru := '012';
      EnvioEmail.FNumeOS := cdsConsulta.FieldByName('EQU_NUMOSE').AsString;

      EnvioEmail.FCidCli := fRetNomCidade(fRetCodCidByCliente(cdsConsulta.FieldByName('EQU_CODCLI').AsString));
      EnvioEmail.FNomCli := strDestinatario;
      EnvioEmail.FPriCli := fRetPrimeiraPalavra(strDestinatario);

      strAssunto    := EnvioEmail.fGetAssuntoMensagem;
      strCorpoEmail := EnvioEmail.fGetCorpoMensagem;

      if (EnvioEmail.FAssunt <> '') and (EnvioEmail.FAssunt <> '(Sem Assunto)')then
        strAssunto := fRetNomeEmpresa + ' - ' + EnvioEmail.FAssunt
      else
        strAssunto := fRetNomeEmpresa + ' - ' + strAssunto;

      pCriarArrayAnexosEDestinatarios(strArqHtml, strEmailDestinatario, arrDestinatarios, arrArquivos);

      strTexto := strTexto +  (strCorpoEmail).ToString(strTexto, False);
      strTexto := strTexto + #13#10 + #13#10;
      strTexto := strTexto + 'Caso não possua o programa Acrobat Reader para visualizar o arquivo anexo, ';
      strTexto := strTexto + 'acesse o link e faça o download: <a href="https://www.adobe.com">www.adobe.com</a>';

      TEnvioEmail.EnviarEmail(Self, strLoginUsuarioLogado, strAssunto, arrDestinatarios, [], [], TEnvioEmail.ContruirArrayMensagem(strTexto), arrArquivos);

      SetForegroundWindow(Handle);
    finally
      FreeAndNil(EnvioEmail);
    end;
  End
  Else
    fMensagem('', 'Não foi possível exportar o arquivo PDF !', ['&Ok']);
End;

procedure TfrmPnlLegendaConsertoEquip.pIniciouNavegacaoGridConsulta;
begin
  btnSituacaoEquipamento.Visible := False;
end;

procedure TfrmPnlLegendaConsertoEquip.pParouNavegacaoGridConsulta;
Var
  strStatus  : String;
  blnVisivel : Boolean;
begin

  If Not cdsConsulta.Active Then
    Exit;

  If cdsConsulta.IsEmpty Then
    Exit;

  strStatus := fGetStatusOS(cdsConsulta.FieldByName('EQU_NUMOSE').AsString,
                            cdsConsulta.FieldByName('EQU_CODEMP').AsString);

  {Situação do equipamento deve aparecer apenas após OS Realizada/Reprovada}
  blnVisivel := False;

  If (strStatus = 'R') Then
    blnVisivel := True;

  If (strStatus = 'N') Then
    blnVisivel := True;

  btnSituacaoEquipamento.Visible := blnVisivel;
end;

end.
