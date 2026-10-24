unit untCadLeadOrcamentos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, untZClient,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridCitel, cxGrid, cxCheckBox,
  untILeads, untLeads;

type
  TfrmCadLeadOrcamentos = class(TfrmPai)
    cxgOrcamentosDBTableViewCitel1: TcxGridDBTableViewCitel;
    cxgOrcamentosLevel1: TcxGridLevel;
    cxgOrcamentos: TcxGridCitel;
    cxgOrcamentosDBTableViewCitel1Column1: TcxGridDBColumn;
    cxgOrcamentosDBTableViewCitel1Column2: TcxGridDBColumn;
    cxgOrcamentosDBTableViewCitel1Column3: TcxGridDBColumn;
    cxgOrcamentosDBTableViewCitel1Column4: TcxGridDBColumn;
    cxgOrcamentosDBTableViewCitel1Column5: TcxGridDBColumn;
    cxgOrcamentosDBTableViewCitel1Column6: TcxGridDBColumn;
    btnDesvincular: TBitBtnLocked;
    cxgOrcamentosDBTableViewCitel1Column7: TcxGridDBColumn;
    popMenu: TPopupMenu;
    mnuEfetivarOrcamento: TMenuItem;
    mnuAlterarDocumento: TMenuItem;
    mnuEnviarEmail: TMenuItem;
    mnuGerarPDF: TMenuItem;
    mnuReimprimir: TMenuItem;
    mnuGerarVendaPerdida: TMenuItem;
    mnuDesmembrar: TMenuItem;
    mnuBaixar: TMenuItem;
    mnuAnaliseCreditoDEPS: TMenuItem;
    cxgOrcamentosDBTableViewCitelLINGRU: TcxGridDBColumn;
    procedure FormCreate(Sender: TObject);
    procedure btnDesvincularClick(Sender: TObject);
    procedure SetObjLead(const AValue: ILeads);
    procedure SetExibirOrcamentosFaturados(const AValue: Boolean);
    procedure pDesvincularOrcamento;
    procedure FormDestroy(Sender: TObject);
    procedure pExibirEfetivarOrcamento;
    procedure pExibirGerarVendaPerdida;
    procedure pExibirDesmembrar;
    procedure pExibirBaixar;
    procedure pExibirAlterar;
    procedure pTrataExibirMenus;
    procedure pExibirValidacaoSistemaDEPS;
    procedure cxgOrcamentosDBTableViewCitel1MouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure mnuEfetivarOrcamentoClick(Sender: TObject);
    procedure mnuAlterarDocumentoClick(Sender: TObject);
    procedure mnuEnviarEmailClick(Sender: TObject);
    procedure mnuGerarPDFClick(Sender: TObject);
    procedure mnuReimprimirClick(Sender: TObject);
    procedure mnuGerarVendaPerdidaClick(Sender: TObject);
    procedure mnuDesmembrarClick(Sender: TObject);
    procedure mnuBaixarClick(Sender: TObject);
    procedure mnuAnaliseCreditoDEPSClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure pAjustaBotao;
  private
    cdsFatGor : TZClient;
    FobjLeads: ILeads;
    FblnUtilizaSistemaDEPS: Boolean;
    FblnExibirOrcamentosFaturados: Boolean;
    function fGetSQL(const aExibirOrcamentosFaturados: Boolean = False) : String;
  public
    class procedure pMostraOrcamentos(const aObjLead: ILeads; const aExibirOrcamentosFaturados: Boolean = False);
  end;

implementation

uses
  untFuncoesSimples, untFuncoesOcorrenciasCRM, untValidacoesSistemaDEPS, untFatGor,
  untMovGer,untTSituacaoPedidoVenda, untFatImpressao;

{$R *.dfm}

{ TfrmCadLeadOrcamentos }

function TfrmCadLeadOrcamentos.fGetSQL(const aExibirOrcamentosFaturados: Boolean = False) : String;
begin
  Result := '';
  Result := Result + ' SELECT "N" AS MARCADO,                           ';
  Result := Result + '        FGO_NUMDOC,                               ';
  Result := Result + '        FGO_ESPDOC,                               ';
  Result := Result + '        FGO_CODCLI,                               ';
  Result := Result + '        CLI_NOMCLI,                               ';
  Result := Result + '        FGO_CODEMP,                               ';
  Result := Result + '        FGO_TOTPRO,                               ';
  Result := Result + '        FGO_SEQFGO,                               ';
  Result := Result + '        FGO_STATUS,                               ';
  Result := Result + '        CLI_NOMCLI,                               ';
  Result := Result + '        CLI_EMAIL_,                               ';
  Result := Result + '        FGO_NUMFAT,                               ';
  Result := Result + '        FGO_MOTBAI,                               ';
  Result := Result + '        FGO_STSDEP,                               ';
  Result := Result + '        EXTGOR.FGO_LINGRU,                        ';
  Result := Result + '        G.AUTOINCREM AS AUTOINCREM_FATGOR,        ';
  Result := Result + '        IF(IFNULL(FGO_NUMDOC, "") <> "",          ';
  Result := Result + '          CONCAT(                                 ';
  Result := Result + '            FGO_NUMDOC,                           ';
  Result := Result + '            "-",                                  ';
  Result := Result + '            FGO_ESPDOC,                           ';
  Result := Result + '            "-",                                  ';
  Result := Result + '            FGO_CODEMP),                          ';
  Result := Result + '         ""                                       ';
  Result := Result + '        ) AS DOCUMENTO,                           ';
  Result := Result + '        FGO_USADEP                                ';
  Result := Result + ' FROM FATGOR G                                    ';
  Result := Result + '   INNER JOIN EXTGOR ON FGO_SEQFGO = G.AUTOINCREM ';
  Result := Result + '   INNER JOIN CADCLI ON CLI_CODCLI = FGO_CODCLI   ';
  Result := Result + ' WHERE FGO_NLEADS = :NLEADS                       ';
  Result := Result + '   AND FGO_ESPDOC = "OR"                          ';
  If Not(aExibirOrcamentosFaturados) Then
    Result := Result + '   AND FGO_JAFATU = 0                           ';
end;


procedure TfrmCadLeadOrcamentos.FormCreate(Sender: TObject);
begin
  inherited;

  cdsFatGor := TZClient.Create(Self);
  FobjLeads := TLeads.New();
  FblnUtilizaSistemaDEPS := fCfgSis('USADEP') = 'S';
  cxgOrcamentosDBTableViewCitelLINGRU.Visible := fCfgSis('VIORLG', varBoolean);
end;

procedure TfrmCadLeadOrcamentos.FormDestroy(Sender: TObject);
begin
  FreeAndNil(cdsFatGor);

  inherited;
end;

procedure TfrmCadLeadOrcamentos.FormShow(Sender: TObject);
var
  intCnt: Integer;
begin
  inherited;

  cdsFatGor.qryQuery.SQL.Add(fGetSQL(FblnExibirOrcamentosFaturados));
  cdsFatGor.qryQuery.ParamByName('NLEADS').AsString := FobjLeads.strNumLead;
  cdsFatGor.fAbreClient(True, 'TfrmCadLeadOrcamentos.pMostraOrcamentos');
  TFloatField(cdsFatGor.FieldByName('FGO_TOTPRO')).DisplayFormat := fMskDigitos(2);
  cxgOrcamentosDBTableViewCitel1.DataController.DataSource := cdsFatGor.dtsSource;

  for intCnt := 1 to cdsFatGor.Fields.Count  -1 do
    cdsFatGor.Fields[intCnt].ReadOnly := True;

  pAjustaBotao;
end;

procedure TfrmCadLeadOrcamentos.pAjustaBotao;
begin
  btnDesvincular.Enabled  := Not (cdsFatGor.IsEmpty);
end;

procedure TfrmCadLeadOrcamentos.pDesvincularOrcamento;
var
  intCnt: Integer;
begin
  intCnt := 0;
  cdsFatGor.DisableControls;
  Try

    cdsFatGor.First;
    If Not cdsFatGor.IsEmpty Then
    Begin
      While Not cdsFatGor.Eof Do
      Begin
        If cdsFatGor.FieldByName('MARCADO').AsString = 'S' Then
        Begin
          FobjLeads.pDesvincularOrcamentoAoLead(cdsFatGor.FieldByName('FGO_SEQFGO').AsString);
          Inc(intCnt);
        End;
        cdsFatGor.Next;
      End;

      If intCnt <=0  Then
        fMensagem('Atenção','Selecione um Orçamento para desvincular do Lead!' , ['&OK'])
      Else
        fMensagem('Atenção', 'Orçamento(s) desvinculado(s) do Lead: ' + FobjLeads.strNumLead , ['&OK']);
    End;

  Finally
    cdsFatGor.EnableControls;
  End;
end;

class procedure TfrmCadLeadOrcamentos.pMostraOrcamentos(const aObjLead: ILeads; const aExibirOrcamentosFaturados: Boolean = False);
  var
    frmCadLeadOrcamentos: TfrmCadLeadOrcamentos;
begin
  pCriarFormularios(TfrmCadLeadOrcamentos, frmCadLeadOrcamentos);
  try
    frmCadLeadOrcamentos.SetObjLead(aObjLead);
    frmCadLeadOrcamentos.SetExibirOrcamentosFaturados(aExibirOrcamentosFaturados);
    frmCadLeadOrcamentos.ShowModal;
  Finally
    FreeAndNil(frmCadLeadOrcamentos);
  End;

end;

procedure TfrmCadLeadOrcamentos.pTrataExibirMenus;
begin
  pExibirBaixar();
  pExibirAlterar();
  pExibirDesmembrar();
  pExibirEfetivarOrcamento();
  pExibirGerarVendaPerdida();
  pExibirValidacaoSistemaDEPS();
end;

procedure TfrmCadLeadOrcamentos.SetExibirOrcamentosFaturados(
  const AValue: Boolean);
begin
  FblnExibirOrcamentosFaturados := AValue;
end;

procedure TfrmCadLeadOrcamentos.SetObjLead(const AValue: ILeads);
begin
  FobjLeads := AValue;
end;

procedure TfrmCadLeadOrcamentos.btnDesvincularClick(Sender: TObject);
begin
  inherited;

  If fMensagem('', 'Deseja desvincular o(s) Orçamento(s) selecionado do Lead?', ['&Sim', '&Não'], 2) = 1 Then
  Begin
    pDesvincularOrcamento;
    cdsFatGor.fAbreClient(True, 'TfrmCadLeadOrcamentos.pMostraOrcamentos');
    pAjustaBotao;
  End;
end;

procedure TfrmCadLeadOrcamentos.cxgOrcamentosDBTableViewCitel1MouseDown(
  Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited;

  If Button = mbRight Then
  Begin
    If Not  fEmptyStr(cdsFatGor.FieldByName('FGO_SEQFGO').AsString ) Then
    Begin
      pTrataExibirMenus;
      popMenu.Popup(Mouse.CursorPos.X, Mouse.CursorPos.Y);
    End;
  End;
end;

procedure TfrmCadLeadOrcamentos.mnuAlterarDocumentoClick(Sender: TObject);
begin
  inherited;

  If cdsFatGor.IsEmpty Or
    (Not mnuAlterarDocumento.Visible) Then
  Exit;

  If Assigned(popMenu) Then
  Begin
    pAlterarDocumento(cdsFatGor.FieldByName('DOCUMENTO').AsString,
                      cdsFatGor.FieldByName('FGO_CODCLI').AsString,
                      popMenu,
                      (strTipFil = 'P'),
                      FobjLeads.strNumLead);

  End;
end;
procedure TfrmCadLeadOrcamentos.mnuAnaliseCreditoDEPSClick(Sender: TObject);
begin
  inherited;

  If (Not mnuAnaliseCreditoDEPS.Visible) Or
     (Not mnuAnaliseCreditoDEPS.Enabled) Then
    Exit;

  If Not fEmptyStr(cdsFatGor.FieldByName('FGO_NUMFAT').AsString) Then
  Begin
    fMensagem('ATENÇÃO', 'Não é possível realizar o envio da análise, pois o documento já foi transformado em Pedido de Venda.', ['&OK']);
    Exit;
  End;

  If Not fEmptyStr(cdsFatGor.FieldByName('FGO_MOTBAI').AsString) Then
  Begin
    fMensagem('ATENÇÃO', 'Não é possível realizar o envio da análise, pois o documento foi baixado.', ['&OK']);
    Exit;
  End;

  If Pos(cdsFatGor.FieldByName('FGO_STSDEP').AsString, 'APROVADO_DISPENSA ANÁLISE_') > 0 Then
  Begin
    If cdsFatGor.FieldByName('FGO_STSDEP').AsString = 'APROVADO' Then
      fMensagem('ATENÇÃO', 'Orçamento já aprovado.', ['&OK'])
    Else
      fMensagem('ATENÇÃO', 'Não será necessário a aprovação de crédito. Orçamento já está liberado para faturamento.', ['&OK']);

    Exit;
  End;

  If fMensagem('ATENÇÃO', 'Tem certeza que deseja enviar o documento para a análise de crédito do Sistema DEPS?', ['&Sim', '&Não'], 2) = 2 Then
    Exit;

  Try
    fStartTransaction;
    TValidacoesSistemaDEPS.fAtualizaStatusSistemaDEPS(cdsFatGor.FieldByName('AUTOINCREM_FATGOR').AsString,
                                                      'AGUARDANDO ANÁLISE');

    fCommit;
  Except
    On E: Exception Do
    Begin
      fRollback;
      pMensagensErro(E.Message, '[TfrmCadLeadOrcamentos.mnuAnaliseCreditoDEPSClick]');
    End;

  End;
end;

procedure TfrmCadLeadOrcamentos.mnuBaixarClick(Sender: TObject);
begin
  inherited;

  If Not mnuBaixar.Visible Then
    Exit;

  fBaixarPedOrcNaoEntregue(cdsFatGor.FieldByName('FGO_NUMDOC').AsString,
                           cdsFatGor.FieldByName('FGO_ESPDOC').AsString,
                           cdsFatGor.FieldByName('FGO_CODEMP').AsString,
                           True);

end;

procedure TfrmCadLeadOrcamentos.mnuDesmembrarClick(Sender: TObject);
begin
  inherited;

  If (Not mnuDesmembrar.Visible) Then
    Exit;

  fDesmembrarPedOrc(cdsFatGor.FieldByName('DOCUMENTO').AsString);
end;

procedure TfrmCadLeadOrcamentos.mnuEfetivarOrcamentoClick(Sender: TObject);
begin
  inherited;

  If Not mnuEfetivarOrcamento.Visible Then
    Exit;

  If cdsFatGor.IsEmpty Then
    Exit;

  If (FblnUtilizaSistemaDEPS) And
   (Pos(cdsFatGor.FieldByName('FGO_STSDEP').AsString, 'APROVADO_DISPENSA ANÁLISE_') <= 0) Then
  Begin
    fMensagem('ATENÇÃO', 'Necessária a aprovação de crédito do sistema DEPS para a efetivação.' + #13 +
                         'Status DEPS: ' + cdsFatGor.FieldByName('FGO_STSDEP').AsString, ['&OK']);
    Exit;
  End;

  If fEfetivarOrcamentoEmPedido(cdsFatGor.FieldByName('DOCUMENTO').AsString,
                                cdsFatGor.FieldByName('FGO_CODCLI').AsString) Then
    fMensagem('Atenção', 'Orçamento efetivado em pedido.' , ['&OK']);


end;

procedure TfrmCadLeadOrcamentos.mnuEnviarEmailClick(Sender: TObject);
begin
  inherited;

  If cdsFatGor.IsEmpty Then
    Exit;

  pEnviarEmail(Self,
               cdsFatGor.FieldByName('DOCUMENTO').AsString,
               cdsFatGor.FieldByName('FGO_CODCLI').AsString,
               cdsFatGor.FieldByName('CLI_NOMCLI').AsString,
               cdsFatGor.FieldByName('CLI_EMAIL_').AsString);
end;

procedure TfrmCadLeadOrcamentos.mnuGerarPDFClick(Sender: TObject);
begin
  inherited;

  If cdsFatGor.IsEmpty Then
    Exit;

  pGerarPDF(cdsFatGor.FieldByName('DOCUMENTO').AsString);
end;

procedure TfrmCadLeadOrcamentos.mnuGerarVendaPerdidaClick(Sender: TObject);
begin
  inherited;

  If Not mnuGerarVendaPerdida.Visible Then
    Exit;

  pGerarVendaPerdida(cdsFatGor.FieldByName('DOCUMENTO').AsString);
end;

procedure TfrmCadLeadOrcamentos.mnuReimprimirClick(Sender: TObject);
Var
  strNomeArquivo: String;
begin
  inherited;

  If (Not cdsFatGor.IsEmpty) And
     (Not fEmptyStr(cdsFatGor.FieldByName('FGO_SEQFGO').AsString)) Then
  Begin
    pImprimeFatImp('FATGOR',
                   cdsFatGor.FieldByName('FGO_NUMDOC').AsString,
                   cdsFatGor.FieldByName('FGO_ESPDOC').AsString,
                   cdsFatGor.FieldByName('FGO_CODEMP').AsString,
                   cdsFatGor.FieldByName('FGO_CODCLI').AsString,
                   'C',
                   '',
                   True,
                   strNomeArquivo,
                   False);
  End;
end;

procedure TfrmCadLeadOrcamentos.pExibirAlterar;
begin
  mnuAlterarDocumento.Visible := False;

  If (cdsFatGor.FieldByName('FGO_CODEMP').AsString <> VS_strCodEmp) Then
    Exit;

  mnuAlterarDocumento.Visible := True;
end;

procedure TfrmCadLeadOrcamentos.pExibirBaixar;
begin
  mnuBaixar.Visible := False;

  If cdsFatGor.IsEmpty Then
    Exit
  Else If (cdsFatGor.FieldByName('FGO_CODEMP').AsString <> VS_strCodEmp) Then
    Exit;

  mnuBaixar.Visible := fVerificaAcessoSistema('BAIPDV');
end;

procedure TfrmCadLeadOrcamentos.pExibirDesmembrar;
begin
  mnuDesmembrar.Visible := False;

  If cdsFatGor.IsEmpty Then
    Exit
  Else If (cdsFatGor.FieldByName('FGO_CODEMP').AsString <> VS_strCodEmp) Then
    Exit
  Else If (Pos('OR', cdsFatGor.FieldByName('DOCUMENTO').AsString) <= 0) And
          (Pos('PD', cdsFatGor.FieldByName('DOCUMENTO').AsString) <= 0) Then
    Exit
  Else If (cdsFatGor.FieldByName('FGO_STATUS').AsiNTEGER In [pvPedidoEmAberto.fGetId(),
                                                             pvSeparando.fGetId(),
                                                             pvAgFaturamento.fGetId()]) Then
    Exit;
  mnuDesmembrar.Visible := fVerificaAcessoSistema('frmFatDesmembrarPedido');
end;

procedure TfrmCadLeadOrcamentos.pExibirEfetivarOrcamento;
begin
  mnuEfetivarOrcamento.Visible := False;

  If cdsFatGor.IsEmpty Then
    Exit
  Else If (cdsFatGor.FieldByName('FGO_CODEMP').AsString <> VS_strCodEmp) Then
    Exit
  Else If Not fCfgSis('USAFPG', varBoolean) Then
    Exit
  Else If Not fCfgSis('USAPDV', varBoolean) Then
    Exit;

  mnuEfetivarOrcamento.Visible := True;
end;

procedure TfrmCadLeadOrcamentos.pExibirGerarVendaPerdida;
begin
  mnuGerarVendaPerdida.Visible := False;

  If cdsFatGor.IsEmpty Then
    Exit
  Else If (cdsFatGor.FieldByName('FGO_CODEMP').AsString <> VS_strCodEmp) Then
    Exit;

  mnuGerarVendaPerdida.Visible := True;
end;

procedure TfrmCadLeadOrcamentos.pExibirValidacaoSistemaDEPS;
begin
  mnuAnaliseCreditoDEPS.Visible := FblnUtilizaSistemaDEPS;

  If (Not FblnUtilizaSistemaDEPS) Then
    Exit;

  mnuAnaliseCreditoDEPS.Enabled := (Not cdsFatGor.IsEmpty);
end;


end.
