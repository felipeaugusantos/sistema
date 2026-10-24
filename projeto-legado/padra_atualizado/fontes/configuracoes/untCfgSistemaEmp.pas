unit untCfgSistemaEmp;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, UITypes,
  System.Classes, Vcl.Graphics, untCfgRepositorio, cxRadioGroup, Math,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Uni, untPaiConfirma, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData,
  cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData,
  cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxClasses, cxGridCustomView, cxGridCitel, cxGrid, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, cxDataControllerConditionalFormattingRulesManagerDialog,
  cxCheckBox, QColorLabel, EditFocus, UniClientDataset, System.Generics.Collections,
  cxProgressBar, untTypesSistema;

type
  TfrmCfgSistemaEmp = class(TfrmPaiConfirma)
    dtsCfgEmp: TDataSource;
    cxgCfgEmp: TcxGridCitel;
    cxgCfgEmpTable: TcxGridDBTableViewCitel;
    cxgCfgEmpTableSIS_CODEMP: TcxGridDBColumn;
    cxgCfgEmpTableEMP_NOMEMP: TcxGridDBColumn;
    cxgCfgEmpTableSIS_VALCFG: TcxGridDBColumn;
    cxgCfgEmpLevel: TcxGridLevel;
    btnMarcaTodas: TBitBtnLocked;
    cxgCfgEmpTableEMP_NOMFAN: TcxGridDBColumn;
    cxgCfgEmpTableEMP_SIGLA_: TcxGridDBColumn;
    Panel1: TPanel;
    edtCodCfg: TEditFocus;
    edtDesCfg: TEditFocus;
    pnlLegenda: TPanel;
    shpLegCfgAlt: TShape;
    Label1: TLabel;
    cxgCfgEmpTableSIS_VALANT: TcxGridDBColumn;
    lblInformacoes: TLabel;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnMarcaTodasClick(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure cxgCfgEmpTableSIS_VALCFGGetProperties(Sender: TcxCustomGridTableItem;
      ARecord: TcxCustomGridRecord; var AProperties: TcxCustomEditProperties);
    procedure cxgCfgEmpTableSIS_VALCFGGetDataText(Sender: TcxCustomGridTableItem;
      ARecordIndex: Integer; var AText: string);
    procedure FormResize(Sender: TObject);
    procedure cxgCfgEmpTableCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure cxgCfgEmpTableEditing(Sender: TcxCustomGridTableView;
      AItem: TcxCustomGridTableItem; var AAllow: Boolean);
  private
    FDicAlt: TDictionary<String,String>;
    FEmpAlt: TstringList;
    FCdsCfg: TUniClientDataset;
    FCfgRep: TfrmCfgRepositorio;
    FfncPermitirEditarConfiguracao : TfncPermitirEditarConfiguracao;
  private
    function fTemAlteracoes: Boolean;
    function fCarregarEmpresas(AProgresso: TcxProgressBar): Boolean;
    function fGravarConfiguracoes(AProgresso: TcxProgressBar): Boolean;
    procedure pAtualizarConfiguracaoPorEmpresa(strCodEmp, strCodCfg, strValAnt, strValCfg: String);
    procedure pCopiarParaTodasEmpresas;
    procedure pCriptografarConfiguracoes(AProgresso: TcxProgressBar);
    procedure pDescriptografarConfiguracoes(AProgresso: TcxProgressBar);
    function fPermitirEditarConfiguracao(const strCodigoConfiguracao : String) : Boolean;
    procedure pExibirInformativoDePermissao;
  public
    procedure pFiltrarEmpresa(ACodEmp: string);
  public
    property cdsCfgSis: TUniClientDataset Read FCdsCfg;
    property dicAlteracoes: TDictionary<String,String> Read FDicAlt;
    property stlEmpAlteradas: TstringList read FEmpAlt;
    property cfgRepositorio: TfrmCfgRepositorio read FCfgRep write FCfgRep;
    property fncPermitirEditarConfiguracao : TfncPermitirEditarConfiguracao read FfncPermitirEditarConfiguracao write FfncPermitirEditarConfiguracao;
  end;

implementation

{$R *.dfm}

uses untFuncoesSimples, untCfgSistemaValidar,
  untSaldoPedidoCompra, untGravando;

procedure TfrmCfgSistemaEmp.btnMarcaTodasClick(Sender: TObject);
begin
  If (Not fPermitirEditarConfiguracao(edtCodCfg.Text)) Then
  Begin
    pMensagemOK('Operador só pode alterar configurações de uso exclusivo Citel');
    Exit;
  End;
  inherited;
  pCopiarParaTodasEmpresas;
end;

procedure TfrmCfgSistemaEmp.cxgCfgEmpTableCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
var
  strValCfg: String;
  strValAnt: String;
begin
  inherited;
  If AViewInfo.GridRecord.IsData And (AViewInfo.GridRecord.Index > -1) Then
  Begin
    strValCfg := VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgCfgEmpTableSIS_VALCFG.Index]);
    strValAnt := VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgCfgEmpTableSIS_VALANT.Index]);
    If strValCfg <> strValAnt Then
      ACanvas.Font.Color := shpLegCfgAlt.Brush.Color;
  End;
end;

procedure TfrmCfgSistemaEmp.cxgCfgEmpTableEditing(
  Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
  var AAllow: Boolean);
  Var
    strCodCfg : String;
begin
  inherited;
  Try
    strCodCfg := FCdsCfg.FieldByName('SIS_CODCFG').AsString;
  Except
    strCodCfg := EmptyStr;
  End;
  AAllow := fPermitirEditarConfiguracao(strCodCfg);
end;

procedure TfrmCfgSistemaEmp.cxgCfgEmpTableSIS_VALCFGGetDataText(
  Sender: TcxCustomGridTableItem; ARecordIndex: Integer; var AText: string);
begin
  inherited;
  If Assigned(FCfgRep) Then
    FCfgRep.pOnGetDataTextSIS_VALCFG(Sender, ARecordIndex, AText);
end;

procedure TfrmCfgSistemaEmp.cxgCfgEmpTableSIS_VALCFGGetProperties(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AProperties: TcxCustomEditProperties);
begin
  inherited;
  If Assigned(ARecord) And Assigned(FCfgRep) Then
  begin
    FCfgRep.pRetProperties(edtCodCfg.Text, AProperties);
    if AProperties is TcxRadioGroupProperties then
      TcxRadioGroupProperties(AProperties).WordWrap := True;
  end;
end;

procedure TfrmCfgSistemaEmp.btnConfirmaClick(Sender: TObject);
begin
  If (Not fPermitirEditarConfiguracao(edtCodCfg.Text)) Then
  Begin
    pMensagemOK('Operador só pode alterar configurações de uso exclusivo Citel');
    Exit;
  End;

  cxgCfgEmpTable.DataController.Filter.Clear;

  if fTemAlteracoes then
    if not fPergunta('Confirma atualizar valor da configuração nas empresas?') then
      Exit;

  ModalResult := mrOk;

  fExecutarModal(fGravarConfiguracoes, 'Aguarde, Atualizando configuração por empresa ...', '');
  fExecutarModal(TValidarConfiguracoes.pAtualizarVariaveisDeSistema, 'Aguarde, atualizando variáveis de sistema!', '');
end;

procedure TfrmCfgSistemaEmp.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  FCdsCfg.AfterPost  := nil;
  FCdsCfg.BeforeEdit := nil;
  FCdsCfg.BeforePost := nil;
  dtsCfgEmp.DataSet  := Nil;
  FCdsCfg.FieldByName('SIS_VALCFG').OnChange := Nil;
  FfncPermitirEditarConfiguracao := Nil;
end;

procedure TfrmCfgSistemaEmp.FormCreate(Sender: TObject);
begin
  inherited;
  FDicAlt := TDictionary<String,String>.Create;
  FEmpAlt := TstringList.Create;
  dicConfiguracoes.Clear;
  FfncPermitirEditarConfiguracao := Nil;
end;

procedure TfrmCfgSistemaEmp.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(FEmpAlt);
  FreeAndNil(FDicAlt);
end;

procedure TfrmCfgSistemaEmp.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_F6:
      btnMarcaTodas.Click;
    VK_F10:
      btnConfirma.Click;
  End;
end;

procedure TfrmCfgSistemaEmp.FormResize(Sender: TObject);
begin
  inherited;
  cxgCfgEmpTableSIS_CODEMP.Width := 50;
  cxgCfgEmpTableEMP_SIGLA_.Width := 50;
  cxgCfgEmpTableEMP_NOMEMP.Width := Floor(Self.Width * 0.3);
  cxgCfgEmpTableEMP_NOMFAN.Width := Floor(Self.Width * 0.3);
  cxgCfgEmpTableSIS_VALCFG.Width := Floor(Self.Width * 0.4) - 200;
end;

procedure TfrmCfgSistemaEmp.FormShow(Sender: TObject);
begin
  inherited;
  fExecutarModal(fCarregarEmpresas, 'Aguarde, carregando empresas ...', '');
  pExibirInformativoDePermissao;
end;

function TfrmCfgSistemaEmp.fTemAlteracoes: Boolean;
var
  LRecNo: Integer;
begin
  FEmpAlt.Clear;
  LRecNo := FCdsCfg.RecNo;
  FCdsCfg.DisableControls;
  FCdsCfg.First;
  While Not FCdsCfg.Eof Do
  Begin
    If FCdsCfg.FieldByName('SIS_VALANT').Value <> FCdsCfg.FieldByName('SIS_VALCFG').Value Then
      FEmpAlt.Add(FCdsCfg.FieldByName('SIS_CODEMP').AsString);
    FCdsCfg.Next;
  End;
  FCdsCfg.RecNo := LRecNo;
  FCdsCfg.EnableControls;
  Result := FEmpAlt.Count > 0;
end;

procedure TfrmCfgSistemaEmp.pAtualizarConfiguracaoPorEmpresa(strCodEmp, strCodCfg, strValAnt, strValCfg: String);
var
  LQuery: TUniQuery;
begin
  LQuery := fCriaQuery;
  Try
    LQuery.Close;
    LQuery.SQL.Text := 'SELECT * FROM CFGSIS WHERE SIS_CODCFG = :CODCFG AND SIS_CODEMP = :CODEMP';
    LQuery.ParamByName('CODCFG').AsString := strCodCfg;
    LQuery.ParamByName('CODEMP').AsString := strCodEmp;
    LQuery.Open;

    LQuery.Edit;
    LQuery.FieldByName('SIS_VALCFG').AsString := strValCfg;
    LQuery.Post;

    LQuery.Close;
    LQuery.SQL.Text := 'SELECT * FROM LOGCFG WHERE FALSE';
    LQuery.Open;
    LQuery.Append;
    LQuery.FieldByName('AUTOINCREM').AsString   := fRetAutoIncrem('LOGCFG', VS_strCodEmp);
    LQuery.FieldByName('LOG_DTAALT').AsDateTime := VS_Date;
    LQuery.FieldByName('LOG_HORALT').AsDateTime := fTime();
    LQuery.FieldByName('LOG_CODOPE').AsString   := strLoginUsuarioLogado;
    LQuery.FieldByName('LOG_CODEMP').AsString   := VS_strCodEmp;
    LQuery.FieldByName('LOG_EMPCFG').AsString   := strCodEmp;
    LQuery.FieldByName('LOG_CODCFG').AsString   := strCodCfg;
    LQuery.FieldByName('LOG_VALANT').AsString   := strValAnt;
    LQuery.FieldByName('LOG_VALATU').AsString   := strValCfg;
    LQuery.Post;
  Finally
    FreeAndNil(LQuery);
  End;
end;

function TfrmCfgSistemaEmp.fCarregarEmpresas(AProgresso: TcxProgressBar): Boolean;
var
  LQuery: TUniQuery;
Begin
  LQuery := fCriaQuery;
  Try
    LQuery.Close;
    LQuery.SQL.Clear;
    LQuery.SQL.Add('SELECT        ');
    LQuery.SQL.Add('  SIS_GRUCFG, ');
    LQuery.SQL.Add('  SIS_CODEMP, ');
    LQuery.SQL.Add('  EMP_SIGLA_, ');
    LQuery.SQL.Add('  EMP_NOMEMP, ');
    LQuery.SQL.Add('  EMP_NOMFAN, ');
    LQuery.SQL.Add('  SIS_CODCFG, ');
    LQuery.SQL.Add('  SIS_DESCRI, ');
    LQuery.SQL.Add('  SIS_VALCFG, ');
    LQuery.SQL.Add('  SIS_VALCFG AS SIS_VALORI, ');
    LQuery.SQL.Add('  SIS_VALCFG AS SIS_VALANT  ');
    LQuery.SQL.Add('FROM          ');
    LQuery.SQL.Add('  CADEMP      ');
    LQuery.SQL.Add('  JOIN CFGSIS ');
    LQuery.SQL.Add('    ON SIS_CODEMP = EMP_CODEMP ');
    LQuery.SQL.Add('    AND SIS_CODCFG = :CODCFG ');
    LQuery.SQL.Add('ORDER BY EMP_CODEMP ');
    LQuery.ParamByName('CODCFG').AsString := edtCodCfg.Text;
    LQuery.Open;

    cxgCfgEmp.BeginUpdate();
    Try
      FCdsCfg := fCriaClientdatset(LQuery, False, Self);

      FCdsCfg.IndexFieldNames := 'SIS_CODCFG;SIS_CODEMP';

      TValidarConfiguracoes.cdsCfgSis      := Self.FCdsCfg;
      TValidarConfiguracoes.dicAlteracoes  := Self.FDicAlt;
      TValidarConfiguracoes.cfgRepositorio := Self.FCfgRep;
      TValidarConfiguracoes.cxDBTableView  := Self.cxgCfgEmpTable;

      pDescriptografarConfiguracoes(AProgresso);

      FCdsCfg.FieldByName('SIS_CODEMP').Alignment := taCenter;
      FCdsCfg.FieldByName('EMP_SIGLA_').Alignment := taCenter;
      FCdsCfg.FieldByName('SIS_VALCFG').OnChange  := TValidarConfiguracoes.pOnChangeValCfg;

      FCdsCfg.AfterPost  := TValidarConfiguracoes.cdsCfgSisAfterPost;
      FCdsCfg.BeforeEdit := TValidarConfiguracoes.cdsCfgSisBeforeEdit;
      FCdsCfg.BeforePost := TValidarConfiguracoes.cdsCfgSisBeforePost;

      Self.dtsCfgEmp.DataSet := FCdsCfg;
    Finally
      cxgCfgEmp.EndUpdate();
    End;
    cxgCfgEmpTable.DataController.GotoFirst;
    Result := True;
  Finally
    FreeAndNil(LQuery);
  End;
End;

procedure TfrmCfgSistemaEmp.pCopiarParaTodasEmpresas;
Var
  LValCfg: String;
begin
  If Not fPergunta('Confirma copiar o valor da configuração para todas as empresas?') Then
    Exit;
  LValCfg := FCdsCfg.FieldByName('SIS_VALCFG').AsString;
  cxgCfgEmpTable.DataController.Filter.Clear;
  FCdsCfg.DisableControls;
  FCdsCfg.First;
  While Not FCdsCfg.Eof Do
  Begin
    FCdsCfg.Edit;
    FCdsCfg.FieldByName('SIS_VALCFG').AsString := LValCfg;
    FCdsCfg.Post;
    FCdsCfg.Next;
  End;
  FCdsCfg.First;
  FCdsCfg.EnableControls;
end;

procedure TfrmCfgSistemaEmp.pCriptografarConfiguracoes(AProgresso: TcxProgressBar);
var
  LIndex: Integer;
  LEmpLog: string;
  LEmpresas: TStringList;
begin
  LEmpLog := VS_strCodEmp;
  LEmpresas := TStringList.Create;
  try
    LEmpresas.CommaText := fRetListaEmpresas;
    AProgresso.Properties.Max := LEmpresas.Count;
    for LIndex := 0 to LEmpresas.Count-1 do
    begin
      AProgresso.Position := Succ(LIndex);
      pProcessMessages;
      try
        pSetaEmpresaLogada(LEmpresas[LIndex]);
        pFiltrarEmpresa(LEmpresas[LIndex]);
        if not FCdsCfg.IsEmpty Then
        begin
          TValidarConfiguracoes.pEncriptarConfiguracoes;
          FCdsCfg.Edit;
          FCdsCfg.FieldByName('SIS_VALANT').AsString := FCdsCfg.FieldByName('SIS_VALORI').AsString;
          FCdsCfg.Post;
        end;
      finally
        pSetaEmpresaLogada(LEmpLog);
      end;
    end;
    FCdsCfg.Filtered := False;
  finally
    LEmpresas.Free;
  end;
end;

procedure TfrmCfgSistemaEmp.pDescriptografarConfiguracoes(AProgresso: TcxProgressBar);
var
  LIndex: Integer;
  LEmpLog: string;
  LEmpresas: TStringList;
begin
  LEmpLog := VS_strCodEmp;
  LEmpresas := TStringList.Create;
  try
    LEmpresas.CommaText := fRetListaEmpresas;
    AProgresso.Properties.Max := LEmpresas.Count;
    for LIndex := 0 to LEmpresas.Count-1 do
    begin
      AProgresso.Position := Succ(LIndex);
      pProcessMessages;
      try
        pSetaEmpresaLogada(LEmpresas[LIndex]);
        pFiltrarEmpresa(LEmpresas[LIndex]);
        if not FCdsCfg.IsEmpty Then
        begin
          TValidarConfiguracoes.pDecriptarConfiguracoes;
          FCdsCfg.Edit;
          FCdsCfg.FieldByName('SIS_VALANT').AsString := FCdsCfg.FieldByName('SIS_VALCFG').AsString;
          FCdsCfg.Post;
        end;
      finally
        pSetaEmpresaLogada(LEmpLog);
      end;
    end;
    FCdsCfg.Filtered := False;
  finally
    LEmpresas.Free;
  end;
end;

procedure TfrmCfgSistemaEmp.pFiltrarEmpresa(ACodEmp: string);
begin
  FCdsCfg.Filtered := False;
  FCdsCfg.Filter   := 'SIS_CODEMP = ' + QuotedStr(ACodEmp);
  FCdsCfg.Filtered := True;
end;

function TfrmCfgSistemaEmp.fGravarConfiguracoes(AProgresso: TcxProgressBar): Boolean;
var
  LIndex: Integer;
  LEmpLog: string;
  LEmpAlt: string;
  lblGravando: TLabel;
begin
  Result := False;

  LEmpLog := VS_strCodEmp;

  lblGravando := TLabel(GetParentForm(AProgresso).FindComponent('lblGravando'));

  TValidarConfiguracoes.lblInformacao  := Self.lblInformacoes;

  FCdsCfg.AfterPost  := nil;
  FCdsCfg.BeforeEdit := nil;
  FCdsCfg.BeforePost := nil;
  FCdsCfg.FieldByName('SIS_VALCFG').OnChange := Nil;

  FCdsCfg.DisableControls;

  Self.pCriptografarConfiguracoes(AProgresso);

  AProgresso.Properties.Max := Self.stlEmpAlteradas.Count;

  For LIndex := 0 To Self.stlEmpAlteradas.Count -1 Do
  Begin
    LEmpAlt := Self.stlEmpAlteradas[LIndex];
    lblGravando.Caption := 'Validando configuracoes da Empresa ' + LEmpAlt + ' ...';
    AProgresso.Position := Succ(LIndex);
    pProcessMessages(True);

    Try
      pSetaEmpresaLogada(LEmpAlt);

      Self.pFiltrarEmpresa(LEmpAlt);

      TValidarConfiguracoes.blnAdicionarConfigDuranteValidacao := True;

      If TValidarConfiguracoes.fValidarConfiguracoes Then
      Begin
        Try
          fStartTransaction;

          lblGravando.Caption := 'Atualizando Planos de Recebimento ...';
          pProcessMessages;

          TValidarConfiguracoes.pAtualizarStatusPlanosRecebimento;

          lblGravando.Caption := 'Normalizando dados PLP dos Correios ...';
          pProcessMessages;

          TValidarConfiguracoes.pNormalizaDadosAlteracaoROMPLP;

          lblGravando.Caption := 'Atualizando layouts de Autocenter ...';
          pProcessMessages;

          TValidarConfiguracoes.pAtualizaLayoutAutocenter;

          lblGravando.Caption := 'Atualizando valor da configuração ...';
          pProcessMessages(True);

          If Not TValidarConfiguracoes.fFindCfg(edtCodCfg.Text) Then
            Raise Exception.Create('Não foi encontrada a configuração ' + edtCodCfg.Text);

          pAtualizarConfiguracaoPorEmpresa(FCdsCfg.FieldByName('SIS_CODEMP').AsString,
                                           FCdsCfg.FieldByName('SIS_CODCFG').AsString,
                                           FCdsCfg.FieldByName('SIS_VALANT').AsString,
                                           FCdsCfg.FieldByName('SIS_VALCFG').AsString);

          If TValidarConfiguracoes.blnAtualizarComissaoProfissionais Then
          Begin
            lblGravando.Caption := 'Atualizando comissão dos profissionais ...';
            pProcessMessages;
            TValidarConfiguracoes.pAtualizarComissaoProfissionais;
          End;

          If TValidarConfiguracoes.blnBaixaPedidosEnderecamento Then
          Begin
            lblGravando.Caption := 'Baixando Pedidos de Endereçamento ...';
            pProcessMessages;
            TValidarConfiguracoes.pBaixaPedidosEnderecamento;
          End;

          If TValidarConfiguracoes.blnAtualizarSaldoPedido Then
          Begin
            lblGravando.Caption := 'Atualizando Saldo Pedidos de Compra ...';
            pProcessMessages;

            If fAtualizaSaldoPedidoCompraGeral Then
              fCommit
            Else
              fRollBack;
          End
          Else
            fCommit;
        Except
          On E: Exception Do
          Begin
            fRollBack;
            pMensagensErro(E.Message, 'TfrmCfgSistemaEmp.fGravarConfiguracoes');
          End;
        End;
        Result := True;
      End
      Else
        pMensagemOK('Não foi possível atualizar o valor da configuração na empresa ' + LEmpAlt + '.' +
          sLineBreak + 'Existem inconsistências nas configurações da empresa.');
    Finally
      pSetaEmpresaLogada(LEmpLog);
    End;
    Application.ProcessMessages;
  End;
end;

function TfrmCfgSistemaEmp.fPermitirEditarConfiguracao(const strCodigoConfiguracao: String): Boolean;
begin
  Result := True;
  If (Not Assigned(FfncPermitirEditarConfiguracao)) Then
    Exit;
  Result := FfncPermitirEditarConfiguracao(strCodigoConfiguracao);
end;

procedure TfrmCfgSistemaEmp.pExibirInformativoDePermissao;
begin
  If fPermitirEditarConfiguracao(edtCodCfg.Text) Then
    Exit;
  pnlInfo.Caption := '* Operador só pode alterar configurações de uso exclusivo Citel *';
end;

end.
