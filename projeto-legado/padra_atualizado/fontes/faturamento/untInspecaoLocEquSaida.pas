unit untInspecaoLocEquSaida;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, MemoFocus, QColorLabel, EditFocus, Uni, cadastro.Model.ContratoLocacaoEquipamentos,
  Vcl.Mask, MaskEditFocus, untTypesLocEqu;

type
  TfrmInspecaoLocEquSaida = class(TfrmPaiConfirma)
    Panel1: TPanel;
    Panel2: TPanel;
    lblPerfeitasCondicoes: TLabel;
    edtPerfeitasCondicoes: TEditFocus;
    ColorLabel28: TColorLabel;
    lblObervacoes: TLabel;
    memObservacoes: TMemoFocus;
    Label3: TLabel;
    Label4: TLabel;
    edtCodConferente: TEditFocus;
    edtCodSupervisor: TEditFocus;
    edtNomConferente: TEditFocus;
    edtNomSupervisor: TEditFocus;
    pnlDataInspecao: TPanel;
    lblTermino: TLabel;
    mskDtaIps: TMaskEditFocus;
    edtHorIps: TMaskEditFocus;
    procedure FormShow(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtCodConferenteKeyPress(Sender: TObject; var Key: Char);
  private
    qryConOpe: TUniQuery;
    FDtaIps,
    FHraIps,
    FDtaIpsAnterior,
    FdtaHorInspecao: TDateTime;

    procedure pBuscarDadosInspecao();
    procedure pBuscarDadosInspecaoEquipamento;
    procedure pBuscarDadosInspecaoAcessorios;
    procedure pGravaDados();
    procedure pGravarDadosEquipamento;
    procedure pGravarDadosAcessorio;
    procedure pCarregaOperador(strConsulta: String; blnPorSenha: Boolean = False);
    procedure pCarregarDataInspecao;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    strChaveDet: String;
    blnAlterar: Boolean;
    blnCarregarDados: Boolean;
    TipoEquipamento: TTpEquipamentoLocacao;
    ObjItemAcessorio: TAcessorioContratoLocacaoEquipamentos;
    ObjItemEquipamento: TItemContratoLocacaoEquipamentos;
    blnManutencaoIns: Boolean;
  end;

implementation

{$R *.dfm}

uses untFuncoesSimples, untConsultas, untPesqAux, untTypesSistema, untFuncoesLocEqu;

procedure TfrmInspecaoLocEquSaida.btnConfirmaClick(Sender: TObject);
begin
  If fVerificaCampos Then
  Begin
    inherited;
    pGravaDados();
    ModalResult := mrOk;
  End;
end;

procedure TfrmInspecaoLocEquSaida.edtCodConferenteKeyPress(Sender: TObject;
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

procedure TfrmInspecaoLocEquSaida.FormCreate(Sender: TObject);
begin
  inherited;
  qryConOpe := fCriarQuery('SELECT * FROM CADOPE WHERE FALSE', Self);
  blnCarregarDados := blnCarregarDados;
  blnManutencaoIns := False;
end;

procedure TfrmInspecaoLocEquSaida.FormShow(Sender: TObject);
begin
  inherited;
  edtPerfeitasCondicoes.Enabled := blnAlterar;
  memObservacoes.Enabled        := blnAlterar;

  edtCodConferente.Enabled      := blnAlterar;
  edtCodSupervisor.Enabled      := blnAlterar;

  btnConfirma.Visible           := blnAlterar;

  pnlDataInspecao.Visible := False;
  If blnCarregarDados Then
  Begin
    btnSair.Caption := 'Fechar';
    pBuscarDadosInspecao();
  End;

  Case TipoEquipamento Of
    tpPrincipal : Begin
                    lblPerfeitasCondicoes.Caption := 'Equipamento em perfeitas condições?';
                    lblObervacoes.Caption := 'Observações sobre o estado do equipamento:';
                  End;

    tpAcessorio : Begin
                    lblPerfeitasCondicoes.Caption := 'Acessório em perfeitas condições?';
                    lblObervacoes.Caption := 'Observações sobre o estado do acessório:';
                  End;
  End;

  If Not (pnlDataInspecao.Visible) Then
  Begin
    Self.Height := Self.Height - pnlDataInspecao.Height;
  End;
end;

function TfrmInspecaoLocEquSaida.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := inherited fValidaCampos(Sender, blnBuscaPorChave);

  If Result Then
  Begin
    If Sender = edtPerfeitasCondicoes Then
    Begin
      If fEmptyStr(edtPerfeitasCondicoes.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O campo "Equipamento em perfeitas condições?" deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else If (Pos(edtPerfeitasCondicoes.Text, 'SN') <= 0) Then
      Begin
        fMensagem('ATENÇÃO!', 'O valor do campo "Equipamento em perfeitas condições?" deve ser "S" ou "N"!', ['&Ok']);
        Result := False;
      End
    End

    Else If Sender = memObservacoes Then
    Begin
      If (edtPerfeitasCondicoes.Text = 'N') And fEmptyStr(memObservacoes.Lines.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Quando o equipamento não está em perfeitas condições é necessário preencher as observações!', ['&Ok']);
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
    Else If (Sender = mskDtaIps) and (pnlDataInspecao.Visible) Then
    Begin
       pCarregarDataInspecao;
       If FdtaIps <= 0 Then
       Begin
         fMensagem('ATENÇÃO!', 'Data inválida!', ['&O k']);
         Result := False;
       End;

       If Assigned(ObjItemEquipamento) Then
       Begin
         If (FdtaHorInspecao <> FdtaIpsAnterior) Then
         Begin
           If fMensagem('ATENÇÃO', 'Ao trocar a data da inspeção da saída, a data base para cálculo do valor de faturamento do contrato será modificada. Deseja realmente continuar?', ['&Sim', '&Não']) = 2 Then
           Begin
             Result := False;
             FHraIps := fObtemHora(ObjItemEquipamento.HoraInspecaoSaida);
             FDtaIps := fObtemData(ObjItemEquipamento.DataInspecaoSaida);
             FdtaIpsAnterior := FdtaHorInspecao;
             mskDtaIps.Text := FormatDateTime('dd/mm/yyyy', ObjItemEquipamento.DataInspecaoSaida);
           End
           Else
           Begin
             If Not ObjItemEquipamento.fValidaDataInspecao(FdtaHorInspecao) Then
             Begin
               fMensagem('ATENÇÃO!', 'A data de inspeção não pode ser menor que a data inicial do contrato.', ['&O k']);
               Result := False;
             End
             Else
               FdtaIpsAnterior := FdtaHorInspecao;
           End;
         End;
       End;
    End
    Else If (Sender = edtHorIps) and (pnlDataInspecao.Visible) Then
    Begin
      pCarregarDataInspecao;
      If (FdtaHorInspecao <= 0) Then
      Begin
        fMensagem('ATENÇÃO!', 'Data inválida!', ['&O k']);
      End;

      If Assigned(ObjItemEquipamento) Then
      Begin
        If (FdtaHorInspecao <> FdtaIpsAnterior) Then
        Begin
          If fMensagem('ATENÇÃO', 'Ao trocar a data da inspeção da saída, a data base para cálculo do valor de faturamento do contrato será modificada. Deseja realmente continuar?', ['&Sim', '&Não']) = 2 Then
          Begin
            Result := False;
            FHraIps := fObtemHora(ObjItemEquipamento.HoraInspecaoSaida);
            FDtaIps := fObtemData(ObjItemEquipamento.DataInspecaoSaida);
            FdtaIpsAnterior := FdtaHorInspecao;
            edtHorIps.Text := FormatDateTime('hh:mm', ObjItemEquipamento.HoraInspecaoSaida);
          End;
        End
        Else
          FdtaIpsAnterior := FdtaHorInspecao;
      End;
    End;
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmInspecaoLocEquSaida.pBuscarDadosInspecao;
Begin
  Case TipoEquipamento Of
    tpPrincipal : pBuscarDadosInspecaoEquipamento;
    tpAcessorio : pBuscarDadosInspecaoAcessorios;
  End;
End;

procedure TfrmInspecaoLocEquSaida.pBuscarDadosInspecaoAcessorios;
begin
  edtPerfeitasCondicoes.Text := ObjItemAcessorio.strCondicaoPerfeitaSaida;
  memObservacoes.Texto       := ObjItemAcessorio.ObservacoesSaida;
  If Not edtCodSupervisor.Enabled Then
  Begin
    edtCodConferente.Text      := ObjItemAcessorio.CodConferenteSaida;
    pCarregaOperador(edtCodConferente.Text);
    edtNomConferente.Text      := qryConOpe.FieldByName('OPE_NOMOPE').AsString;
    edtCodSupervisor.Text      := ObjItemAcessorio.CodSupervisorSaida;
    pCarregaOperador(edtCodSupervisor.Text);
    edtNomSupervisor.Text      := qryConOpe.FieldByName('OPE_NOMOPE').AsString;
  End;

  If blnManutencaoIns Then
  Begin
    edtCodConferente.Text      := ObjItemAcessorio.CodConferenteSaida;
    pCarregaOperador(edtCodConferente.Text);
    edtNomConferente.Text      := qryConOpe.FieldByName('OPE_NOMOPE').AsString;
  End;

  pnlDataInspecao.Visible := False;
  FDtaIps := fObtemData(ObjItemAcessorio.ItemEquipamento.DataInspecaoSaida);
  FHraIps := fObtemHora(ObjItemAcessorio.ItemEquipamento.HoraInspecaoSaida);
  FDtaIpsAnterior := FDtaIps + FHraIps;
  FdtaHorInspecao := FDtaIps + FHraIps;
end;

procedure TfrmInspecaoLocEquSaida.pBuscarDadosInspecaoEquipamento;
begin
  edtPerfeitasCondicoes.Text := ObjItemEquipamento.strCondicaoPerfeitaSaida;
  memObservacoes.Texto       := ObjItemEquipamento.ObservacoesSaida;
  If Not edtCodSupervisor.Enabled Then
  Begin
    edtCodConferente.Text      := ObjItemEquipamento.CodConferenteSaida;
    pCarregaOperador(edtCodConferente.Text);
    edtNomConferente.Text      := qryConOpe.FieldByName('OPE_NOMOPE').AsString;
    edtCodSupervisor.Text      := ObjItemEquipamento.CodSupervisorSaida;
    pCarregaOperador(edtCodSupervisor.Text);
    edtNomSupervisor.Text      := qryConOpe.FieldByName('OPE_NOMOPE').AsString;
  End;

  If Assigned(ObjItemEquipamento) Then
  Begin
    FDtaIps := fObtemData(ObjItemEquipamento.DataInspecaoSaida);
    FHraIps := fObtemHora(ObjItemEquipamento.HoraInspecaoSaida);
    FDtaIpsAnterior := FDtaIps + FHraIps;
    FDtaHorInspecao := FDtaIps + FHraIps;
    mskDtaIps.Text := FormatDateTime('dd/mm/yyyy', ObjItemEquipamento.DataInspecaoSaida);
    edtHorIps.Text := FormatDateTime('hh:mm', ObjItemEquipamento.HoraInspecaoSaida);
  End;

  If blnManutencaoIns Then
  Begin
    edtCodConferente.Text      := ObjItemEquipamento.CodConferenteSaida;
    pCarregaOperador(edtCodConferente.Text);
    edtNomConferente.Text      := qryConOpe.FieldByName('OPE_NOMOPE').AsString;
    pnlDataInspecao.Visible := (FdtaIpsAnterior > 0) and (TipoEquipamento = tpPrincipal);
  End;
end;

procedure TfrmInspecaoLocEquSaida.pCarregaOperador(strConsulta: String;
  blnPorSenha: Boolean);
begin
  pPesquisaCadOpe(qryConOpe, qryConOpe, strConsulta, blnPorSenha);
end;

procedure TfrmInspecaoLocEquSaida.pCarregarDataInspecao;
begin
  Try
    FdtaIps := StrToDateTime(mskDtaIps.Text);
    FHraIps := StrToDateTime(edtHorIps.Text);
    FdtaHorInspecao := FdtaIps + FHraIps;
  Except
    FdtaHorInspecao := 0;
    FdtaIps := 0;
    FHraIps := 0;
  End;
end;

procedure TfrmInspecaoLocEquSaida.pGravaDados;
begin

  Case TipoEquipamento Of
    tpPrincipal : pGravarDadosEquipamento;
    tpAcessorio : pGravarDadosAcessorio;
  End;

end;

procedure TfrmInspecaoLocEquSaida.pGravarDadosAcessorio;
begin
  ObjItemAcessorio.pRealizarInspecaoSaida(strChaveDet,
                                          edtPerfeitasCondicoes.Text,
                                          memObservacoes.Texto,
                                          edtCodConferente.Text,
                                          qryConOpe.FieldByName('OPE_CODOPE').AsString,
                                          FDtaHorInspecao,
                                          Not blnManutencaoIns);
end;

procedure TfrmInspecaoLocEquSaida.pGravarDadosEquipamento;
begin
  ObjItemEquipamento.pRealizarInspecaoSaida(strChaveDet,
                                            edtPerfeitasCondicoes.Text,
                                            memObservacoes.Texto,
                                            edtCodConferente.Text,
                                            qryConOpe.FieldByName('OPE_CODOPE').AsString,
                                            FDtaHorInspecao,
                                            ObjItemEquipamento.DataInicialCobranca,
                                            blnManutencaoIns);

end;

end.
