unit untCadMetaVendedoresPorFaturamentoRentabilidadePorEmpresa;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, Vcl.Mask, MaskEditFocus, EditFocus,
  Vcl.ComCtrls, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, Datasnap.DBClient,
  UniClientDataSet, Uni, Vcl.Grids, Vcl.DBGrids, DBAccess, cxProgressBar,
  DBGridCitel;

type
  TfrmCadMetaVendedoresPorFaturamentoRentabilidadePorEmpresa = class(TfrmPai)
    pnlHeader: TPanel;
    lblPeriodoAtual: TLabel;
    lblEmpresa: TLabel;
    shpCodEmp: TShape;
    edtNomEmp: TEditFocus;
    pnlMesAnoOrigem: TPanel;
    lblCopiarMetasDoPeriodoOrigem: TLabel;
    bvlSeparador: TBevel;
    mskDtaOrigem: TMaskEditFocus;
    mskDtaAtual: TMaskEditFocus;
    edtCodEmp: TEditFocus;
    pgcDados: TPageControl;
    tbsMetaDeVendedorFaturamento: TTabSheet;
    tbsMetaDeRentabilidadeEmpresa: TTabSheet;
    cxgMetaVendedorFaturamento: TcxGrid;
    cxgVendedorFaturamentoView: TcxGridDBTableView;
    cxgVendedorFaturamento: TcxGridLevel;
    btnConfirmar: TBitBtnLocked;
    btnCopiarMetas: TBitBtnLocked;
    dscMetasVendedores: TDataSource;
    dscMetasEmpresas: TDataSource;
    cxgVendedorFaturamentoViewCODVEN: TcxGridDBColumn;
    cxgVendedorFaturamentoViewNOMVEN: TcxGridDBColumn;
    cxgVendedorFaturamentoViewNOMFUN: TcxGridDBColumn;
    cxgVendedorFaturamentoViewVALFAT: TcxGridDBColumn;
    cxgVendedorFaturamentoViewPREM01: TcxGridDBColumn;
    cxgVendedorFaturamentoViewPREM02: TcxGridDBColumn;
    cxgVendedorFaturamentoViewPREM03: TcxGridDBColumn;
    cxStyleRepository: TcxStyleRepository;
    CorFundoCelulasEditaveis: TcxStyle;
    cxgMetaRentabilidadeEmpresa: TcxGrid;
    cxgRentabilidadeEmpresaView: TcxGridDBTableView;
    cxgRentabilidadeEmpresa: TcxGridLevel;
    cxgRentabilidadeEmpresaViewCODEMP: TcxGridDBColumn;
    cxgRentabilidadeEmpresaViewNOMEMP: TcxGridDBColumn;
    cxgRentabilidadeEmpresaViewMARGEM: TcxGridDBColumn;
    cxgRentabilidadeEmpresaViewPREMIO: TcxGridDBColumn;
    cxgVendedorFaturamentoViewPREM04: TcxGridDBColumn;
    tbsPremioRentabilidadeSemAtingirMeta: TTabSheet;
    cxgRentabilidadeEmpresaViewPRE1AB: TcxGridDBColumn;
    cxgRentabilidadeEmpresaViewPRE1AC: TcxGridDBColumn;
    cxgRentabilidadeEmpresaViewPRE2AC: TcxGridDBColumn;
    dbgSemMeta: TDBGridCitel;
    GroupBox1: TGroupBox;
    edtVlrInicial: TEditFocus;
    btnAdicionar: TBitBtnLocked;
    btnCancelar: TBitBtnLocked;
    lblValorInicial: TLabel;
    edtVlrFinal: TEditFocus;
    lblValorFinal: TLabel;
    edtVlrPremiacao: TEditFocus;
    lblPremiacao: TLabel;
    dscSemMeta: TDataSource;
    TSemMeta: TUniClientDataSet;
    TSemMetaMET_FATINI: TFloatField;
    TSemMetaMET_FATFIN: TFloatField;
    TSemMetaMET_PREMIO: TFloatField;
    btnParam: TBitBtnLocked;
    tbsMetaDeRentabilidadeVendedor: TTabSheet;
    cxgMetaRentabilidadeVendedor: TcxGrid;
    cxgRentabilidadeVendedorView: TcxGridDBTableView;
    cxGridDBColumn1: TcxGridDBColumn;
    cxGridDBColumn2: TcxGridDBColumn;
    cxGridDBColumn3: TcxGridDBColumn;
    cxGridDBColumn4: TcxGridDBColumn;
    cxGridDBColumn5: TcxGridDBColumn;
    cxGridDBColumn6: TcxGridDBColumn;
    cxGridDBColumn7: TcxGridDBColumn;
    cxGridLevel1: TcxGridLevel;
    dscRentaVendedores: TDataSource;
    procedure FormShow(Sender: TObject);
    procedure edtCodEmpExit(Sender: TObject);
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure btnConfirmarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnCopiarMetasClick(Sender: TObject);
    procedure cxgVendedorFaturamentoViewEditKeyDown(
      Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
      AEdit: TcxCustomEdit; var Key: Word; Shift: TShiftState);
    procedure cxgRentabilidadeEmpresaViewEditKeyDown(
      Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
      AEdit: TcxCustomEdit; var Key: Word; Shift: TShiftState);
    procedure btnAdicionarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure dbgSemMetaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dbgSemMetaDblClick(Sender: TObject);
    procedure btnParamClick(Sender: TObject);
    procedure pgcDadosChange(Sender: TObject);
  private

    FcdsMetasVendedores : TUniClientDataSet;
    FcdsMetasEmpresas   : TUniClientDataSet;
    FcdsRentaVendedores : TUniClientDataSet;

    procedure pAddCampo(ADataSet   : TUniClientDataSet;
                        AFieldName : String;
                        AFieldType : TFieldType;
                        ASize      : Integer = 0);

    procedure pCopiarMeta(AMesAno, ACodEmp : String);
    procedure pSetaValoresDefaultTela;
    procedure pCriarClientsTemporarios;
    procedure pLimparClientsTemporarios;
    procedure pCarregarDados(AMesAno, ACodEmp : String);
    procedure pCarregarMesAnoInformado(AMesAno, ACodEmp : String);
    procedure pCarregarMesAnoInformadoNovo(AMesAno, ACodEmp : String);
    procedure pCarregarPremioRentabilidadeSemAtingirMeta;
    procedure pRegravarPremioRentabilidadeSemAtingirMeta;
    procedure pInfoStatusGravacao(strInformacao: String; pgbProgresso: TcxProgressBar);
    procedure pStepStatusGravacao(pgbProgresso: TcxProgressBar);

    procedure pLimparPremioRentabilidadeSemAtingirMeta;
    function fEhEdicao : Boolean;

    function fRetSQLEmpresas(AMesAno, ACodEmp : String) : String;
    function fRetSQLRentaVendedores(AMesAno, ACodEmp : String) : String;
    function fRetSQLVendedores(AMesAno, ACodEmp : String) : String;

    function fPeriodoJaGravado(AMesAno, ACodEmp : String) : Boolean;
    function fRetSQLCaseFuncao : String;
    function fApagarDados(AMesAno, ACodEmp : String) : Boolean;
    function fSalvarDados(AMesAno, ACodEmp : String; pgbProgresso: TcxProgressBar) : Boolean;
    function fSalvarDadosInterna(pgbProgresso: TcxProgressBar) : Boolean;
    procedure pCarregaParametrizacao;
    procedure pPreencheParametrizacao(fltVlrFat: Double);

    procedure AtualizaValoresParametrizacao;

  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public

  end;

implementation

uses
  untFuncoesSimples, untTypesSistema, untFuncoesConsulta, untConsultas,
  untGravando, untCadParamPremios, untParPre, untParPreController;

{$R *.dfm}

{ TfrmCadMetaVendedoresPorFaturamentoRentabilidadePorEmpresa }

procedure TfrmCadMetaVendedoresPorFaturamentoRentabilidadePorEmpresa.AtualizaValoresParametrizacao;
  Var
    LRecNo: Integer;
begin
  If fMensagem('ATENÇÃO','Os valores de parametrização foram atualizados. Deseja atualizar os valores para o mês selecionado?', ['&Sim', '&Não']) = 2 Then
    Exit;

  FcdsMetasVendedores.DisableControls;

  Try
    FcdsMetasVendedores.First;

    While Not FcdsMetasVendedores.Eof Do
    Begin
      LRecNo := FcdsMetasVendedores.RecNo;

      pPreencheParametrizacao(FcdsMetasVendedores.FieldByName('FAD_VALFAT').AsFloat);

      If LRecNo = FcdsMetasVendedores.RecNo Then
        FcdsMetasVendedores.Next;
    End;
  Finally
    FcdsMetasVendedores.First;
    FcdsMetasVendedores.EnableControls;
  End;
end;

procedure TfrmCadMetaVendedoresPorFaturamentoRentabilidadePorEmpresa.btnAdicionarClick(Sender: TObject);
begin
  inherited;

  If (fStrToFloat(edtVlrInicial.Text) < 0) Then
  Begin
    fMensagem('', 'Informe um valor válido para Valor de Faturamento Inicial!', ['&Ok']);
    pSetFocus(edtVlrInicial);
    Exit;
  End;

  If (fStrToFloat(edtVlrFinal.Text) <= 0) Then
  Begin
    fMensagem('', 'Informe um valor válido para Valor de Faturamento Final!', ['&Ok']);
    pSetFocus(edtVlrFinal);
    Exit;
  End;

  If (fStrToFloat(edtVlrPremiacao.Text) <= 0) Then
  Begin
    fMensagem('', 'Informe um valor válido para Premiação!', ['&Ok']);
    pSetFocus(edtVlrPremiacao);
    Exit;
  End;

  If (Not fEhEdicao) Then
    TSemMeta.Append;

  TSemMetaMET_FATINI.AsFloat := fStrToFloat(edtVlrInicial.Text);
  TSemMetaMET_FATFIN.AsFloat := fStrToFloat(edtVlrFinal.Text);
  TSemMetaMET_PREMIO.AsFloat := fStrToFloat(edtVlrPremiacao.Text);
  TSemMeta.Post;

  If (fEhEdicao) Then
    dbgSemMeta.Enabled := True;

  pLimparPremioRentabilidadeSemAtingirMeta;
  pSetFocus(edtVlrInicial);

end;

procedure TfrmCadMetaVendedoresPorFaturamentoRentabilidadePorEmpresa.btnCancelarClick(Sender: TObject);
begin
  inherited;
  pLimparPremioRentabilidadeSemAtingirMeta;

  If (fEhEdicao) Then
  Begin

    If (TSemMeta.Active) And (Not TSemMeta.IsEmpty) Then
      If (TSemMeta.State in ([dsEdit])) Then
        TSemMeta.Cancel;

    dbgSemMeta.Enabled := True;

  End;

  pSetFocus(edtVlrInicial);
end;

procedure TfrmCadMetaVendedoresPorFaturamentoRentabilidadePorEmpresa.btnConfirmarClick(Sender: TObject);
  var
    frmGravando : TfrmGravando;
begin
  inherited;

  pCriarFormularios(TfrmGravando, frmGravando);

  Try

    Try

      frmGravando.fExecutarAcao := fSalvarDadosInterna;
      frmGravando.ShowModal;

      If frmGravando.blnConfirma Then
        fMensagem('', 'As metas foram salvas com sucesso!', ['&Ok']);

    Except
      On E: Exception Do
        pMensagensErro(E.Message, '');
    End;

  Finally
    pFreeAndNil(frmGravando);
  End;

end;

procedure TfrmCadMetaVendedoresPorFaturamentoRentabilidadePorEmpresa.btnCopiarMetasClick(Sender: TObject);
begin
  inherited;

  If Not Assigned(FcdsMetasEmpresas) Then
    Exit;

  If Not Assigned(FcdsMetasVendedores) Then
    Exit;

  If Not Assigned(FcdsRentaVendedores) Then
    Exit;

  If (FcdsMetasEmpresas.IsEmpty And FcdsMetasVendedores.IsEmpty) And FcdsRentaVendedores.IsEmpty  Then
    Exit;

  If pnlMesAnoOrigem.Visible Then
  Begin
    pnlMesAnoOrigem.Visible := False;
    mskDtaOrigem.Clear;
    Exit;
  End;

  pnlMesAnoOrigem.Visible := True;
  blnMudarFoco := True;

  pSetFocus(mskDtaOrigem);

end;

procedure TfrmCadMetaVendedoresPorFaturamentoRentabilidadePorEmpresa.btnParamClick(
  Sender: TObject);
begin
  inherited;
  pCarregaParametrizacao;
end;

procedure TfrmCadMetaVendedoresPorFaturamentoRentabilidadePorEmpresa.pCarregaParametrizacao;
  Var
    frmCadParamPremios: TfrmCadParamPremios;
begin
  pCriarFormularios(TfrmCadParamPremios, frmCadParamPremios);

  Try
    frmCadParamPremios.ShowModal;

    If (frmCadParamPremios.ParametrizacaoAtualizada) Then
      TfrmGravando.fExecutarModal(AtualizaValoresParametrizacao, 'Atualizando parametrização... Aguarde...','');
  Finally
    pFreeAndNil(frmCadParamPremios);
  End;
end;

procedure TfrmCadMetaVendedoresPorFaturamentoRentabilidadePorEmpresa.edtCodEmpExit(Sender: TObject);
  Var
    arrEmp: TConsultasArray;
begin
  inherited;
  pEdtCodSelectExit(edtCodEmp, edtNomEmp, arrEmp, Nil, fRetNomeEmpresaSelec, 'da empresa');
end;

procedure TfrmCadMetaVendedoresPorFaturamentoRentabilidadePorEmpresa.edtCodEmpKeyPress(Sender: TObject; var Key: Char);
  Var
    arrEmp: TConsultasArray;
begin
  inherited;

  If (Not fVerificaAcessoSistema('METREN')) Then
    Exit;

  If fPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtNomEmp, Nil, Key, arrEmp, True, True) Then
  Begin
    If fValidaCampos(edtCodEmp, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmCadMetaVendedoresPorFaturamentoRentabilidadePorEmpresa.fApagarDados(AMesAno, ACodEmp: String): Boolean;
  var
    qryTmp : TUniQuery;
begin

  qryTmp := fCriaQuery;

  Try

    Try

      qryTmp.Close;
      qryTmp.SQL.Clear;
      qryTmp.SQL.Add('DELETE FROM METFAG WHERE MET_MESANO = :MESANO');
      qryTmp.ParamByName('MESANO').AsString := AMesAno;

      If Not ACodEmp.IsEmpty Then
      Begin
        qryTmp.SQL.Add('AND MET_CODEMP = :CODEMP');
        qryTmp.ParamByName('CODEMP').AsString := ACodEmp;
      End;

      qryTmp.ExecSQL;
      Result := True;

    Except
      On E: Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, '');
      End;
    End;

  Finally
    FreeAndNil(qryTmp);
  End;

end;

function TfrmCadMetaVendedoresPorFaturamentoRentabilidadePorEmpresa.fEhEdicao: Boolean;
begin
  Result := Not dbgSemMeta.Enabled;
end;

procedure TfrmCadMetaVendedoresPorFaturamentoRentabilidadePorEmpresa.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  Case (Key) Of
    VK_F10: btnConfirmar.Click;
    VK_F11: btnCopiarMetas.Click;
    VK_F12: btnParam.Click;
  End;
end;

procedure TfrmCadMetaVendedoresPorFaturamentoRentabilidadePorEmpresa.FormShow(Sender: TObject);
begin
  inherited;
  pSetaValoresDefaultTela;
end;

function TfrmCadMetaVendedoresPorFaturamentoRentabilidadePorEmpresa.fPeriodoJaGravado(AMesAno, ACodEmp: String): Boolean;
  var
    qryTmp : TUniQuery;
begin

  qryTmp := fCriaQuery;

  Try

    qryTmp.Close;
    qryTmp.SQL.Clear;
    qryTmp.SQL.Add('SELECT COUNT(*) AS TOT FROM METFAG WHERE MET_MESANO = :MESANO');
    qryTmp.ParamByName('MESANO').AsString := AMesAno;

    If Not ACodEmp.IsEmpty Then
    Begin
      qryTmp.SQL.Add('AND MET_CODEMP = :CODEMP');
      qryTmp.ParamByName('CODEMP').AsString := ACodEmp;
    End;

    qryTmp.Open;

    Result := (Not qryTmp.IsEmpty) And (qryTmp.FieldByName('TOT').AsInteger > 0);

  Finally
    FreeAndNil(qryTmp);
  End;

end;

function TfrmCadMetaVendedoresPorFaturamentoRentabilidadePorEmpresa.fRetSQLCaseFuncao: String;
begin

  Result := '';
  Result := Result + ' CASE';
  Result := Result + '   WHEN IFNULL(O.OPE_INTEXT, "") = "A" THEN "ADMINISTRATIVO"';
  Result := Result + '   WHEN IFNULL(O.OPE_INTEXT, "") = "C" THEN "COMPRAS"';
  Result := Result + '   WHEN IFNULL(O.OPE_INTEXT, "") = "I" THEN "VENDEDOR INTERNO"';
  Result := Result + '   WHEN IFNULL(O.OPE_INTEXT, "") = "E" THEN "REPRES. EXTERNO LOJA"';
  Result := Result + '   WHEN IFNULL(O.OPE_INTEXT, "") = "D" THEN "REPRES. EXTERNO DISTRIBUIDOR"';
  Result := Result + '   WHEN IFNULL(O.OPE_INTEXT, "") = "S" THEN "SUB-GERENTE"';
  Result := Result + '   WHEN IFNULL(O.OPE_INTEXT, "") = "G" THEN "GERENTE"';
  Result := Result + '   WHEN IFNULL(O.OPE_INTEXT, "") = "O" THEN "OPERACIONAL"';

  If fCfgSis('AUTCEN', VarBoolean) Then
    Result := Result + '   WHEN IFNULL(O.OPE_INTEXT, "") = "M" THEN "MECÂNICO"';

  If fCfgSis('CONEQU', VarBoolean) Then
    Result := Result + '   WHEN IFNULL(O.OPE_INTEXT, "") = "T" THEN "ASSISTÊNCIA TÉCNICA"';

  Result := Result + '   ELSE "VENDEDOR"';
  Result := Result + ' END AS OPE_NOMFUN';

end;

function TfrmCadMetaVendedoresPorFaturamentoRentabilidadePorEmpresa.fRetSQLEmpresas(AMesAno, ACodEmp: String): String;
  var
    blnInformouEmpresa : Boolean;
begin

  blnInformouEmpresa := Not ACodEmp.IsEmpty;

  Result := '';
  Result := Result + 'SELECT          ';
  Result := Result + '  E.EMP_CODEMP, ';
  Result := Result + '  E.EMP_NOMEMP, ';
  Result := Result + '  G.MET_MARGEM, ';
  Result := Result + '  G.MET_PREMIO, ';
  Result := Result + '  G.MET_PRE1AB, ';
  Result := Result + '  G.MET_PRE1AC, ';
  Result := Result + '  G.MET_PRE2AC  ';
  Result := Result + 'FROM            ';
  Result := Result + '  METFAG G      ';
  Result := Result + '  INNER JOIN CADEMP E ON (E.EMP_CODEMP = G.MET_CODEMP) ';
  Result := Result + 'WHERE G.MET_MESANO = :MESANO ' + IIF(blnInformouEmpresa, 'AND G.MET_CODEMP = :CODEMP ', '');

  If Not blnInformouEmpresa Then
  Begin

    Result := Result + 'UNION ALL ';

    Result := Result + 'SELECT                ';
    Result := Result + '  E.EMP_CODEMP,       ';
    Result := Result + '  E.EMP_NOMEMP,       ';
    Result := Result + '  0.00 AS MET_MARGEM, ';
    Result := Result + '  0.00 AS MET_PREMIO, ';
    Result := Result + '  0.00 AS MET_PRE1AB, ';
    Result := Result + '  0.00 AS MET_PRE1AC, ';
    Result := Result + '  0.00 AS MET_PRE2AC  ';
    Result := Result + 'FROM                  ';
    Result := Result + '  CADEMP E            ';
    Result := Result + 'WHERE                 ';
    Result := Result + '  E.EMP_CODEMP NOT IN (SELECT DISTINCT(X.MET_CODEMP) FROM METFAG X WHERE X.MET_MESANO = :MESANO) ';

  End;

  Result := Result + 'ORDER BY EMP_CODEMP';

end;

function TfrmCadMetaVendedoresPorFaturamentoRentabilidadePorEmpresa.fRetSQLRentaVendedores(AMesAno, ACodEmp : String) : String;
  var
    blnInformouEmpresa : Boolean;
begin

  blnInformouEmpresa := Not ACodEmp.IsEmpty;

  Result := '';
  Result := Result + 'SELECT          ';
  Result := Result + '  O.OPE_CODOPE, ';
  Result := Result + '  O.OPE_NOMOPE, ';
  Result := Result + '  O.OPE_CODEMP, ';
  Result := Result + '  D.MET_MARGEM, ';
  Result := Result + '  D.MET_PREMIO, ';
  Result := Result + '  D.MET_PRE1AB, ';
  Result := Result + '  D.MET_PRE1AC, ';
  Result := Result + '  D.MET_PRE2AC, ';
  Result := Result + fRetSQLCaseFuncao + ' ';
  Result := Result + 'FROM            ';
  Result := Result + '  METFAG G      ';
  Result := Result + '  INNER JOIN METFVE D ON (D.MET_SEQGER = G.AUTOINCREM) ';
  Result := Result + '  INNER JOIN CADOPE O ON (O.OPE_CODOPE = D.MET_CODVEN) ';
  Result := Result + 'WHERE                    ';
  Result := Result + '  O.OPE_STATUS = "A" AND ';
  Result := Result + '  O.OPE_INTEXT IN ("I", "E", "D", "G", "S") AND ';
  Result := Result + '  G.MET_MESANO = :MESANO ' + IIF(blnInformouEmpresa, 'AND G.MET_CODEMP = :CODEMP ', '');

  Result := Result + 'UNION ALL       ';

  Result := Result + 'SELECT          ';
  Result := Result + '  O.OPE_CODOPE, ';
  Result := Result + '  O.OPE_NOMOPE, ';
  Result := Result + '  O.OPE_CODEMP, ';
  Result := Result + '  0.00 AS MET_MARGEM, ';
  Result := Result + '  0.00 AS MET_PREMIO, ';
  Result := Result + '  0.00 AS MET_PRE1AB, ';
  Result := Result + '  0.00 AS MET_PRE1AC, ';
  Result := Result + '  0.00 AS MET_PRE2AC, ';
  Result := Result + fRetSQLCaseFuncao + ' ';
  Result := Result + 'FROM                  ';
  Result := Result + '  CADOPE O            ';
  Result := Result + 'WHERE                 ';
  Result := Result + '  O.OPE_STATUS = "A" AND ' + IIF(blnInformouEmpresa, ' O.OPE_CODEMP = :CODEMP AND ', '');
  Result := Result + '  O.OPE_INTEXT IN ("I", "E", "D", "G", "S") AND  ';
  Result := Result + '  O.OPE_CODOPE NOT IN (SELECT                    ';
  Result := Result + '                         DISTINCT(Y.MET_CODVEN)  ';
  Result := Result + '                       FROM                      ';
  Result := Result + '                         METFAG X                ';
  Result := Result + '                         INNER JOIN METFVE Y ON (Y.MET_SEQGER = X.AUTOINCREM) ';
  Result := Result + '                       WHERE                     ';
  Result := Result + '                         X.MET_MESANO = :MESANO' + IIF(blnInformouEmpresa, ' AND X.MET_CODEMP = :CODEMP ', '') + ') ';

  Result := Result + 'ORDER BY OPE_CODOPE';

end;

function TfrmCadMetaVendedoresPorFaturamentoRentabilidadePorEmpresa.fRetSQLVendedores(AMesAno, ACodEmp: String): String;
  var
    blnInformouEmpresa : Boolean;
begin

  blnInformouEmpresa := Not ACodEmp.IsEmpty;

  Result := '';
  Result := Result + 'SELECT          ';
  Result := Result + '  O.OPE_CODOPE, ';
  Result := Result + '  O.OPE_NOMOPE, ';
  Result := Result + '  O.OPE_CODEMP, ';
  Result := Result + '  D.FAD_VALFAT, ';
  Result := Result + '  D.FAD_PREM01, ';
  Result := Result + '  D.FAD_PREM02, ';
  Result := Result + '  D.FAD_PREM03, ';
  Result := Result + '  D.FAD_PREM04, ';
  Result := Result + fRetSQLCaseFuncao + ' ';
  Result := Result + 'FROM            ';
  Result := Result + '  METFAG G      ';
  Result := Result + '  INNER JOIN METFAD D ON (D.FAD_SEQGER = G.AUTOINCREM) ';
  Result := Result + '  INNER JOIN CADOPE O ON (O.OPE_CODOPE = D.FAD_CODVEN) ';
  Result := Result + 'WHERE                    ';
  Result := Result + '  O.OPE_STATUS = "A" AND ';
  Result := Result + '  O.OPE_INTEXT IN ("I", "E", "D", "G", "S") AND ';
  Result := Result + '  G.MET_MESANO = :MESANO ' + IIF(blnInformouEmpresa, 'AND G.MET_CODEMP = :CODEMP ', '');

  Result := Result + 'UNION ALL       ';

  Result := Result + 'SELECT          ';
  Result := Result + '  O.OPE_CODOPE, ';
  Result := Result + '  O.OPE_NOMOPE, ';
  Result := Result + '  O.OPE_CODEMP, ';
  Result := Result + '  0.00 AS FAD_VALFAT, ';
  Result := Result + '  0.00 AS FAD_PREM01, ';
  Result := Result + '  0.00 AS FAD_PREM02, ';
  Result := Result + '  0.00 AS FAD_PREM03, ';
  Result := Result + '  0.00 AS FAD_PREM04, ';
  Result := Result + fRetSQLCaseFuncao + ' ';
  Result := Result + 'FROM                  ';
  Result := Result + '  CADOPE O            ';
  Result := Result + 'WHERE                 ';
  Result := Result + '  O.OPE_STATUS = "A" AND ' + IIF(blnInformouEmpresa, ' O.OPE_CODEMP = :CODEMP AND ', '');
  Result := Result + '  O.OPE_INTEXT IN ("I", "E", "D", "G", "S") AND  ';
  Result := Result + '  O.OPE_CODOPE NOT IN (SELECT                    ';
  Result := Result + '                         DISTINCT(Y.FAD_CODVEN)  ';
  Result := Result + '                       FROM                      ';
  Result := Result + '                         METFAG X                ';
  Result := Result + '                         INNER JOIN METFAD Y ON (Y.FAD_SEQGER = X.AUTOINCREM) ';
  Result := Result + '                       WHERE                     ';
  Result := Result + '                         X.MET_MESANO = :MESANO' + IIF(blnInformouEmpresa, ' AND X.MET_CODEMP = :CODEMP ', '') + ') ';

  Result := Result + 'ORDER BY OPE_CODOPE';

end;

function TfrmCadMetaVendedoresPorFaturamentoRentabilidadePorEmpresa.fSalvarDados(AMesAno, ACodEmp: String; pgbProgresso: TcxProgressBar): Boolean;
  var
    qryTmpGer     : TUniQuery;
    qryTmpDet     : TUniQuery;
    qryTmpRentVen : TUniQuery;
    strSeqGer : String;

    blnSalvarMetasVendedoresEmpresas : Boolean;

begin

  blnSalvarMetasVendedoresEmpresas := Assigned(FcdsMetasEmpresas) Or Assigned(FcdsMetasVendedores);

  If Not blnSalvarMetasVendedoresEmpresas Then
  Begin
    pRegravarPremioRentabilidadeSemAtingirMeta;
    Exit(True);
  End;

  qryTmpGer     := fCriaQuery;
  qryTmpDet     := fCriaQuery;
  qryTmpRentVen := fCriaQuery;

  cxgMetaVendedorFaturamento.BeginUpdate();
  cxgMetaRentabilidadeEmpresa.BeginUpdate();
  cxgMetaRentabilidadeVendedor.BeginUpdate();

  Result := False;

  Try

    fStartTransaction();

    pInfoStatusGravacao('Aguarde... Gravando Metas', pgbProgresso);

    pgbProgresso.Position := 0;
    pgbProgresso.Properties.Max := FcdsMetasVendedores.RecordCount;

    Try

      If fApagarDados(AMesAno, ACodEmp) Then
      Begin

        qryTmpGer.Close;
        qryTmpGer.SQL.Clear;
        qryTmpGer.SQL.Add('SELECT * FROM METFAG WHERE FALSE');
        qryTmpGer.Open;

        qryTmpDet.Close;
        qryTmpDet.SQL.Clear;
        qryTmpDet.SQL.Add('SELECT * FROM METFAD WHERE FALSE');
        qryTmpDet.Open;

        qryTmpRentVen.Close;
        qryTmpRentVen.SQL.Clear;
        qryTmpRentVen.SQL.Add('SELECT * FROM METFVE WHERE FALSE');
        qryTmpRentVen.Open;

        FcdsMetasEmpresas.First;
        While Not FcdsMetasEmpresas.Eof Do
        Begin

          strSeqGer := fRetAutoIncrem('METFAG', VS_strCodEmp);

          {Empresa}
          qryTmpGer.Append;
          qryTmpGer.FieldByName('AUTOINCREM').AsString := strSeqGer;
          qryTmpGer.FieldByName('MET_MESANO').AsString := AMesAno;
          qryTmpGer.FieldByName('MET_CODEMP').AsString := FcdsMetasEmpresas.FieldByName('MET_CODEMP').AsString;
          qryTmpGer.FieldByName('MET_MARGEM').AsFloat  := FcdsMetasEmpresas.FieldByName('MET_MARGEM').AsFloat;
          qryTmpGer.FieldByName('MET_PREMIO').AsFloat  := FcdsMetasEmpresas.FieldByName('MET_PREMIO').AsFloat;
          qryTmpGer.FieldByName('MET_PRE1AB').AsFloat  := FcdsMetasEmpresas.FieldByName('MET_PRE1AB').AsFloat;
          qryTmpGer.FieldByName('MET_PRE1AC').AsFloat  := FcdsMetasEmpresas.FieldByName('MET_PRE1AC').AsFloat;
          qryTmpGer.FieldByName('MET_PRE2AC').AsFloat  := FcdsMetasEmpresas.FieldByName('MET_PRE2AC').AsFloat;
          qryTmpGer.Post;

          {Vendedores}
          FcdsMetasVendedores.Filtered := False;
          FcdsMetasVendedores.Filter   := 'CODEMP = ' + QuotedStr(FcdsMetasEmpresas.FieldByName('MET_CODEMP').AsString);
          FcdsMetasVendedores.Filtered := True;

          FcdsMetasVendedores.First;
          While Not FcdsMetasVendedores.Eof Do
          Begin

            qryTmpDet.Append;
            qryTmpDet.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('METFAD', VS_strCodEmp);
            qryTmpDet.FieldByName('FAD_SEQGER').AsString := strSeqGer;
            qryTmpDet.FieldByName('FAD_CODVEN').AsString := FcdsMetasVendedores.FieldByName('FAD_CODVEN').AsString;
            qryTmpDet.FieldByName('FAD_VALFAT').AsFloat  := FcdsMetasVendedores.FieldByName('FAD_VALFAT').AsFloat;
            qryTmpDet.FieldByName('FAD_PREM01').AsFloat  := FcdsMetasVendedores.FieldByName('FAD_PREM01').AsFloat;
            qryTmpDet.FieldByName('FAD_PREM02').AsFloat  := FcdsMetasVendedores.FieldByName('FAD_PREM02').AsFloat;
            qryTmpDet.FieldByName('FAD_PREM03').AsFloat  := FcdsMetasVendedores.FieldByName('FAD_PREM03').AsFloat;
            qryTmpDet.FieldByName('FAD_PREM04').AsFloat  := FcdsMetasVendedores.FieldByName('FAD_PREM04').AsFloat;
            qryTmpDet.Post;

            FcdsMetasVendedores.Next;
            pStepStatusGravacao(pgbProgresso);

          End;

          {Rentabilidade Vendedores}
          FcdsRentaVendedores.Filtered := False;
          FcdsRentaVendedores.Filter   := 'CODEMP = ' + QuotedStr(FcdsMetasEmpresas.FieldByName('MET_CODEMP').AsString);
          FcdsRentaVendedores.Filtered := True;

          FcdsRentaVendedores.First;
          While Not FcdsRentaVendedores.Eof Do
          Begin

            qryTmpRentVen.Append;
            qryTmpRentVen.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('METFVE', VS_strCodEmp);
            qryTmpRentVen.FieldByName('MET_SEQGER').AsString := strSeqGer;
            qryTmpRentVen.FieldByName('MET_CODVEN').AsString := FcdsRentaVendedores.FieldByName('MET_CODVEN').AsString;
            qryTmpRentVen.FieldByName('MET_MARGEM').AsFloat  := FcdsRentaVendedores.FieldByName('MET_MARGEM').AsFloat;
            qryTmpRentVen.FieldByName('MET_PREMIO').AsFloat  := FcdsRentaVendedores.FieldByName('MET_PREMIO').AsFloat;
            qryTmpRentVen.FieldByName('MET_PRE1AB').AsFloat  := FcdsRentaVendedores.FieldByName('MET_PRE1AB').AsFloat;
            qryTmpRentVen.FieldByName('MET_PRE1AC').AsFloat  := FcdsRentaVendedores.FieldByName('MET_PRE1AC').AsFloat;
            qryTmpRentVen.FieldByName('MET_PRE2AC').AsFloat  := FcdsRentaVendedores.FieldByName('MET_PRE2AC').AsFloat;
            qryTmpRentVen.Post;

            FcdsRentaVendedores.Next;
            pStepStatusGravacao(pgbProgresso);

          End;


          FcdsMetasEmpresas.Next;

        End;

        FcdsMetasVendedores.Filtered := False;
        FcdsMetasVendedores.Filter   := '';

        pRegravarPremioRentabilidadeSemAtingirMeta;

        fCommit();
        Result := True;

      End;

    Except
      On E : Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, '[fSalvarDados]');
      End;
    End;

  Finally
    FreeAndNil(qryTmpGer);
    FreeAndNil(qryTmpDet);
    FreeAndNil(qryTmpRentVen);
    cxgMetaVendedorFaturamento.EndUpdate;
    cxgMetaRentabilidadeEmpresa.EndUpdate;
    cxgMetaRentabilidadeVendedor.EndUpdate;
  End;

end;

function TfrmCadMetaVendedoresPorFaturamentoRentabilidadePorEmpresa.fSalvarDadosInterna(pgbProgresso: TcxProgressBar): Boolean;
begin
  Result := fSalvarDados(fTiraCaracEspeciais(mskDtaAtual.Text), edtCodEmp.Text, pgbProgresso);
end;

function TfrmCadMetaVendedoresPorFaturamentoRentabilidadePorEmpresa.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin

  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = mskDtaOrigem) Then
    Begin

      If pnlMesAnoOrigem.Visible Then
      Begin
        If fEmptyStr(fTiraCaracEspeciais(mskDtaOrigem.Text)) Then
        Begin
          fMensagem('', 'Informar o mês / ano de origem!', ['&Ok']);
          Result := False;
        End
        Else
        Begin

          Try
            strToDate('01/' + mskDtaOrigem.Text);
          Except
            fMensagem('', 'Mês / Ano inválido!', ['&Ok']);
            Result := False;
          End;

          If Result Then
            pCopiarMeta(fTiraCaracEspeciais(mskDtaOrigem.Text), edtCodEmp.Text);

        End;
      End Else
      Begin
        mskDtaOrigem.Clear;
      End;

    End

    Else

    If (Sender = mskDtaAtual) Then
    Begin

      If fEmptyStr(fTiraCaracEspeciais(mskDtaAtual.Text)) Then
      Begin
        fMensagem('', 'Informe o mês / ano atual!', ['&Ok']);
        Result := False;
      End
      Else
      Begin

        Try
          mskDtaAtual.Text := fTrataAnoDataMesAno(mskDtaAtual.Text);
          strToDate('01/' + mskDtaAtual.Text);

          If (Not fVerificaAcessoSistema('METREN')) And (Not fEmptyStr(edtCodEmp.Text)) Then
            If Not fEmptyStr(fTiraCaracEspeciais(mskDtaAtual.Text)) Then
              pCarregarDados(fTiraCaracEspeciais(mskDtaAtual.Text), edtCodEmp.Text);

        Except
          fMensagem('', 'Mês / Ano inválido!', ['&Ok']);
          Result := False;
        End;

      End;
    End

    Else

    If (Sender = edtCodEmp) Then
    Begin

      If Not fEmptyStr(edtCodEmp.Text) Then
      Begin

        edtNomEmp.Text := fRetNomeEmpresa(edtCodEmp.Text);

        If fEmptyStr(edtNomEmp.Text) Then
        Begin
          fMensagem('', 'Empresa informada é inválida!', ['&Ok']);
          edtCodEmp.Clear;
          pSetFocus(edtCodEmp);
        End;

      End Else
        edtCodEmp.Clear;

      If Not fEmptyStr(fTiraCaracEspeciais(mskDtaAtual.Text)) Then
        pCarregarDados(fTiraCaracEspeciais(mskDtaAtual.Text), edtCodEmp.Text);

    End;

  End;

  If Not Result Then
    pSetFocus(Sender);

end;

procedure TfrmCadMetaVendedoresPorFaturamentoRentabilidadePorEmpresa.pAddCampo(ADataSet   : TUniClientDataSet;
                                                                               AFieldName : String;
                                                                               AFieldType : TFieldType;
                                                                               ASize      : Integer = 0);
  var
    LField : TFieldDef;
begin

  LField := ADataSet.FieldDefs.AddFieldDef;
  LField.Name     := AFieldName;
  LField.DataType := AFieldType;

  If (ASize > 0) Then
    LField.Size := ASize;

end;

procedure TfrmCadMetaVendedoresPorFaturamentoRentabilidadePorEmpresa.pCarregarDados(AMesAno, ACodEmp: String);
begin

  If AMesAno.IsEmpty Then
    Exit;

  pCriarClientsTemporarios;

  If fPeriodoJaGravado(AMesAno, ACodEmp) Then
  Begin
    pCarregarMesAnoInformado(AMesAno, ACodEmp);
    Exit;
  End;

  pCarregarMesAnoInformadoNovo(AMesAno, ACodEmp);

end;

procedure TfrmCadMetaVendedoresPorFaturamentoRentabilidadePorEmpresa.pCarregarMesAnoInformado(AMesAno, ACodEmp: String);
  var
    qryTmp : TUniQuery;
begin

  pLimparClientsTemporarios;

  cxgMetaVendedorFaturamento.BeginUpdate();
  cxgMetaRentabilidadeEmpresa.BeginUpdate();
  cxgMetaRentabilidadeVendedor.BeginUpdate();

  qryTmp := fCriaQuery;

  Try

    {Empresas}
    qryTmp.Close;
    qryTmp.SQL.Clear;
    qryTmp.SQL.Add(fRetSQLEmpresas(AMesAno, ACodEmp));
    qryTmp.ParamByName('MESANO').AsString := AMesAno;

    If Assigned(qryTmp.FindParam('CODEMP')) Then
      qryTmp.ParamByName('CODEMP').AsString := ACodEmp;

    qryTmp.Open;

    qryTmp.First;
    While Not qryTmp.Eof Do
    Begin
      FcdsMetasEmpresas.Append;
      FcdsMetasEmpresas.FieldByName('MET_CODEMP').AsString := qryTmp.FieldByName('EMP_CODEMP').AsString;
      FcdsMetasEmpresas.FieldByName('NOMEMP').AsString     := qryTmp.FieldByName('EMP_NOMEMP').AsString;
      FcdsMetasEmpresas.FieldByName('MET_MARGEM').AsFloat  := qryTmp.FieldByName('MET_MARGEM').AsFloat;
      FcdsMetasEmpresas.FieldByName('MET_PREMIO').AsFloat  := qryTmp.FieldByName('MET_PREMIO').AsFloat;
      FcdsMetasEmpresas.FieldByName('MET_PRE1AB').AsFloat  := qryTmp.FieldByName('MET_PRE1AB').AsFloat;
      FcdsMetasEmpresas.FieldByName('MET_PRE1AC').AsFloat  := qryTmp.FieldByName('MET_PRE1AC').AsFloat;
      FcdsMetasEmpresas.FieldByName('MET_PRE2AC').AsFloat  := qryTmp.FieldByName('MET_PRE2AC').AsFloat;
      FcdsMetasEmpresas.Post;
      qryTmp.Next;
    End;

    {Vendedores}
    qryTmp.Close;
    qryTmp.SQL.Clear;
    qryTmp.SQL.Add(fRetSQLVendedores(AMesAno, ACodEmp));
    qryTmp.ParamByName('MESANO').AsString := AMesAno;

    If Assigned(qryTmp.FindParam('CODEMP')) Then
      qryTmp.ParamByName('CODEMP').AsString := ACodEmp;

    qryTmp.Open;

    qryTmp.First;
    While Not qryTmp.Eof Do
    Begin
      FcdsMetasVendedores.Append;
      FcdsMetasVendedores.FieldByName('CODEMP').AsString     := qryTmp.FieldByName('OPE_CODEMP').AsString;
      FcdsMetasVendedores.FieldByName('FAD_CODVEN').AsString := qryTmp.FieldByName('OPE_CODOPE').AsString;
      FcdsMetasVendedores.FieldByName('NOMVEN').AsString     := qryTmp.FieldByName('OPE_NOMOPE').AsString;
      FcdsMetasVendedores.FieldByName('NOMFUN').AsString     := qryTmp.FieldByName('OPE_NOMFUN').AsString;
      FcdsMetasVendedores.FieldByName('FAD_VALFAT').AsFloat  := qryTmp.FieldByName('FAD_VALFAT').AsFloat;
      FcdsMetasVendedores.FieldByName('FAD_PREM01').AsFloat  := qryTmp.FieldByName('FAD_PREM01').AsFloat;
      FcdsMetasVendedores.FieldByName('FAD_PREM02').AsFloat  := qryTmp.FieldByName('FAD_PREM02').AsFloat;
      FcdsMetasVendedores.FieldByName('FAD_PREM03').AsFloat  := qryTmp.FieldByName('FAD_PREM03').AsFloat;
      FcdsMetasVendedores.FieldByName('FAD_PREM04').AsFloat  := qryTmp.FieldByName('FAD_PREM04').AsFloat;
      FcdsMetasVendedores.Post;
      qryTmp.Next;
    End;

    {Rentabilidade Vendedores}
    qryTmp.Close;
    qryTmp.SQL.Clear;
    qryTmp.SQL.Add(fRetSQLRentaVendedores(AMesAno, ACodEmp));
    qryTmp.ParamByName('MESANO').AsString := AMesAno;

    If Assigned(qryTmp.FindParam('CODEMP')) Then
      qryTmp.ParamByName('CODEMP').AsString := ACodEmp;

    qryTmp.Open;

    qryTmp.First;
    While Not qryTmp.Eof Do
    Begin
      FcdsRentaVendedores.Append;
      FcdsRentaVendedores.FieldByName('CODEMP').AsString     := qryTmp.FieldByName('OPE_CODEMP').AsString;
      FcdsRentaVendedores.FieldByName('MET_CODVEN').AsString := qryTmp.FieldByName('OPE_CODOPE').AsString;
      FcdsRentaVendedores.FieldByName('NOMVEN').AsString     := qryTmp.FieldByName('OPE_NOMOPE').AsString;
      FcdsRentaVendedores.FieldByName('MET_MARGEM').AsFloat  := qryTmp.FieldByName('MET_MARGEM').AsFloat;
      FcdsRentaVendedores.FieldByName('MET_PREMIO').AsFloat  := qryTmp.FieldByName('MET_PREMIO').AsFloat;
      FcdsRentaVendedores.FieldByName('MET_PRE1AB').AsFloat  := qryTmp.FieldByName('MET_PRE1AB').AsFloat;
      FcdsRentaVendedores.FieldByName('MET_PRE1AC').AsFloat  := qryTmp.FieldByName('MET_PRE1AC').AsFloat;
      FcdsRentaVendedores.FieldByName('MET_PRE2AC').AsFloat  := qryTmp.FieldByName('MET_PRE2AC').AsFloat;
      FcdsRentaVendedores.Post;
      qryTmp.Next;
    End;

    FcdsMetasEmpresas.First;
    FcdsMetasVendedores.First;
    FcdsRentaVendedores.First;

  Finally
    cxgMetaVendedorFaturamento.EndUpdate();
    cxgMetaRentabilidadeEmpresa.EndUpdate();
    cxgMetaRentabilidadeVendedor.EndUpdate();
    FreeAndNil(qryTmp);
  End;

end;

procedure TfrmCadMetaVendedoresPorFaturamentoRentabilidadePorEmpresa.pCarregarMesAnoInformadoNovo(AMesAno, ACodEmp: String);
  var
    qryTmp : TUniQuery;
begin

  pLimparClientsTemporarios;

  cxgMetaVendedorFaturamento.BeginUpdate();
  cxgMetaRentabilidadeEmpresa.BeginUpdate();
  cxgMetaRentabilidadeVendedor.BeginUpdate();

  qryTmp := fCriaQuery;

  Try

    {Empresas}
    qryTmp.Close;
    qryTmp.SQL.Clear;
    qryTmp.SQL.Add('SELECT          ');
    qryTmp.SQL.Add('  E.EMP_CODEMP, ');
    qryTmp.SQL.Add('  E.EMP_NOMEMP  ');
    qryTmp.SQL.Add('FROM            ');
    qryTmp.SQL.Add('  CADEMP E      ');

    If Not ACodEmp.IsEmpty Then
    Begin
      qryTmp.SQL.Add('WHERE E.EMP_CODEMP = :CODEMP');
      qryTmp.ParamByName('CODEMP').AsString := ACodEmp;
    End;

    qryTmp.SQL.Add('ORDER BY E.EMP_CODEMP');
    qryTmp.Open;

    qryTmp.First;
    While Not qryTmp.Eof Do
    Begin
      FcdsMetasEmpresas.Append;
      FcdsMetasEmpresas.FieldByName('MET_CODEMP').AsString := qryTmp.FieldByName('EMP_CODEMP').AsString;
      FcdsMetasEmpresas.FieldByName('NOMEMP').AsString     := qryTmp.FieldByName('EMP_NOMEMP').AsString;
      FcdsMetasEmpresas.FieldByName('MET_MARGEM').AsFloat  := 0;
      FcdsMetasEmpresas.FieldByName('MET_PREMIO').AsFloat  := 0;
      FcdsMetasEmpresas.FieldByName('MET_PRE1AB').AsFloat  := 0;
      FcdsMetasEmpresas.FieldByName('MET_PRE1AC').AsFloat  := 0;
      FcdsMetasEmpresas.FieldByName('MET_PRE2AC').AsFloat  := 0;
      FcdsMetasEmpresas.Post;
      qryTmp.Next;
    End;

    {Vendedores}
    qryTmp.Close;
    qryTmp.SQL.Clear;
    qryTmp.SQL.Add('SELECT ');
    qryTmp.SQL.Add('  O.*, ');
    qryTmp.SQL.Add(fRetSQLCaseFuncao);
    qryTmp.SQL.Add('FROM   ');
    qryTmp.SQL.Add('  CADOPE O');
    qryTmp.SQL.Add('WHERE  ');
    qryTmp.SQL.Add('  O.OPE_STATUS = "A" AND ');
    qryTmp.SQL.Add('  O.OPE_INTEXT IN ("I", "E", "D", "G", "S") ');

    If Not ACodEmp.IsEmpty Then
    Begin
      qryTmp.SQL.Add('AND O.OPE_CODEMP = :CODEMP');
      qryTmp.ParamByName('CODEMP').AsString := ACodEmp;
    End;

    qryTmp.SQL.Add('ORDER BY O.OPE_CODOPE');
    qryTmp.Open;

    qryTmp.First;
    While Not qryTmp.Eof Do
    Begin
      FcdsMetasVendedores.Append;
      FcdsMetasVendedores.FieldByName('FAD_CODVEN').AsString := qryTmp.FieldByName('OPE_CODOPE').AsString;
      FcdsMetasVendedores.FieldByName('NOMVEN').AsString     := qryTmp.FieldByName('OPE_NOMOPE').AsString;;
      FcdsMetasVendedores.FieldByName('NOMFUN').AsString     := qryTmp.FieldByName('OPE_NOMFUN').AsString;;
      FcdsMetasVendedores.FieldByName('CODEMP').AsString     := qryTmp.FieldByName('OPE_CODEMP').AsString;
      FcdsMetasVendedores.FieldByName('FAD_VALFAT').AsFloat  := 0;
      FcdsMetasVendedores.FieldByName('FAD_PREM01').AsFloat  := 0;
      FcdsMetasVendedores.FieldByName('FAD_PREM02').AsFloat  := 0;
      FcdsMetasVendedores.FieldByName('FAD_PREM03').AsFloat  := 0;
      FcdsMetasVendedores.FieldByName('FAD_PREM04').AsFloat  := 0;
      FcdsMetasVendedores.Post;
      qryTmp.Next;
    End;

    {Rentabilidade Vendedores}
    qryTmp.Close;
    qryTmp.SQL.Clear;
    qryTmp.SQL.Add('SELECT ');
    qryTmp.SQL.Add('  O.*, ');
    qryTmp.SQL.Add(fRetSQLCaseFuncao);
    qryTmp.SQL.Add('FROM   ');
    qryTmp.SQL.Add('  CADOPE O');
    qryTmp.SQL.Add('WHERE  ');
    qryTmp.SQL.Add('  O.OPE_STATUS = "A" AND ');
    qryTmp.SQL.Add('  O.OPE_INTEXT IN ("I", "E", "D", "G", "S") ');

    If Not ACodEmp.IsEmpty Then
    Begin
      qryTmp.SQL.Add('AND O.OPE_CODEMP = :CODEMP');
      qryTmp.ParamByName('CODEMP').AsString := ACodEmp;
    End;

    qryTmp.SQL.Add('ORDER BY O.OPE_CODOPE');
    qryTmp.Open;

    qryTmp.First;
    While Not qryTmp.Eof Do
    Begin
      FcdsRentaVendedores.Append;
      FcdsRentaVendedores.FieldByName('MET_CODVEN').AsString := qryTmp.FieldByName('OPE_CODOPE').AsString;
      FcdsRentaVendedores.FieldByName('NOMVEN').AsString     := qryTmp.FieldByName('OPE_NOMOPE').AsString;;
      FcdsRentaVendedores.FieldByName('CODEMP').AsString     := qryTmp.FieldByName('OPE_CODEMP').AsString;
      FcdsRentaVendedores.FieldByName('MET_MARGEM').AsFloat  := 0;
      FcdsRentaVendedores.FieldByName('MET_PREMIO').AsFloat  := 0;
      FcdsRentaVendedores.FieldByName('MET_PRE1AB').AsFloat  := 0;
      FcdsRentaVendedores.FieldByName('MET_PRE1AC').AsFloat  := 0;
      FcdsRentaVendedores.FieldByName('MET_PRE2AC').AsFloat  := 0;
      FcdsRentaVendedores.Post;
      qryTmp.Next;
    End;

    FcdsMetasVendedores.First;
    FcdsMetasEmpresas.First;
    FcdsRentaVendedores.First;

  Finally
    FreeAndNil(qryTmp);
    cxgMetaVendedorFaturamento.EndUpdate;
    cxgMetaRentabilidadeEmpresa.EndUpdate;
    cxgMetaRentabilidadeVendedor.EndUpdate;
  End;

end;

procedure TfrmCadMetaVendedoresPorFaturamentoRentabilidadePorEmpresa.pCarregarPremioRentabilidadeSemAtingirMeta;
  var
    qryTmp : TUniQuery;
begin

  TSemMeta.EmptyDataSet;

  qryTmp := fCriaQuery;

  Try

    qryTmp.Close;
    qryTmp.SQL.Clear;
    qryTmp.SQL.Add('SELECT * FROM METSEM ORDER BY AUTOINCREM');
    qryTmp.Open;

    qryTmp.First;
    While Not qryTmp.Eof Do
    Begin
      TSemMeta.Append;
      TSemMetaMET_FATINI.AsFloat := qryTmp.FieldByName('MET_FATINI').AsFloat;
      TSemMetaMET_FATFIN.AsFloat := qryTmp.FieldByName('MET_FATFIN').AsFloat;
      TSemMetaMET_PREMIO.AsFloat := qryTmp.FieldByName('MET_PREMIO').AsFloat;
      TSemMeta.Post;
      qryTmp.Next;
    End;

    TSemMeta.First;

  Finally
    FreeAndNil(qryTmp);
  End;

end;

procedure TfrmCadMetaVendedoresPorFaturamentoRentabilidadePorEmpresa.pCopiarMeta(AMesAno, ACodEmp : String);
  var
    qryTmp   : TUniQuery;
    blnVazio : Boolean;
begin

  cxgMetaVendedorFaturamento.BeginUpdate();
  cxgMetaRentabilidadeEmpresa.BeginUpdate();
  cxgMetaRentabilidadeVendedor.BeginUpdate();

  qryTmp := fCriaQuery;

  Try

    {Empresas}
    qryTmp.Close;
    qryTmp.SQL.Clear;
    qryTmp.SQL.Add(fRetSQLEmpresas(AMesAno, ACodEmp));
    qryTmp.ParamByName('MESANO').AsString := AMesAno;

    If Assigned(qryTmp.FindParam('CODEMP')) Then
      qryTmp.ParamByName('CODEMP').AsString := ACodEmp;

    qryTmp.Open;

    blnVazio := qryTmp.IsEmpty;

    qryTmp.First;
    While Not qryTmp.Eof Do
    Begin
      If FcdsMetasEmpresas.Locate('MET_CODEMP', qryTmp.FieldByName('EMP_CODEMP').AsString, []) Then
      Begin
        FcdsMetasEmpresas.Edit;
        FcdsMetasEmpresas.FieldByName('MET_MARGEM').AsFloat := qryTmp.FieldByName('MET_MARGEM').AsFloat;
        FcdsMetasEmpresas.FieldByName('MET_PREMIO').AsFloat := qryTmp.FieldByName('MET_PREMIO').AsFloat;
        FcdsMetasEmpresas.FieldByName('MET_PRE1AB').AsFloat := qryTmp.FieldByName('MET_PRE1AB').AsFloat;
        FcdsMetasEmpresas.FieldByName('MET_PRE1AC').AsFloat := qryTmp.FieldByName('MET_PRE1AC').AsFloat;
        FcdsMetasEmpresas.FieldByName('MET_PRE2AC').AsFloat := qryTmp.FieldByName('MET_PRE2AC').AsFloat;
        FcdsMetasEmpresas.Post;
      End;
      qryTmp.Next;
    End;

    {Vendedores}
    qryTmp.Close;
    qryTmp.SQL.Clear;
    qryTmp.SQL.Add(fRetSQLVendedores(AMesAno, ACodEmp));
    qryTmp.ParamByName('MESANO').AsString := AMesAno;

    If Assigned(qryTmp.FindParam('CODEMP')) Then
      qryTmp.ParamByName('CODEMP').AsString := ACodEmp;

    qryTmp.Open;

    If qryTmp.IsEmpty And blnVazio Then
    Begin
      pMensagemOK('Não há metas cadastradas para o mês origem informado!');
      pSetFocus(mskDtaOrigem);
      Exit;
    End;

    qryTmp.First;
    While Not qryTmp.Eof Do
    Begin
      If FcdsMetasVendedores.Locate('FAD_CODVEN', qryTmp.FieldByName('OPE_CODOPE').AsString, []) Then
      Begin
        FcdsMetasVendedores.Edit;
        FcdsMetasVendedores.FieldByName('FAD_VALFAT').AsFloat  := qryTmp.FieldByName('FAD_VALFAT').AsFloat;
        FcdsMetasVendedores.FieldByName('FAD_PREM01').AsFloat  := qryTmp.FieldByName('FAD_PREM01').AsFloat;
        FcdsMetasVendedores.FieldByName('FAD_PREM02').AsFloat  := qryTmp.FieldByName('FAD_PREM02').AsFloat;
        FcdsMetasVendedores.FieldByName('FAD_PREM03').AsFloat  := qryTmp.FieldByName('FAD_PREM03').AsFloat;
        FcdsMetasVendedores.FieldByName('FAD_PREM04').AsFloat  := qryTmp.FieldByName('FAD_PREM04').AsFloat;
        FcdsMetasVendedores.Post;
      End;
      qryTmp.Next;
    End;

    {Rentabilidade Vendedores}
    qryTmp.Close;
    qryTmp.SQL.Clear;
    qryTmp.SQL.Add(fRetSQLRentaVendedores(AMesAno, ACodEmp));
    qryTmp.ParamByName('MESANO').AsString := AMesAno;

    If Assigned(qryTmp.FindParam('CODEMP')) Then
      qryTmp.ParamByName('CODEMP').AsString := ACodEmp;

    qryTmp.Open;

    If qryTmp.IsEmpty And blnVazio Then
    Begin
      pMensagemOK('Não há metas cadastradas para o mês origem informado!');
      pSetFocus(mskDtaOrigem);
      Exit;
    End;

    qryTmp.First;
    While Not qryTmp.Eof Do
    Begin
      If FcdsRentaVendedores.Locate('MET_CODVEN', qryTmp.FieldByName('OPE_CODOPE').AsString, []) Then
      Begin
        FcdsRentaVendedores.Edit;
        FcdsRentaVendedores.FieldByName('MET_MARGEM').AsFloat := qryTmp.FieldByName('MET_MARGEM').AsFloat;
        FcdsRentaVendedores.FieldByName('MET_PREMIO').AsFloat := qryTmp.FieldByName('MET_PREMIO').AsFloat;
        FcdsRentaVendedores.FieldByName('MET_PRE1AB').AsFloat := qryTmp.FieldByName('MET_PRE1AB').AsFloat;
        FcdsRentaVendedores.FieldByName('MET_PRE1AC').AsFloat := qryTmp.FieldByName('MET_PRE1AC').AsFloat;
        FcdsRentaVendedores.FieldByName('MET_PRE2AC').AsFloat := qryTmp.FieldByName('MET_PRE2AC').AsFloat;
        FcdsRentaVendedores.Post;
      End;
      qryTmp.Next;
    End;

    FcdsMetasEmpresas.First;
    FcdsMetasVendedores.First;
    FcdsRentaVendedores.First;

    pMensagemOK('Metas copiadas com sucesso!');
    mskDtaOrigem.Clear;

    pnlMesAnoOrigem.Visible := False;

  Finally
    cxgMetaVendedorFaturamento.EndUpdate();
    cxgMetaRentabilidadeEmpresa.EndUpdate();
    cxgMetaRentabilidadeVendedor.EndUpdate();
    FreeAndNil(qryTmp);
  End;

end;

procedure TfrmCadMetaVendedoresPorFaturamentoRentabilidadePorEmpresa.pCriarClientsTemporarios;
begin

  If Assigned(FcdsMetasVendedores) Then
    Exit;

  FcdsMetasEmpresas := TUniClientDataSet.Create(Self);
  dscMetasEmpresas.DataSet := FcdsMetasEmpresas;

  pAddCampo(FcdsMetasEmpresas, 'NOMEMP', ftString, 255);

  pAddCampo(FcdsMetasEmpresas, 'AUTOINCREM', ftString, 20);
  pAddCampo(FcdsMetasEmpresas, 'MET_CODEMP', ftString, 3);
  pAddCampo(FcdsMetasEmpresas, 'MET_MARGEM', ftFloat);
  pAddCampo(FcdsMetasEmpresas, 'MET_PREMIO', ftFloat);
  pAddCampo(FcdsMetasEmpresas, 'MET_PRE1AB', ftFloat);
  pAddCampo(FcdsMetasEmpresas, 'MET_PRE1AC', ftFloat);
  pAddCampo(FcdsMetasEmpresas, 'MET_PRE2AC', ftFloat);

  FcdsMetasEmpresas.CreateDataSet;
  FcdsMetasEmpresas.LogChanges := False;

  TFloatField(FcdsMetasEmpresas.FieldByName('MET_MARGEM')).DisplayFormat := '#,##0.00';
  TFloatField(FcdsMetasEmpresas.FieldByName('MET_PREMIO')).DisplayFormat := '#,##0.00';
  TFloatField(FcdsMetasEmpresas.FieldByName('MET_PRE1AB')).DisplayFormat := '#,##0.00';
  TFloatField(FcdsMetasEmpresas.FieldByName('MET_PRE1AC')).DisplayFormat := '#,##0.00';
  TFloatField(FcdsMetasEmpresas.FieldByName('MET_PRE2AC')).DisplayFormat := '#,##0.00';

  FcdsMetasVendedores := TUniClientDataSet.Create(Self);
  dscMetasVendedores.DataSet := FcdsMetasVendedores;

  pAddCampo(FcdsMetasVendedores, 'NOMVEN', ftString, 255);
  pAddCampo(FcdsMetasVendedores, 'NOMFUN', ftString, 255);
  pAddCampo(FcdsMetasVendedores, 'CODEMP', ftString, 3);

  pAddCampo(FcdsMetasVendedores, 'AUTOINCREM', ftString, 20);
  pAddCampo(FcdsMetasVendedores, 'FAD_SEQGER', ftString, 20);
  pAddCampo(FcdsMetasVendedores, 'FAD_CODVEN', ftString, 3);

  pAddCampo(FcdsMetasVendedores, 'FAD_VALFAT', ftFloat);
  pAddCampo(FcdsMetasVendedores, 'FAD_PREM01', ftFloat);
  pAddCampo(FcdsMetasVendedores, 'FAD_PREM02', ftFloat);
  pAddCampo(FcdsMetasVendedores, 'FAD_PREM03', ftFloat);
  pAddCampo(FcdsMetasVendedores, 'FAD_PREM04', ftFloat);

  FcdsMetasVendedores.CreateDataSet;
  FcdsMetasVendedores.LogChanges := False;

  TFloatField(FcdsMetasVendedores.FieldByName('FAD_VALFAT')).DisplayFormat := '#,##0.00';
  TFloatField(FcdsMetasVendedores.FieldByName('FAD_PREM01')).DisplayFormat := '#,##0.00';
  TFloatField(FcdsMetasVendedores.FieldByName('FAD_PREM02')).DisplayFormat := '#,##0.00';
  TFloatField(FcdsMetasVendedores.FieldByName('FAD_PREM03')).DisplayFormat := '#,##0.00';
  TFloatField(FcdsMetasVendedores.FieldByName('FAD_PREM04')).DisplayFormat := '#,##0.00';


  FcdsRentaVendedores := TUniClientDataSet.Create(Self);
  dscRentaVendedores.DataSet := FcdsRentaVendedores;

  pAddCampo(FcdsRentaVendedores, 'NOMVEN', ftString, 255);
  pAddCampo(FcdsRentaVendedores, 'CODEMP', ftString, 3);

  pAddCampo(FcdsRentaVendedores, 'AUTOINCREM', ftString, 20);
  pAddCampo(FcdsRentaVendedores, 'MET_SEQGER', ftString, 20);
  pAddCampo(FcdsRentaVendedores, 'MET_CODVEN', ftString, 3);
  pAddCampo(FcdsRentaVendedores, 'MET_MARGEM', ftFloat);
  pAddCampo(FcdsRentaVendedores, 'MET_PREMIO', ftFloat);
  pAddCampo(FcdsRentaVendedores, 'MET_PRE1AB', ftFloat);
  pAddCampo(FcdsRentaVendedores, 'MET_PRE1AC', ftFloat);
  pAddCampo(FcdsRentaVendedores, 'MET_PRE2AC', ftFloat);

  FcdsRentaVendedores.CreateDataSet;
  FcdsRentaVendedores.LogChanges := False;

  TFloatField(FcdsRentaVendedores.FieldByName('MET_MARGEM')).DisplayFormat := '#,##0.00';
  TFloatField(FcdsRentaVendedores.FieldByName('MET_PREMIO')).DisplayFormat := '#,##0.00';
  TFloatField(FcdsRentaVendedores.FieldByName('MET_PRE1AB')).DisplayFormat := '#,##0.00';
  TFloatField(FcdsRentaVendedores.FieldByName('MET_PRE1AC')).DisplayFormat := '#,##0.00';
  TFloatField(FcdsRentaVendedores.FieldByName('MET_PRE2AC')).DisplayFormat := '#,##0.00';

end;

procedure TfrmCadMetaVendedoresPorFaturamentoRentabilidadePorEmpresa.pgcDadosChange(
  Sender: TObject);
begin
  inherited;
  btnParam.Visible := pgcDados.ActivePage = tbsMetaDeVendedorFaturamento;
end;

procedure TfrmCadMetaVendedoresPorFaturamentoRentabilidadePorEmpresa.pInfoStatusGravacao(strInformacao: String; pgbProgresso: TcxProgressBar);
begin
  If Assigned(pgbProgresso) And (GetParentForm(pgbProgresso).FindComponent('lblGravando') <> Nil) Then
  Begin
    TLabel(GetParentForm(pgbProgresso).FindComponent('lblGravando')).Caption := strInformacao;
    Application.ProcessMessages;
  End;
end;

procedure TfrmCadMetaVendedoresPorFaturamentoRentabilidadePorEmpresa.pLimparClientsTemporarios;
begin

  If (FcdsRentaVendedores.Active) And (Not FcdsRentaVendedores.IsEmpty) Then
    FcdsRentaVendedores.EmptyDataSet;

  If (FcdsMetasVendedores.Active) And (Not FcdsMetasVendedores.IsEmpty) Then
    FcdsMetasVendedores.EmptyDataSet;

  If (FcdsMetasEmpresas.Active) And (Not FcdsMetasEmpresas.IsEmpty) Then
    FcdsMetasEmpresas.EmptyDataSet;

end;

procedure TfrmCadMetaVendedoresPorFaturamentoRentabilidadePorEmpresa.pLimparPremioRentabilidadeSemAtingirMeta;
begin
  edtVlrInicial.Text   := '0,00';
  edtVlrFinal.Text     := '0,00';
  edtVlrPremiacao.Text := '0,00';
end;

procedure TfrmCadMetaVendedoresPorFaturamentoRentabilidadePorEmpresa.pRegravarPremioRentabilidadeSemAtingirMeta;
  var
    qryTmp : TUniQuery;
begin

  qryTmp := fCriaQuery;

  Try

    qryTmp.Close;
    qryTmp.SQL.Clear;
    qryTmp.SQL.Add('DELETE FROM METSEM');
    qryTmp.ExecSQL;

    If TSemMeta.IsEmpty Then
      Exit;

    qryTmp.Close;
    qryTmp.SQL.Clear;
    qryTmp.SQL.Add('SELECT * FROM METSEM');
    qryTmp.Open;

    TSemMeta.First;
    While Not TSemMeta.Eof Do
    Begin

      qryTmp.Append;
      qryTmp.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('METSEM', VS_strCodEmp);
      qryTmp.FieldByName('MET_FATINI').AsFloat  := TSemMetaMET_FATINI.AsFloat;
      qryTmp.FieldByName('MET_FATFIN').AsFloat  := TSemMetaMET_FATFIN.AsFloat;
      qryTmp.FieldByName('MET_PREMIO').AsFloat  := TSemMetaMET_PREMIO.AsFloat;
      qryTmp.Post;

      TSemMeta.Next;

    End;

    TSemMeta.First;

  Finally
    FreeAndNil(qryTmp);
  End;

end;

procedure TfrmCadMetaVendedoresPorFaturamentoRentabilidadePorEmpresa.pSetaValoresDefaultTela;
begin

  TSemMeta.CreateDataSet;
  pCarregarPremioRentabilidadeSemAtingirMeta;

  pVerdeVermelho(edtCodEmp, shpCodEmp, fVerificaAcessoSistema('METREN'), False, False);

  edtCodEmp.Text := fRetEmpresaOperador(strLoginUsuarioLogado);
  edtNomEmp.Text := fRetNomeEmpresa(edtCodEmp.Text);

  mskDtaAtual.Text := FormatDateTime('mm/yyyy', VS_Date);
  pSetFocus(mskDtaAtual);
end;

procedure TfrmCadMetaVendedoresPorFaturamentoRentabilidadePorEmpresa.pStepStatusGravacao(pgbProgresso: TcxProgressBar);
begin
  If Assigned(pgbProgresso) Then
  Begin
    pgbProgresso.Position := pgbProgresso.Position + 1;
    Application.ProcessMessages;
  End;
end;

procedure TfrmCadMetaVendedoresPorFaturamentoRentabilidadePorEmpresa.cxgRentabilidadeEmpresaViewEditKeyDown(
  Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
  AEdit: TcxCustomEdit; var Key: Word; Shift: TShiftState);
  var
    fltValue : Double;
begin

  inherited;

  if Key = VK_RETURN then
  Begin

    if not Assigned(AItem) then
      Exit;

    if not (AItem is TcxGridDBColumn) then
      Exit;

    if not (FcdsMetasEmpresas.State in [dsInsert, dsEdit]) then
      Exit;

    if TryStrToFloat(VarToStr(AEdit.EditingValue), fltValue) then
    begin
      if (fltValue < 0) then
      begin
        fMensagem('ATENÇÃO!', 'O valor informado não pode ser negativo!', ['&OK']);
        FcdsMetasEmpresas.Cancel;
      end;
    end;

  End;

end;

procedure TfrmCadMetaVendedoresPorFaturamentoRentabilidadePorEmpresa.cxgVendedorFaturamentoViewEditKeyDown(
  Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
  AEdit: TcxCustomEdit; var Key: Word; Shift: TShiftState);
  var
    fltValue : Double;
begin

  inherited;

  if Key = VK_RETURN then
  Begin

    if not Assigned(AItem) then
      Exit;

    if not (AItem is TcxGridDBColumn) then
      Exit;

    if not (FcdsMetasVendedores.State in [dsInsert, dsEdit]) then
      Exit;

    if TryStrToFloat(VarToStr(AEdit.EditingValue), fltValue) then
    begin
      if (fltValue < 0) then
      begin
        fMensagem('ATENÇÃO!', 'O valor informado não pode ser negativo!', ['&OK']);
        FcdsMetasVendedores.Cancel;
      end;
    end;

    If (AItem.Name = 'cxgVendedorFaturamentoViewVALFAT') Then
      pPreencheParametrizacao(fltValue);

  End;

end;

procedure TfrmCadMetaVendedoresPorFaturamentoRentabilidadePorEmpresa.dbgSemMetaDblClick(Sender: TObject);
begin
  inherited;

  If TSemMeta.IsEmpty Then
    Exit;

  edtVlrInicial.Text   := FormatFloat('#,##0.00', TSemMetaMET_FATINI.AsFloat);
  edtVlrFinal.Text     := FormatFloat('#,##0.00', TSemMetaMET_FATFIN.AsFloat);
  edtVlrPremiacao.Text := FormatFloat('#,##0.00', TSemMetaMET_PREMIO.AsFloat);

  TSemMeta.Edit;

  dbgSemMeta.Enabled := False;
  pSetFocus(edtVlrInicial);

end;

procedure TfrmCadMetaVendedoresPorFaturamentoRentabilidadePorEmpresa.pPreencheParametrizacao(fltVlrFat: Double);
  Var
    objPremios: TParPre;
    objController: TParPreController;
begin
  objController := TParPreController.Create;
  objPremios := objController.fBuscaPorValor(fltVlrFat, VS_strCodEmp);

  Try
    If (Not Assigned(objPremios)) Then
      Exit;

    FcdsMetasVendedores.Edit;
    FcdsMetasVendedores.FieldByName('FAD_VALFAT').AsFloat := objPremios.getVlrFat;
    FcdsMetasVendedores.FieldByName('FAD_PREM01').AsFloat := objPremios.get1CsAba;
    FcdsMetasVendedores.FieldByName('FAD_PREM02').AsFloat := objPremios.getMetAti;
    FcdsMetasVendedores.FieldByName('FAD_PREM03').AsFloat := objPremios.get1CsAci;
    FcdsMetasVendedores.FieldByName('FAD_PREM04').AsFloat := objPremios.get2CsAci;
    FcdsMetasVendedores.Post;
    FcdsMetasVendedores.Next;
    cxgVendedorFaturamentoView.Controller.FocusedColumn := cxgVendedorFaturamentoViewNOMFUN;
  Finally
    FreeAndNil(objPremios);
    FreeAndNil(objController);
  End;
end;

procedure TfrmCadMetaVendedoresPorFaturamentoRentabilidadePorEmpresa.dbgSemMetaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  var
    AValor : String;
begin
  inherited;

  If (Key = VK_DELETE) Then
  Begin

    If (Not TSemMeta.IsEmpty) Then
    Begin
      AValor := FormatFloat('#,##0.00', TSemMetaMET_PREMIO.AsFloat);
      If fMensagem('ATENÇÃO','Confirma excluir Prêmio "' + AValor + '"?',['','']) = 1 then
        TSemMeta.Delete;
    End;

  End;

end;

end.
