unit untInspecaoLocEquEntrada;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, Vcl.StdCtrls,
  MemoFocus, EditFocus, QColorLabel, Vcl.ExtCtrls, frxClass, frxExportCSVTestabilidade,
  Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, BitBtnLockedIncrem, Uni, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit,
  cxTextEdit, cxCurrencyEdit, CurrencyEditFocus, cadastro.Model.ContratoLocacaoEquipamentos,
  Vcl.Mask, MaskEditFocus, untTypesLocEqu;

type
  TfrmInspecaoLocEquEntrada = class(TfrmPaiConfirma)
    pnlCobranca: TPanel;
    pnlInspecao: TPanel;
    lblEquipamentoHigienizado: TLabel;
    ColorLabel28: TColorLabel;
    lblObervacoes: TLabel;
    edtHigienizado: TEditFocus;
    memObservacoes: TMemoFocus;
    pnlConferente: TPanel;
    Label3: TLabel;
    Label4: TLabel;
    edtCodConferente: TEditFocus;
    edtCodSupervisor: TEditFocus;
    edtNomConferente: TEditFocus;
    edtNomSupervisor: TEditFocus;
    lblAvarias: TLabel;
    edtAvarias: TEditFocus;
    ColorLabel1: TColorLabel;
    Label6: TLabel;
    edtGerarValor: TEditFocus;
    ColorLabel2: TColorLabel;
    Label7: TLabel;
    edtValorCobranca: TCurrencyEditFocus;
    lblInformacao: TLabel;
    pnlDataInspecao: TPanel;
    lblTermino: TLabel;
    mskDtaIpe: TMaskEditFocus;
    edtHorIpe: TMaskEditFocus;
    procedure FormShow(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtCodConferenteKeyPress(Sender: TObject; var Key: Char);
    procedure edtAvariasExit(Sender: TObject);
    procedure edtAvariasEnter(Sender: TObject);
  private
    qryConOpe: TUniQuery;
    strAvariasAnt: String;
    blnManutencaoIns: Boolean;
    FdtaHorInspecao: TDateTime;
    FDtaIpe: TDateTime;
    FhraIpe: TDateTime;
    FdtaIpeAnterior: TDateTime;

    procedure pBuscarDadosInspecao();
    procedure pBuscarDadosInspecaoEquipamento;
    procedure pBuscarDadosInspecaoAcessorio;
    procedure pGravarDados();
    procedure pGravarDadosEquipamento;
    procedure pGravarDadosAcessorio;
    procedure pEnviaMensagemEquipamento;
    procedure pEnviaMensagemAcessorio;
    procedure pCarregaOperador(strConsulta: String; blnPorSenha: Boolean = False);
    procedure pAjustarCamposCobranca;
    procedure pAjustarCamposManutencao;
    procedure pCarregarDataInspecao;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    strChaveDet: String;
    blnAlterar: Boolean;
    blnCarregarDados: Boolean;
    blnManutencaoConbranca: Boolean;
    blnManutencaoInspecao: Boolean;
    TipoEquipamento: TTpEquipamentoLocacao;
    ObjItemAcessorio: TAcessorioContratoLocacaoEquipamentos;
    ObjItemEquipamento: TItemContratoLocacaoEquipamentos;
  end;

var
  frmInspecaoLocEquEntrada: TfrmInspecaoLocEquEntrada;

implementation

{$R *.dfm}

uses untFuncoesSimples, untConsultas, untPesqAux, untTypesSistema,
  untMsgInterna, untFuncoesGenerica, untFuncoesLocEqu;

procedure TfrmInspecaoLocEquEntrada.btnConfirmaClick(Sender: TObject);
begin
  If fVerificaCampos Then
  Begin
    inherited;
    pGravarDados();
    ModalResult := mrOk;
  End;
end;

procedure TfrmInspecaoLocEquEntrada.edtAvariasEnter(Sender: TObject);
begin
  inherited;

  strAvariasAnt := edtAvarias.Text;
end;

procedure TfrmInspecaoLocEquEntrada.edtAvariasExit(Sender: TObject);
begin
  inherited;

  lblInformacao.Caption := EmptyStr;

  If strAvariasAnt <> 'S' Then
  Begin
    If edtAvarias.Text = 'S' Then
    Begin
      Case TipoEquipamento Of
        tpPrincipal : lblInformacao.Caption := 'Equipamento com avaria será bloqueado no cadastro.';
        tpAcessorio : lblInformacao.Caption := 'Acessório com avaria será bloqueado no cadastro.';
      End;
    End;
  End;
end;

procedure TfrmInspecaoLocEquEntrada.edtCodConferenteKeyPress(Sender: TObject;
  var Key: Char);
  var
    arrOperadores: TConsultasArray;
begin
  inherited;
  if fPesqOperador(Self, edtCodConferente, edtNomConferente, nil, Key, arrOperadores) then
  Begin
    If fValidaCampos(edtCodConferente, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmInspecaoLocEquEntrada.FormCreate(Sender: TObject);
begin
  inherited;
  qryConOpe := fCriarQuery('SELECT * FROM CADOPE WHERE FALSE', Self);

  ObjItemAcessorio := TAcessorioContratoLocacaoEquipamentos.Create(Nil);
  ObjItemEquipamento := TItemContratoLocacaoEquipamentos.Create(Nil);
  strAvariasAnt := EmptyStr;
  blnCarregarDados := False;
  blnManutencaoIns := False;
end;

procedure TfrmInspecaoLocEquEntrada.pAjustarCamposCobranca;
begin
  If Not blnManutencaoConbranca Then
    Exit;

  edtHigienizado.Enabled   := False;
  edtAvarias.Enabled       := False;
  memObservacoes.Enabled   := False;

  edtGerarValor.Enabled    := True;
  edtValorCobranca.Enabled := True;

  edtCodConferente.Enabled := True;
  edtCodSupervisor.Enabled := True;
end;

procedure TfrmInspecaoLocEquEntrada.pAjustarCamposManutencao;
begin
  If Not blnManutencaoInspecao Then
    Exit;

  edtHigienizado.Enabled   := True;
  edtAvarias.Enabled       := True;
  memObservacoes.Enabled   := True;

  edtGerarValor.Enabled    := False;
  edtValorCobranca.Enabled := False;

  edtCodConferente.Enabled := True;
  edtCodSupervisor.Enabled := True;

  If fEmptyStr(edtGerarValor.Text) then
    edtGerarValor.Text := 'N';
end;

procedure TfrmInspecaoLocEquEntrada.FormShow(Sender: TObject);
begin
  inherited;
  edtHigienizado.Enabled   := blnAlterar;
  edtAvarias.Enabled       := blnAlterar;
  memObservacoes.Enabled   := blnAlterar;

  edtGerarValor.Enabled    := blnAlterar;
  edtValorCobranca.Enabled := blnAlterar;

  edtCodConferente.Enabled := blnAlterar;
  edtCodSupervisor.Enabled := blnAlterar;

  btnConfirma.Visible      := blnAlterar;

  pnlDataInspecao.Visible  := False;

  pAjustarCamposCobranca;
  pAjustarCamposManutencao;

  If blnCarregarDados Then
  Begin
    btnSair.Caption := 'Fechar';
    pBuscarDadosInspecao();
  End;

  Case TipoEquipamento Of
    tpPrincipal : Begin
                    lblEquipamentoHigienizado.Caption := 'Equipamento higienizado?';
                    lblAvarias.Caption := 'Equipamento sofreu avarias?';
                    lblObervacoes.Caption := 'Observações sobre o estado do equipamento:';
                  End;

    tpAcessorio : Begin
                    lblEquipamentoHigienizado.Caption := 'Acessório higienizado?';
                    lblAvarias.Caption := 'Acessório sofreu avarias?';
                    lblObervacoes.Caption := 'Observações sobre o estado do acessório:';
                  End;
  End;

  If Not (pnlDataInspecao.Visible) Then
  Begin
    Self.Height := Self.Height - pnlDataInspecao.Height;
  End;

end;

function TfrmInspecaoLocEquEntrada.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := inherited fValidaCampos(Sender, blnBuscaPorChave);

  If Result Then
  Begin
    If Sender = edtHigienizado Then
    Begin
      If fEmptyStr(edtHigienizado.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O campo "Equipamento higienizado?" deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else If (Pos(edtHigienizado.Text, 'SN') <= 0) Then
      Begin
        fMensagem('ATENÇÃO!', 'O valor do campo "Equipamento higienizado?" deve ser "S" ou "N"!', ['&Ok']);
        Result := False;
      End
    End

    Else If Sender = edtAvarias Then
    Begin
      If fEmptyStr(edtAvarias.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O campo "Equipamento sofreu avarias?" deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else If (Pos(edtAvarias.Text, 'SN') <= 0) Then
      Begin
        fMensagem('ATENÇÃO!', 'O valor do campo "Equipamento sofreu avarias?" deve ser "S" ou "N"!', ['&Ok']);
        Result := False;
      End
    End

    Else If Sender = memObservacoes Then
    Begin
      If ((edtHigienizado.Text = 'N') Or (edtAvarias.Text = 'S')) And
         fEmptyStr(memObservacoes.Lines.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Quando o equipamento não foi higienizado ou sofreu avarias, é necessário preencher as observações!', ['&Ok']);
        Result := False;
      End;
    End

    Else If Sender = edtGerarValor Then
    Begin
      If fEmptyStr(edtGerarValor.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O campo "Gerar valor de cobrança para o cliente?" deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else If (Pos(edtGerarValor.Text, 'SN') <= 0) Then
      Begin
        fMensagem('ATENÇÃO!', 'O valor do campo "Gerar valor de cobrança para o cliente?" deve ser "S" ou "N"!', ['&Ok']);
        Result := False;
      End
      Else If edtGerarValor.Text = 'N' Then
        edtValorCobranca.Value := 0;

      edtValorCobranca.Enabled := edtGerarValor.Text = 'S';
    End

    Else If Sender = edtValorCobranca Then
    Begin
      If (edtGerarValor.Text = 'S') And (edtValorCobranca.Value <= 0) Then
      Begin
        fMensagem('ATENÇÃO!', 'O preenchimento do valor da cobrança é obrigatório!', ['&Ok']);
        Result := False;
      End;
    End

    Else If Sender = edtCodConferente Then
    Begin
      edtNomConferente.Text := '';
      If fEmptyStr(edtCodConferente.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Preenchimento do código do conferente é obrigatório!', ['&Ok']);
        Result := False;
      End
      Else
      Begin
        pCarregaOperador(edtCodConferente.Text);
        If qryConOpe.FieldByName('OPE_CODOPE').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse operador conferente não está cadastrado!', ['&O k']);
          Result := False;
        End
        Else
        If qryConOpe.FieldByName('OPE_STATUS').AsString <> 'A' Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse operador conferente está inativo!', ['&O k']);
          Result := False;
        End
        Else
          edtNomConferente.Text := qryConOpe.FieldByName('OPE_NOMOPE').AsString;
      End;
    End

    Else If Sender = edtCodSupervisor Then
    Begin
      edtNomSupervisor.Text := '';
      If fEmptyStr(edtCodSupervisor.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Preenchimento da senha do supervisor é obrigatório!', ['&Ok']);
        Result := False;
      End
      Else
      Begin
        pCarregaOperador(edtCodSupervisor.Text, True);
        If qryConOpe.FieldByName('OPE_CODOPE').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse operador supervisor não está cadastrado!', ['&O k']);
          Result := False;
        End
        Else
        If qryConOpe.FieldByName('OPE_STATUS').AsString <> 'A' Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse operador supervisor está inativo!', ['&O k']);
          Result := False;
        End
        Else
          edtNomSupervisor.Text := qryConOpe.FieldByName('OPE_NOMOPE').AsString;
      End;
    End
    Else If (Sender = mskDtaIpe) and (pnlDataInspecao.Visible) Then
    Begin
       pCarregarDataInspecao;
       If FdtaHorInspecao <= 0 Then
       Begin
         fMensagem('ATENÇÃO!', 'Data inválida!', ['&O k']);
         Result := False;
       End;

       If Assigned(ObjItemEquipamento) Then
       Begin
         If (FdtaHorInspecao <> FdtaIpeAnterior) Then
         Begin
           If fMensagem('ATENÇÃO', 'Ao trocar a data da inspeção da entrada, a data base para cálculo do valor de faturamento do contrato será modificada. Deseja realmente continuar?', ['&Sim', '&Não']) = 2 Then
           Begin
             Result := False;
             FHraIpe := fObtemHora(ObjItemEquipamento.HoraInspecaoEntrada);
             FDtaIpe := fObtemData(ObjItemEquipamento.DataInspecaoEntrada);
             FdtaIpeAnterior := FdtaHorInspecao;
             mskDtaIpe.Text := FormatDateTime('dd/mm/yyyy', ObjItemEquipamento.DataInspecaoEntrada);
           End
           Else
           Begin
             If Not ObjItemEquipamento.fValidaDataInspecao(FdtaHorInspecao) Then
             Begin
               fMensagem('ATENÇÃO!', 'A data de inspeção não pode ser menor que a data inicial do contrato.', ['&O k']);
               Result := False;
             End
             Else
               FdtaIpeAnterior := FdtaHorInspecao;
           End;
         End;
       End;
    End
    Else If (Sender = edtHorIpe) and (pnlDataInspecao.Visible) Then
    Begin
      pCarregarDataInspecao;
      If (FdtaHorInspecao <= 0 )Then
      Begin
        fMensagem('ATENÇÃO!', 'Data inválida!', ['&O k']);
      End;

      If Assigned(ObjItemEquipamento) Then
      Begin
        If (FdtaHorInspecao <> FdtaIpeAnterior) Then
        Begin
          If fMensagem('ATENÇÃO', 'Ao trocar a data da inspeção da entrada, a data base para cálculo do valor de faturamento do contrato será modificada. Deseja realmente continuar?', ['&Sim', '&Não']) = 2 Then
          Begin
            Result := False;
            FHraIpe := fObtemHora(ObjItemEquipamento.HoraInspecaoEntrada);
            FDtaIpe := fObtemData(ObjItemEquipamento.DataInspecaoEntrada);
            FdtaIpeAnterior := FdtaHorInspecao;
            edtHorIpe.Text := FormatDateTime('hh:mm', ObjItemEquipamento.HoraInspecaoEntrada);
          End;
        End
        Else
          FdtaIpeAnterior := FdtaHorInspecao;
      End;
    End;
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmInspecaoLocEquEntrada.pBuscarDadosInspecao;
Begin
  Case TipoEquipamento Of
    tpPrincipal : pBuscarDadosInspecaoEquipamento;
    tpAcessorio : pBuscarDadosInspecaoAcessorio;
  End;
End;

procedure TfrmInspecaoLocEquEntrada.pBuscarDadosInspecaoAcessorio;
begin
  edtHigienizado.Text    := ObjItemAcessorio.strHigienizado;
  edtAvarias.Text        := ObjItemAcessorio.strAvaria;
  memObservacoes.Texto   := ObjItemAcessorio.ObservacoesEntrada;
  edtGerarValor.Text     := ObjItemAcessorio.strGerarCobranca;
  edtValorCobranca.Value := ObjItemAcessorio.ValorCobranca;
  If Not edtCodSupervisor.Enabled Then
  Begin
    edtCodConferente.Text  := ObjItemAcessorio.CodConferenteEntrada;
    pCarregaOperador(edtCodConferente.Text);
    edtNomConferente.Text  := qryConOpe.FieldByName('OPE_NOMOPE').AsString;
    edtCodSupervisor.Text  := ObjItemAcessorio.CodSupervisorEntrada;
    pCarregaOperador(edtCodSupervisor.Text);
    edtNomSupervisor.Text  := qryConOpe.FieldByName('OPE_NOMOPE').AsString;
  End;

  If blnManutencaoInspecao Then
  Begin
    If fEmptyStr(edtGerarValor.Text) Then
      edtGerarValor.Text := 'N';
    edtCodConferente.Text  := ObjItemAcessorio.CodConferenteEntrada;
    pCarregaOperador(edtCodConferente.Text);
    edtNomConferente.Text  := qryConOpe.FieldByName('OPE_NOMOPE').AsString;
  End;

  If Assigned(ObjItemAcessorio.ItemEquipamento) Then
  Begin
    FDtaIpE := fObtemData(ObjItemAcessorio.ItemEquipamento.DataInspecaoEntrada);
    FHraIpE := fObtemHora(ObjItemAcessorio.ItemEquipamento.HoraInspecaoEntrada);
    FDtaIpEAnterior := FDtaIpE + FHraIpE;
    FdtaHorInspecao := FDtaIpE + FHraIpE;
  End;
end;

procedure TfrmInspecaoLocEquEntrada.pBuscarDadosInspecaoEquipamento;
begin
  edtHigienizado.Text    := ObjItemEquipamento.strHigienizado;
  edtAvarias.Text        := ObjItemEquipamento.strAvaria;
  memObservacoes.Texto   := ObjItemEquipamento.ObservacoesEntrada;
  edtGerarValor.Text     := ObjItemEquipamento.strGerarCobranca;
  edtValorCobranca.Value := ObjItemEquipamento.ValorCobranca;
  If Not edtCodSupervisor.Enabled Then
  Begin
    edtCodConferente.Text  := ObjItemEquipamento.CodConferenteEntrada;
    pCarregaOperador(edtCodConferente.Text);
    edtNomConferente.Text  := qryConOpe.FieldByName('OPE_NOMOPE').AsString;

    edtCodSupervisor.Text  := ObjItemEquipamento.CodSupervisorEntrada;
    pCarregaOperador(edtCodSupervisor.Text);
    edtNomSupervisor.Text  := qryConOpe.FieldByName('OPE_NOMOPE').AsString;
  End;

  pnlDataInspecao.Visible := False;
  If Assigned(ObjItemEquipamento) Then
  Begin
    FDtaIpe := fObtemData(ObjItemEquipamento.DataInspecaoEntrada);
    FHraIpe := fObtemHora(ObjItemEquipamento.HoraInspecaoEntrada);
    FdtaIpeAnterior := FDtaIpe + FHraIpe;
    FdtaHorInspecao := FDtaIpe + FHraIpe;
    mskDtaIpe.Text := FormatDateTime('dd/mm/yyyy', ObjItemEquipamento.DataInspecaoEntrada);
    edtHorIpe.Text := FormatDateTime('hh:mm', ObjItemEquipamento.HoraInspecaoEntrada);
  End;

  If blnManutencaoInspecao Then
  Begin
    If fEmptyStr(edtGerarValor.Text) Then
      edtGerarValor.Text := 'N';

    edtCodConferente.Text  := ObjItemEquipamento.CodConferenteEntrada;
    pCarregaOperador(edtCodConferente.Text);
    edtNomConferente.Text  := qryConOpe.FieldByName('OPE_NOMOPE').AsString;
    pnlDataInspecao.Visible := (FdtaIpeAnterior > 0) and (TipoEquipamento = tpPrincipal);
  End;
end;

procedure TfrmInspecaoLocEquEntrada.pCarregaOperador(strConsulta: String;
  blnPorSenha: Boolean);
begin
  pPesquisaCadOpe(qryConOpe, qryConOpe, strConsulta, blnPorSenha);
end;

procedure TfrmInspecaoLocEquEntrada.pCarregarDataInspecao;
begin
  Try
    FdtaIpe := StrToDateTime(mskDtaIpe.Text);
    FHraIpe := StrToDateTime(edtHorIpe.Text);
    FdtaHorInspecao := FdtaIpe + FHraIpe;
  Except
    FdtaHorInspecao := 0;
    FHraIpe := 0;
    FdtaIpe := 0;
  End;
end;

procedure TfrmInspecaoLocEquEntrada.pEnviaMensagemEquipamento;
var
  msgMensagem: TMsgInterna;
  strMsg: String;
begin
  msgMensagem := TMsgInterna.Create(nil);
  Try
    ObjItemEquipamento.Contrato.pCarregarDadosCliente;
    ObjItemEquipamento.NomConferenteEntrada := edtNomConferente.Text;
    strMsg := '';
    strMsg := strMsg + 'Caro Sr. ' + ObjItemEquipamento.NomConferenteEntrada + '<<csq>>';
    strMsg := strMsg + 'Em ' + DateTimeToStr(ObjItemEquipamento.DataInspecaoEntrada) + ' ocorreu Inspeção de Entrada de Equipamento que irá gerar um valor de cobrança para o cliente,' + '<<csq>>';
    strMsg := strMsg + 'conforme segue abaixo:' + '<<csq>>';
    strMsg := strMsg + '----------------------------------------------------------------------------------------------------------' + '<<csq>>';
    strMsg := strMsg + 'Cliente: ' + ObjItemEquipamento.Contrato.Cliente.Codigo + ' - ' + ObjItemEquipamento.Contrato.Cliente.NomeCliente + '<<csq>>';
    strMsg := strMsg + 'Cidade : ' + ObjItemEquipamento.Contrato.Cliente.NomCid + ' - ' + ObjItemEquipamento.Contrato.Cliente.Estado + '   ' + ObjItemEquipamento.Contrato.Cliente.fRetornaMensagemTelefone + '<<csq>>';
    strMsg := strMsg + '----------------------------------------------------------------------------------------------------------' + '<<csq>>';
    strMsg := strMsg + 'Contrato: ' + ObjItemEquipamento.Contrato.NroContrato + '<<csq>>';
    strMsg := strMsg + 'Valor da cobrança gerada: ' + FormatFloat('#,0.00', ObjItemEquipamento.ValorCobranca) + '<<csq>>';
    strMsg := strMsg + '----------------------------------------------------------------------------------------------------------' + '<<csq>>';
    strMsg := strMsg + 'Equipamento: ' + ObjItemEquipamento.Equipamento.Codigo + '-' + ObjItemEquipamento.Equipamento.Descricao + '<<csq>>';
    strMsg := strMsg + 'Número de série : ' + ObjItemEquipamento.Equipamento.NumSerie + '<<csq>>';
    strMsg := strMsg + '----------------------------------------------------------------------------------------------------------' + '<<csq>>';
    strMsg := strMsg + ObjItemEquipamento.ObservacoesEntrada;

    msgMensagem.fEnviaMensagem('LOCAÇÃO DE EQUIPAMENTOS - COBRANÇA GERADA NA INSPEÇÃO DE ENTRADA DE EQUIPAMENTO',
                               strMsg,
                               ObjItemEquipamento.CodConferenteEntrada,
                               ObjItemEquipamento.Contrato.Vendedor.Codigo,
                               'N',
                               '');

  Finally
    FreeAndNil(msgMensagem);
  End;
end;

procedure TfrmInspecaoLocEquEntrada.pEnviaMensagemAcessorio;
var
  msgMensagem: TMsgInterna;
  strMsg: String;
begin
  msgMensagem := TMsgInterna.Create(nil);
  Try
    ObjItemAcessorio.ItemEquipamento.Contrato.pCarregarDadosCliente;
    ObjItemAcessorio.NomConferenteEntrada := edtNomConferente.Text;
    strMsg := '';
    strMsg := strMsg + 'Caro Sr. ' + ObjItemAcessorio.NomConferenteEntrada + '<<csq>>';
    strMsg := strMsg + 'Em ' + DateTimeToStr(ObjItemAcessorio.DataInspecaoEntrada) + ' ocorreu Inspeção de Entrada de Acessório que irá gerar um valor de cobrança para o cliente,' + '<<csq>>';
    strMsg := strMsg + 'conforme segue abaixo:' + '<<csq>>';
    strMsg := strMsg + '----------------------------------------------------------------------------------------------------------' + '<<csq>>';
    strMsg := strMsg + 'Cliente: ' + ObjItemAcessorio.ItemEquipamento.Contrato.Cliente.Codigo + ' - ' + ObjItemAcessorio.ItemEquipamento.Contrato.Cliente.NomeCliente + '<<csq>>';
    strMsg := strMsg + 'Cidade : ' + ObjItemAcessorio.ItemEquipamento.Contrato.Cliente.NomCid + ' - ' + ObjItemAcessorio.ItemEquipamento.Contrato.Cliente.Estado + '   ' + ObjItemAcessorio.ItemEquipamento.Contrato.Cliente.fRetornaMensagemTelefone + '<<csq>>';
    strMsg := strMsg + '----------------------------------------------------------------------------------------------------------' + '<<csq>>';
    strMsg := strMsg + 'Contrato: ' + ObjItemAcessorio.ItemEquipamento.Contrato.NroContrato + '<<csq>>';
    strMsg := strMsg + 'Valor da cobrança gerada: ' + FormatFloat('#,0.00', ObjItemAcessorio.ValorCobranca) + '<<csq>>';
    strMsg := strMsg + '----------------------------------------------------------------------------------------------------------' + '<<csq>>';
    strMsg := strMsg + 'Acessório: ' + ObjItemAcessorio.Acessorio.Codigo + '-' + ObjItemAcessorio.Acessorio.Descricao + '<<csq>>';
    strMsg := strMsg + '----------------------------------------------------------------------------------------------------------' + '<<csq>>';
    strMsg := strMsg + ObjItemAcessorio.ObservacoesEntrada;

    msgMensagem.fEnviaMensagem('LOCAÇÃO DE EQUIPAMENTOS - COBRANÇA GERADA NA INSPEÇÃO DE ENTRADA DE ACESSÓRIO',
                               strMsg,
                               ObjItemAcessorio.CodConferenteEntrada,
                               ObjItemAcessorio.ItemEquipamento.Contrato.Vendedor.Codigo,
                               'N',
                               '');

  Finally
    FreeAndNil(msgMensagem);
  End;
end;

procedure TfrmInspecaoLocEquEntrada.pGravarDados;
Begin
   Case TipoEquipamento Of
    tpPrincipal : pGravarDadosEquipamento;
    tpAcessorio : pGravarDadosAcessorio;
  End;
End;

procedure TfrmInspecaoLocEquEntrada.pGravarDadosAcessorio;
begin
  ObjItemAcessorio.pRealizarInspecaoEntrada(strChaveDet,
                                            edtHigienizado.Text,
                                            edtAvarias.Text,
                                            memObservacoes.Texto,
                                            edtGerarValor.Text,
                                            edtValorCobranca.Value,
                                            edtCodConferente.Text,
                                            qryConOpe.FieldByName('OPE_CODOPE').AsString,
                                            FDtaHorInspecao,
                                            Not blnManutencaoInspecao);

  If ObjItemAcessorio.InspecaoEntradaRealizada Then
  Begin
    If edtGerarValor.Text = 'S' Then
      pEnviaMensagemAcessorio;
  End;

end;

procedure TfrmInspecaoLocEquEntrada.pGravarDadosEquipamento;
Begin
  ObjItemEquipamento.pRealizarInspecaoEntrada(strChaveDet,
                                              edtHigienizado.Text,
                                              edtAvarias.Text,
                                              memObservacoes.Texto,
                                              edtGerarValor.Text,
                                              edtValorCobranca.Value,
                                              edtCodConferente.Text,
                                              qryConOpe.FieldByName('OPE_CODOPE').AsString,
                                              FDtaHorInspecao);

  If ObjItemEquipamento.InspecaoEntradaRealizada Then
  Begin
    If edtGerarValor.Text = 'S' Then
      pEnviaMensagemEquipamento;
  End;

End;

end.
