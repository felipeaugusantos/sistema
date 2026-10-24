unit untTGerenciaMovimentacaoGondola;

interface

uses System.SysUtils, untFuncoesSimples, untConstantes, Classes, untZClient,
     Data.DB, cxProgressBar, Uni, Math , Forms, uniClientDataSet, Vcl.ComCtrls,
     StrUtils, untTypesSistema, untLiberacao;

Type
  TAcaoManutGandola =  (tamgIndefini, tamgNegar, tamgAutorizar);
  TDadosDocTL = Record
    strDocOpe: String;
    dtaDtaCad: TDate;
    strCodCli, strAutInc: String;
  End;
  TGerenciaMovimentacaoGondola = class
  protected
    procedure CriaCdsPainel;
    function  fTemMarcado: Boolean;
    procedure NegarItem;
    procedure AutorizarItem;
    procedure IndefinirItem;
    function fAcaoEmMassa(pgbStatus: TcxProgressBar = Nil): Boolean;
    function fSalvar: Boolean;
    function fEfetivar(pgbStatus: TcxProgressBar = Nil): Boolean;
    function fValidaInformacoes(pgbStatus: TcxProgressBar = Nil): Boolean;
    procedure pAcaoEmMassa(Acao: TAcaoManutGandola);
    function fEfetivaSemLote: Boolean;
    function fEfetivaTL: Boolean;
    function fGeraTransferenciaLotes() : Boolean;
    function fLiberadoTrocaDeStatus: Boolean;

  private
    FTravaLiberada: Boolean;
    FJaFoiSolicitadaLiberacao: Boolean;
    FAcaoExcutando: TAcaoManutGandola;
    blnPedeMotivo: Boolean;
    qryConsulta: TUniQuery;
    blnDesmarcarTodos: Boolean;
    opcSel: integer;
    FDoc_TL: TDadosDocTL;
    FExecutandoAcaoEmMassa: Boolean;
    blnGravarApenasMarcados: Boolean;
    procedure OnCdsDadosBeforePost(DataSet: TDataSet);
    function fLoteValido(ACodIte, ALote: String; var AErro: string; var LotLocFis: String): Boolean;
    procedure ReCriaCdsPainel;
    procedure pAtualizaComoImpresso();
    function fMudandoStatusDeAutorizadoParaOutroPedeLiberacao: Boolean;
    function fLiberaReimpressao: Boolean;
    function fDefineComportamentoGravacao: Boolean;
    function fRegraDeDefinicao: integer;
  protected
    FReimpressao: Boolean;
  public
    cdsDados: TZClient;
    strMotivoNegacao: string;
    strMotivoAutorizacao: String;
    blnTemRegistroComLote: Boolean;
    strLoteOriginal: String;
    intDecQtd: Integer;
    mskSaldo: String;
    dtsDados: TDataSource;
    Class Function fGerenciaGondolaAtivo: Boolean;
    class procedure pSolicitacaodeReposicaodeGondola;
    class procedure pPainelGondola;
    class procedure ReimpressaoDeSeparacao;
    constructor Create;
    procedure pImprimir(blnConteudoTela: Boolean; AOrigem: String = '');
    procedure pImprimirSeparacao(blnConteudoTela: Boolean; blnReimpressao: Boolean = False);
    destructor Destroy;override;
    procedure MarcaDesmarcaItem(blnMarca: Boolean);
    procedure MarcaDesmarcaTodos(blnMarca: Boolean);
    procedure Negar;
    procedure Salvar;
    procedure Autorizar;
    procedure Indefinir;
    procedure Efetivar;
    procedure processaReimpressao(ALocal: String; ASeparacaoGondolaFiltro: TSeparacaoGondolaFiltro);

  End;

implementation

uses
  untSolicitacaodeReposicaodeGondola, untPainelMovimentacaoGondola,
  untGravando, untDigMotivo, untOpcPoupupRadio, untTransferenciaArmazens,
  untFatImpressao, untEditorFastImpressao, untPedeDadosSeparacaoGondola,
  untDigOperador;

{ TGerenciaMovimentacaoGondola }

procedure TGerenciaMovimentacaoGondola.Autorizar;
begin
  If cdsDados.IsEmpty Then
    Exit;
  If fTemMarcado Then
    pAcaoEmMassa(tamgAutorizar)
  Else
  begin
    strMotivoAutorizacao := TfrmDigMotivo.fDigMotivo('Motivo:', strMotivoAutorizacao);
    AutorizarItem;
  End
end;

procedure TGerenciaMovimentacaoGondola.AutorizarItem;
begin
  blnPedeMotivo := False;

  cdsDados.Edit;
  cdsDados.FieldByName('SOL_STATUS').AsInteger := 2;
  cdsDados.FieldByName('SOL_OBSTRA').AsString := strMotivoAutorizacao;

  cdsDados.FieldByName('MARCAD').AsString := '';
  cdsDados.Post;

  blnPedeMotivo := True;
end;

constructor TGerenciaMovimentacaoGondola.Create;
begin
  blnPedeMotivo := True;
  FReimpressao := False;
  cdsDados := TZClient.Create(nil);
  cdsDados.BeforePost := OnCdsDadosBeforePost;
  qryConsulta := fCriaQuery;
  intDecQtd := Max(3, fCfgSis('DECQTD', varInteger));
  mskSaldo := fMskDigitos(intDecQtd);
  FTravaLiberada := False;
  FJaFoiSolicitadaLiberacao := False;
  FExecutandoAcaoEmMassa := False;

end;

procedure TGerenciaMovimentacaoGondola.ReCriaCdsPainel;
begin
  FreeAndNil(cdsDados);
  cdsDados := TZClient.Create(nil);
  cdsDados.BeforePost :=  OnCdsDadosBeforePost;
  CriaCdsPainel;
  If Assigned(dtsDados) Then
    dtsDados.DataSet := Self.cdsDados;

End;

class procedure TGerenciaMovimentacaoGondola.ReimpressaoDeSeparacao;
var GerenciaMovimentacaoGondola: TGerenciaMovimentacaoGondola;
    frmFiltroSeparacao: TfrmFiltroSeparacao;
begin
  GerenciaMovimentacaoGondola := TGerenciaMovimentacaoGondola.Create;
  GerenciaMovimentacaoGondola.FReimpressao := True;
  pCriarFormularios(TfrmFiltroSeparacao, frmFiltroSeparacao);
  try
     frmFiltroSeparacao.procProcessaReimpressao := GerenciaMovimentacaoGondola.processaReimpressao;
     frmFiltroSeparacao.ShowModal;
  Finally
     FreeAndNil(frmFiltroSeparacao);
     FreeAndNil(GerenciaMovimentacaoGondola);
  End;
end;

procedure TGerenciaMovimentacaoGondola.CriaCdsPainel;
begin


  cdsDados.qryQuery.SQL.Clear;
  cdsDados.qryQuery.SQL.Add('SELECT SOLGON.*, ');
  cdsDados.qryQuery.SQL.Add('       SOL_STATUS AS OLD_SOL_STATUS,');
  cdsDados.qryQuery.SQL.Add('       C.ITE_DESITE,');
  cdsDados.qryQuery.SQL.Add('       UNI_SIGUNI,');
  cdsDados.qryQuery.SQL.Add('       MAR_DESMAR,');
  cdsDados.qryQuery.SQL.Add('       CONCAT(OS.OPE_CODOPE, "-" , OS.OPE_NOMOPE) AS OPESOL,');
  cdsDados.qryQuery.SQL.Add('       CONCAT(OSE.OPE_CODOPE, "-" , OSE.OPE_NOMOPE) AS OPESEL,');
  cdsDados.qryQuery.SQL.Add(' IF(IFNULL(SOL_LOTORI, "") = "", (' + fSQLSaldoDisponivel + '), (' + fSQLSaldoDisponivel('L', False, True) + ')) AS SALDIS, ');
  cdsDados.qryQuery.SQL.Add('       IFNULL((SELECT COUNT(1)');
  cdsDados.qryQuery.SQL.Add('                 FROM CADLOT');
  cdsDados.qryQuery.SQL.Add('                WHERE LOT_CODITE = SOL_CODITE');
  cdsDados.qryQuery.SQL.Add('                  AND LOT_CODEMP = SOL_CODEMP');
  cdsDados.qryQuery.SQL.Add('                LIMIT 1), 0) > 0 AS TEM_LOTE, ');
  cdsDados.qryQuery.SQL.Add('       CAST("" AS CHAR(1)) AS MARCAD');
  cdsDados.qryQuery.SQL.Add('  FROM SOLGON');
  cdsDados.qryQuery.SQL.Add(' INNER JOIN CADITE C ON C.ITE_CODITE = SOL_CODITE');
  cdsDados.qryQuery.SQL.Add(' INNER JOIN ITEGER G ON G.ITE_CODITE = SOL_CODITE');
  cdsDados.qryQuery.SQL.Add('                    AND G.ITE_CODEMP = SOL_CODEMP');
  cdsDados.qryQuery.SQL.Add(' LEFT JOIN CADLOT L ON L.LOT_CODITE = SOL_CODITE');
  cdsDados.qryQuery.SQL.Add('                   AND L.LOT_CODEMP = SOL_CODEMP');
  cdsDados.qryQuery.SQL.Add('                   AND L.LOT_NUMLOT = SOL_LOTORI');
  cdsDados.qryQuery.SQL.Add(' INNER JOIN CADOPE OS ON OS.OPE_CODOPE = SOL_CODOPE');
  cdsDados.qryQuery.SQL.Add('  LEFT JOIN CADOPE OSE ON OSE.OPE_CODOPE = SOL_OPESEP');
  cdsDados.qryQuery.SQL.Add('  LEFT JOIN CADUNI ON UNI_CODUNI = C.ITE_CODUNI');
  cdsDados.qryQuery.SQL.Add('  LEFT JOIN CADMAR ON MAR_CODMAR = C.ITE_CODMAR');
  cdsDados.qryQuery.SQL.Add(' WHERE SOL_CODEMP = "' + VS_strCodEmp + '"');
  cdsDados.qryQuery.SQL.Add('   AND SOL_DTABAI  IS NULL');
  cdsDados.qryQuery.SQL.Add('  ORDER BY SOLGON.AUTOINCREM');
  cdsDados.fAbreClient(False, '[TGerenciaMovimentacaoGondola.pPainelGondola]');

  cdsDados.Filter := 'TEM_LOTE > 0';
  cdsDados.Filtered := True;
  blnTemRegistroComLote := Not cdsDados.IsEmpty;
  cdsDados.Filtered := False;

end;

destructor TGerenciaMovimentacaoGondola.Destroy;
begin
  inherited;
  FreeAndNil(cdsDados);
  FreeAndNil(qryConsulta);

end;

procedure TGerenciaMovimentacaoGondola.Efetivar;
  var frmGravando: TFrmGravando;
  blnResult: Boolean;
begin
  cdsDados.DisableControls;
  Try
    pCriarFormularios(TfrmGravando, frmGravando);
    try
       frmGravando.lblGravando.Caption := 'Validando informações.';
       frmGravando.fExecutarAcao := fValidaInformacoes;
       frmGravando.ShowModal;
       blnResult := frmGravando.blnConfirma;
    Finally
       FreeAndNil(frmGravando);
    End;


    If blnResult then
    begin
      If Not fDefineComportamentoGravacao then
        Exit;
      fStartTransaction;
      Try
        pCriarFormularios(TfrmGravando, frmGravando);
        try
           frmGravando.lblGravando.Caption := 'Efetivando operações.';
           frmGravando.fExecutarAcao := fEfetivar;
           frmGravando.ShowModal;
           blnResult := frmGravando.blnConfirma;
           If not blnResult Then
             fRollback
           Else
           Begin
             fCommit;
             pMensagemOk('Gravação Concluída!');
             ReCriaCdsPainel;
           End;
        Finally
          FreeAndNil(frmGravando);
          cdsDados.Filtered := False;
        End;
      Except
        fRollBack;
      End
    End;
  Finally
    cdsDados.EnableControls;
  End;
end;

function TGerenciaMovimentacaoGondola.fAcaoEmMassa(pgbStatus: TcxProgressBar): Boolean;
var recNo: integer;
var lstrMotivoNegacao: string;
    lstrMotivoAutorizacao: String;
begin
  Result := True;
  pgbStatus.Properties.Max := cdsDados.RecordCount;
  recNo := cdsDados.RecNo;
  cdsDados.DisableControls;
  lstrMotivoNegacao := '';
  lstrMotivoAutorizacao := '';
  FTravaLiberada := False;
  FJaFoiSolicitadaLiberacao := False;
  FExecutandoAcaoEmMassa := True;

  Try
    cdsDados.First;
    while not cdsDados.Eof do
    begin
      If cdsDados.FieldByName('MARCAD').AsString = 'M' Then
      begin
        case FAcaoExcutando of
          tamgIndefini: IndefinirItem;
          tamgNegar: Begin
                       If lstrMotivoNegacao = '' Then
                       begin
                         strMotivoNegacao := TfrmDigMotivo.fDigMotivo('Motivo:', strMotivoNegacao);
                         lstrMotivoNegacao := strMotivoNegacao;
                       End;
                       If lstrMotivoNegacao = '' Then
                         lstrMotivoNegacao := ' ';
                       NegarItem;
                     End;
          tamgAutorizar: Begin
                           If lstrMotivoAutorizacao = '' Then
                           begin
                             strMotivoAutorizacao:= TfrmDigMotivo.fDigMotivo('Motivo:', strMotivoAutorizacao);
                             lstrMotivoAutorizacao := strMotivoAutorizacao;
                           End;
                           If lstrMotivoAutorizacao = '' Then
                             lstrMotivoAutorizacao := ' ';
                           AutorizarItem;
                         End;
        end;
      End;
      cdsDados.Next;
    End;
  Finally
    cdsDados.Filtered := False;
    cdsDados.RecNo := recNo;
    cdsDados.EnableControls;
    FTravaLiberada := False;
    FJaFoiSolicitadaLiberacao := False;
    FExecutandoAcaoEmMassa := False;
  End;
end;

function TGerenciaMovimentacaoGondola.fRegraDeDefinicao: integer;
var qtdItensGravacao: integer;
    qtdMarcado: integer;
begin
  Try
    cdsDados.Filter := 'SOL_STATUS <> 0';
    cdsDados.Filtered := true;
    qtdItensGravacao := cdsDados.RecordCount;

    IF qtdItensGravacao = 0 THen
      Exit(0);

    cdsDados.Filter := 'SOL_STATUS <> 0 AND MARCAD = ' + QuotedStr('M');
    cdsDados.Filtered := true;
    qtdMarcado := cdsDados.RecordCount;
    If qtdMarcado = qtdItensGravacao then
      Result := 0
    Else If (qtdMarcado = 0)Then
      Result := 1
    Else
      Result := 2;
  Finally
    cdsDados.Filtered := False;
    cdsDados.Filter := '';
  End;

end;


function TGerenciaMovimentacaoGondola.fDefineComportamentoGravacao: Boolean;
var intOpcAtivos: integer;
begin
  blnGravarApenasMarcados := False;
  Result := True;
  Try
    case fRegraDeDefinicao of
      1 : begin
           intOpcAtivos := fMensagem('','Nenhum item foi marcado, todos os itens definidos como AUTORIZADO/NEGADO serão confirmados.', ['Continuar', 'Cancelar'], 0);
           If intOpcAtivos = 2 Then
             Exit(False)
          End;
      2 : If Not cdsDados.IsEmpty Then
          Begin
            intOpcAtivos := fMensagem('','Existem item marcados, Gerar Transferencias/Negar', ['Marcados', 'Todos', 'Cancelar'], 0);
            If intOpcAtivos = 3 Then
              Exit(False);
            blnGravarApenasMarcados :=  intOpcAtivos = 1;
          End;
    End;
  Finally
    cdsDados.Filter := '';
    cdsDados.Filtered := False;
  End;
end;

function TGerenciaMovimentacaoGondola.fEfetivar(
  pgbStatus: TcxProgressBar): Boolean;
begin
  cdsDados.Filter := 'SOL_STATUS <> 0' + IIf(blnGravarApenasMarcados, ' AND MARCAD = '+ QuotedStr('M'), '');
  cdsDados.Filtered := True;
  pgbStatus.Properties.Max := cdsDados.RecordCount;

  cdsDados.Filter := 'SOL_STATUS = 1' + IIf(blnGravarApenasMarcados, ' AND MARCAD = '+ QuotedStr('M'), '');
  cdsDados.Filtered := True;
  cdsDados.First;
  while not cdsDados.Eof Do
  Begin
    Result := fEfetivaSemLote;
    If Not Result then
      Exit;
    cdsDados.Next;
    pgbStatus.Position := pgbStatus.Position + 1;
    Application.ProcessMessages;
  End;

  cdsDados.Filter := 'SOL_STATUS = 2 AND TEM_LOTE = 0' + IIf(blnGravarApenasMarcados, ' AND MARCAD = '+ QuotedStr('M'), '');
  cdsDados.Filtered := True;
  while not cdsDados.Eof Do
  Begin
    Result := fEfetivaSemLote;
    If Not Result then
      Exit;
    cdsDados.Next;
    pgbStatus.Position := pgbStatus.Position + 1;
    Application.ProcessMessages;
  End;

  cdsDados.Filter := 'SOL_STATUS = 2 AND TEM_LOTE <> 0' + IIf(blnGravarApenasMarcados, ' AND MARCAD = '+ QuotedStr('M'), '');
  cdsDados.Filtered := True;
  result := fGeraTransferenciaLotes;
  If result Then
  begin
    cdsDados.First;
    while not cdsDados.Eof Do
    Begin
      Result := fEfetivaTL;
      If Not Result then
        Exit;
      cdsDados.Next;
      pgbStatus.Position := pgbStatus.Position + 1;
      Application.ProcessMessages;
    End;
  End;
end;

function TGerenciaMovimentacaoGondola.fEfetivaSemLote: Boolean;
var qryComand: TUniQuery;
begin
  Result := True;
  qryComand := fCriaQuery;
  try
    Try
      qryComand.SQL.Add('UPDATE SOLGON SET ');
      qryComand.SQL.Add('       SOL_STATUS = :SOL_STATUS, ');
      qryComand.SQL.Add('       SOL_FISORI = :SOL_FISORI, ');
      qryComand.SQL.Add('       SOL_LOTORI = :SOL_LOTORI, ');
      qryComand.SQL.Add('       SOL_QTDATD = :SOL_QTDATD, ');
      qryComand.SQL.Add('       SOL_OBSTRA = :SOL_OBSTRA, ');
      qryComand.SQL.Add('       SOL_DTABAI = :SOL_DTABAI, ');
      qryComand.SQL.Add('       SOL_DTABAI = :SOL_DTABAI, ');
      qryComand.SQL.Add('       SOL_OPEBAI = :SOL_OPEBAI' );
      qryComand.SQL.Add('WHERE  AUTOINCREM = :AUTOINCREM');

      qryComand.ParamByName('SOL_STATUS').Value := cdsDados.FieldByName('SOL_STATUS').Value;
      qryComand.ParamByName('SOL_FISORI').Value := cdsDados.FieldByName('SOL_FISORI').Value;
      qryComand.ParamByName('SOL_LOTORI').Value := cdsDados.FieldByName('SOL_LOTORI').Value;
      qryComand.ParamByName('SOL_QTDATD').Value := cdsDados.FieldByName('SOL_QTDATD').Value;
      qryComand.ParamByName('SOL_OBSTRA').Value := cdsDados.FieldByName('SOL_OBSTRA').Value;
      qryComand.ParamByName('SOL_DTABAI').Value := fNow;
      qryComand.ParamByName('SOL_OPEBAI').Value := strLoginUsuarioLogado;
      qryComand.ParamByName('AUTOINCREM').Value := cdsDados.FieldByName('AUTOINCREM').Value;
      qryComand.ExecSQL;
    Except
      on e: Exception do
      begin
        pMensagensErro(e.message, 'TGerenciaMovimentacaoGondola.fEfetivaSemLote');
        fRollBack;
        Result := False;
      End;
    End;
  Finally
    FreeAndNil(qryComand);
  End;
end;

function TGerenciaMovimentacaoGondola.fEfetivaTL: Boolean;
var qryComand: TUniQuery;
begin
  Result := True;
  qryComand := fCriaQuery;
  try
    Try
      qryComand.SQL.Add('UPDATE SOLGON SET ');
      qryComand.SQL.Add('       SOL_STATUS = :SOL_STATUS, ');
      qryComand.SQL.Add('       SOL_FISORI = :SOL_FISORI, ');
      qryComand.SQL.Add('       SOL_LOTORI = :SOL_LOTORI, ');
      qryComand.SQL.Add('       SOL_QTDATD = :SOL_QTDATD, ');
      qryComand.SQL.Add('       SOL_OBSTRA = :SOL_OBSTRA, ');
      qryComand.SQL.Add('       SOL_INC_TL = :SOL_INC_TL, ');
      qryComand.SQL.Add('       SOL_DTABAI = :SOL_DTABAI, ');
      qryComand.SQL.Add('       SOL_OPEBAI = :SOL_OPEBAI' );
      qryComand.SQL.Add('WHERE  AUTOINCREM = :AUTOINCREM');

      qryComand.ParamByName('SOL_STATUS').Value := cdsDados.FieldByName('SOL_STATUS').Value;
      qryComand.ParamByName('SOL_FISORI').Value := cdsDados.FieldByName('SOL_FISORI').Value;
      qryComand.ParamByName('SOL_LOTORI').Value := cdsDados.FieldByName('SOL_LOTORI').Value;
      qryComand.ParamByName('SOL_QTDATD').Value := cdsDados.FieldByName('SOL_QTDATD').Value;
      qryComand.ParamByName('SOL_OBSTRA').Value := cdsDados.FieldByName('SOL_OBSTRA').Value;
      qryComand.ParamByName('SOL_INC_TL').Value := FDoc_TL.strAutInc;
      qryComand.ParamByName('SOL_DTABAI').Value := fNow;
      qryComand.ParamByName('SOL_OPEBAI').Value := strLoginUsuarioLogado;
      qryComand.ParamByName('AUTOINCREM').Value := cdsDados.FieldByName('AUTOINCREM').Value;
      qryComand.ExecSQL;
    Except
      on e: Exception do
      begin
        pMensagensErro(e.message, 'TGerenciaMovimentacaoGondola.fEfetivaTL');
        fRollBack;
        Result := False;
      End;
    End;
  Finally
    FreeAndNil(qryComand);
  End;
end;

function TGerenciaMovimentacaoGondola.fGeraTransferenciaLotes() : Boolean;
  Var
    cdsItensTL: TUniClientDataSet;
    objTransf : TTransferenciaArmazens;
    prgProgresso : TProgressBar;
Begin
  Result := True;

  FDoc_TL.strDocOpe := '';
  FDoc_TL.dtaDtaCad := 0;
  FDoc_TL.strCodCli := '';
  FDoc_TL.strAutInc := '';


  Try
    prgProgresso := TProgressBar.Create(Nil);
    cdsItensTL   := TUniClientDataSet.Create(nil);

    With cdsItensTL.FieldDefs.AddFieldDef Do
    Begin
      Name     := 'CODITE';
      DataType := ftString;
      Size     := fTamCodIte;
      Required := False;
    End;

    With cdsItensTL.FieldDefs.AddFieldDef Do
    Begin
      Name     := 'ARMDES';
      DataType := ftString;
      Size     := VS_Size_NumLot;
      Required := False;
    End;

    With cdsItensTL.FieldDefs.AddFieldDef Do
    Begin
      Name     := 'ARMORI';
      DataType := ftString;
      Size     := VS_Size_NumLot;
      Required := False;
    End;

    With cdsItensTL.FieldDefs.AddFieldDef Do
    Begin
      Name     := 'QTDITE';
      DataType := ftFloat;
      Size     := 0;
      Required := False;
    End;

    cdsItensTL.CreateDataSet;
    cdsItensTL.Open;

    objTransf := TTransferenciaArmazens.Create(nil, cdsItensTL, Nil, prgProgresso);

    cdsDados.First;
    While Not cdsDados.Eof Do
    Begin
      cdsItensTL.Append;
      cdsItensTL.FieldByName('CODITE').AsString := cdsDados.FieldByName('SOL_CODITE').AsString;
      cdsItensTL.FieldByName('ARMDES').AsString := cdsDados.FieldByName('SOL_NUMLOT').AsString;
      cdsItensTL.FieldByName('ARMORI').AsString := cdsDados.FieldByName('SOL_LOTORI').AsString;
      cdsItensTL.FieldByName('QTDITE').AsFloat  := cdsDados.FieldByName('SOL_QTDATD').AsFloat;
      cdsItensTL.Post;

      cdsDados.Next;
    End;

    If cdsItensTL.RecordCount > 0 Then
    Begin
      Result := objTransf.fGeraTransferencia(True, False);
      FDoc_TL.strAutInc := objTransf.strAutIncRetorno;
    End;

  Finally
    FreeAndNil(objTransf );
    FreeAndNil(cdsItensTL);
    FreeAndNil(prgProgresso);
  End;

End;

class function TGerenciaMovimentacaoGondola.fGerenciaGondolaAtivo: Boolean;
begin
  Result := fCfgSis('GONDOL', varBoolean);
end;

function TGerenciaMovimentacaoGondola.fLoteValido(ACodIte, ALote: String; var AErro: string; var LotLocFis: String): Boolean;
begin
  AErro := '';
  LotLocFis := '';;
  If ALote = 'A DEFINIR' Then
    AErro := 'Lote não pode ser "A DEFINIR"';

  If ALote = 'GARANTIA' Then
    AErro := 'Lote não pode ser "GARANTIA"';
  If fEmptyStr(AErro) Then
  begin
    qryConsulta.SQL.Clear;
    qryConsulta.SQL.Add('SELECT COUNT(1) QTD, LOT_LOCFIS');
    qryConsulta.SQL.Add('  FROM CADLOT');
    qryConsulta.SQL.Add(' WHERE LOT_CODITE = "'+ACodIte+'"');
    qryConsulta.SQL.Add('   AND LOT_NUMLOT = "'+ALote+'"');
    qryConsulta.SQL.Add('   AND LOT_CODEMP = "'+VS_strCodEmp+'"');
    qryConsulta.Open;
    If (qryConsulta.FieldByName('QTD').AsInteger = 0) Then
      AErro := 'Lote não encontrado para o produto'
    Else LotLocFis := qryConsulta.FieldByName('LOT_LOCFIS').AsString;
   End;

   Result := fEmptyStr(AErro);
end;

function TGerenciaMovimentacaoGondola.fSalvar: Boolean;
var qryComand: TUniQuery;
begin
  Result := True;
  qryComand := fCriaQuery;
  try
    fStartTransaction;
    Try
      qryComand.SQL.Add('UPDATE SOLGON SET ');
      qryComand.SQL.Add('       SOL_STATUS = :SOL_STATUS, ');
      qryComand.SQL.Add('       SOL_FISORI = :SOL_FISORI, ');
      qryComand.SQL.Add('       SOL_LOTORI = :SOL_LOTORI, ');
      qryComand.SQL.Add('       SOL_QTDATD = :SOL_QTDATD, ');
      qryComand.SQL.Add('       SOL_OPESEP = :SOL_OPESEP, ');
      qryComand.SQL.Add('       SOL_IMPREA = :SOL_IMPREA, ');
      qryComand.SQL.Add('       SOL_OBSTRA = :SOL_OBSTRA  ');
      qryComand.SQL.Add('WHERE  AUTOINCREM = :AUTOINCREM');

      qryComand.ParamByName('SOL_STATUS').Value := cdsDados.FieldByName('SOL_STATUS').Value;
      qryComand.ParamByName('SOL_FISORI').Value := cdsDados.FieldByName('SOL_FISORI').Value;
      qryComand.ParamByName('SOL_LOTORI').Value := cdsDados.FieldByName('SOL_LOTORI').Value;
      qryComand.ParamByName('SOL_QTDATD').Value := cdsDados.FieldByName('SOL_QTDATD').Value;
      qryComand.ParamByName('SOL_OPESEP').Value := cdsDados.FieldByName('SOL_OPESEP').Value;
      qryComand.ParamByName('SOL_IMPREA').Value := cdsDados.FieldByName('SOL_IMPREA').Value;
      qryComand.ParamByName('AUTOINCREM').Value := cdsDados.FieldByName('AUTOINCREM').Value;
      qryComand.ParamByName('SOL_OBSTRA').Value := cdsDados.FieldByName('SOL_OBSTRA').Value;
      qryComand.ExecSQL;

      fCommit;
    Except
      on e: Exception do
      begin
        pMensagensErro(e.message, '[TGerenciaMovimentacaoGondola.fSalvar]');
        fRollBack;
        Result := False;
      End;
    End;
  finally
    FreeAndNil(qryComand);
  End;
end;

function TGerenciaMovimentacaoGondola.fTemMarcado: Boolean;
var RecNo: integer;
begin
  Result := False;
  RecNo := cdsDados.RecNo;
  cdsDados.DisableControls;
  try
    cdsDados.First;
    while not cdsDados.Eof do
    begin
      If cdsDados.FieldByName('MARCAD').AsString = 'M' then
        Exit(True);
      cdsDados.Next;
    End;
  finally
    cdsDados.RecNo := RecNo;
    cdsDados.EnableControls;
  End;
end;

function TGerenciaMovimentacaoGondola.fValidaInformacoes(
  pgbStatus: TcxProgressBar): Boolean;
begin
  Result := True;
  Try
    cdsDados.Filter := 'SOL_STATUS = 2 OR SOL_STATUS = 1';
    cdsDados.Filtered := true;

    If cdsDados.IsEmpty Then
    begin
      pMensagemOk('Nenhuma Solictação marcada como Negado/Autorizado!');
      Exit(False);
    End;
    cdsDados.Filter := 'SOL_STATUS = 2';
    cdsDados.Filtered := true;
    pgbStatus.Properties.Max := cdsDados.RecordCount;
    while not cdsDados.Eof Do
    Begin
      If (cdsDados.FieldByName('TEM_LOTE').AsInteger > 0) and
         (cdsDados.FieldByName('SOL_LOTORI').AsString = '') Then
      begin
        pMensagemOk('O Lote precisa ser definido!');
        Exit(False);
      End;
      If (cdsDados.FieldByName('TEM_LOTE').AsInteger = 0) and
         (fEmptyStr(cdsDados.FieldByName('SOL_FISORI').AsString)) Then
      begin
        pMensagemOk('Para item sem lote, a Localização Física de Origem precisa ser definada!');
        Exit(False);
      End;

      If (cdsDados.FieldByName('SOL_QTDATD').AsInteger = 0) Then
      begin
        pMensagemOk('Quantidade atendida deve ser maior que zero!');
        Exit(False);
      End;


      cdsDados.Next;
      pgbStatus.Position := cdsDados.RecNo;
      Application.ProcessMessages;
    End;
  Finally
    cdsDados.Filtered := False;
  End;
end;

procedure TGerenciaMovimentacaoGondola.Indefinir;
begin
  If cdsDados.IsEmpty Then
    Exit;
  If fTemMarcado Then
    pAcaoEmMassa(tamgIndefini)
  Else
    IndefinirItem;
end;

procedure TGerenciaMovimentacaoGondola.IndefinirItem;
begin
  cdsDados.Edit;
  cdsDados.FieldByName('SOL_STATUS').AsInteger := 0;
  cdsDados.FieldByName('MARCAD').AsString := '';
  cdsDados.Post;
end;

procedure TGerenciaMovimentacaoGondola.MarcaDesmarcaItem(blnMarca: Boolean);
begin
  If cdsDados.IsEmpty Then
    Exit;
  blnDesmarcarTodos := True;
  cdsDados.Edit;
  cdsDados.FieldByName('MARCAD').AsString := IIf(blnMarca, 'M', '');
  cdsDados.Post;
  blnDesmarcarTodos := False;
end;

procedure TGerenciaMovimentacaoGondola.MarcaDesmarcaTodos(blnMarca: Boolean);
begin
  opcSel := 0;
  If blnMarca then
    opcSel := TfrmOpcPoupupRadio.fRetOpcPopup(['Todos', 'Apenas Indefinido','Apenas Negado', 'Apenas Autorizado'], 1);
  blnDesmarcarTodos := True;
  cdsDados.First;
  while not cdsDados.Eof do
  begin
    If opcSel > 0 then
    begin
      If cdsDados.FieldByName('SOL_STATUS').AsInteger = (opcSel -1) Then
        MarcaDesmarcaItem(blnMarca);
    end
    Else
      MarcaDesmarcaItem(blnMarca);
    cdsDados.Next;
  end;
  blnDesmarcarTodos := False;
end;

procedure TGerenciaMovimentacaoGondola.Negar;
begin
  If cdsDados.IsEmpty Then
    Exit;
  If fTemMarcado Then
    pAcaoEmMassa(tamgNegar)
  Else
  begin
    strMotivoNegacao := TfrmDigMotivo.fDigMotivo('Motivo:', strMotivoNegacao);
    NegarItem;
  End;
end;

procedure TGerenciaMovimentacaoGondola.NegarItem;
begin
  blnPedeMotivo := False;
  cdsDados.Edit;
  cdsDados.FieldByName('SOL_STATUS').AsInteger := 1;
  cdsDados.FieldByName('SOL_OBSTRA').AsString := strMotivoNegacao;
  cdsDados.FieldByName('MARCAD').AsString := '';
  cdsDados.Post;
  blnPedeMotivo := True;
end;

function TGerenciaMovimentacaoGondola.fMudandoStatusDeAutorizadoParaOutroPedeLiberacao: Boolean;
begin
  Result := False;
  If (cdsDados.FieldByName('SOL_STATUS').AsInteger <> 2) and (cdsDados.FieldByName('OLD_SOL_STATUS').AsInteger = 2) Then
  Begin
    If FExecutandoAcaoEmMassa and FJaFoiSolicitadaLiberacao Then
      Result := Not FTravaLiberada
    Else
      Result := True;
  End;
End;


function TGerenciaMovimentacaoGondola.fLiberadoTrocaDeStatus: Boolean;
var objLiberacao : TLiberacao;
begin
  If FJaFoiSolicitadaLiberacao Then
  begin
    Result := FTravaLiberada;
    Exit;
  End;
  objLiberacao := TLiberacao.create;
  Try
    objLiberacao.Clear;
    objLiberacao.strDirAce    := 'LIBGONABRIR';
    objLiberacao.strMsgSen    := 'Reabrir Gondola';
    objLiberacao.strCodOpe    := strLoginUsuarioLogado;
    objLiberacao.objMsgLibera.pAddTexto('Atenção esta solicitação ja foi autorizada, confirmar a alteração de Status status?');

    Result := objLiberacao.fLibera;
    If FExecutandoAcaoEmMassa then
      FJaFoiSolicitadaLiberacao := True
    Else
      FJaFoiSolicitadaLiberacao := False;

    FTravaLiberada := Result;
  Finally
    FreeAndNil(objLiberacao)
  End;
End;

procedure TGerenciaMovimentacaoGondola.OnCdsDadosBeforePost(DataSet: TDataSet);
  var strLocFis, strMensagem: string;
begin
  Try
    If fMudandoStatusDeAutorizadoParaOutroPedeLiberacao then
      If Not fLiberadoTrocaDeStatus Then
        cdsDados.FieldByName('SOL_STATUS').AsInteger := cdsDados.FieldByName('OLD_SOL_STATUS').AsInteger;

    //Marcando para autorizado
    If ((cdsDados.FieldByName('OLD_SOL_STATUS').AsInteger <> 2) and (cdsDados.FieldByName('SOL_STATUS').AsInteger = 2)) Then
    Begin
      If (cdsDados.FieldByName('TEM_LOTE').AsInteger = 0) and
         (fEmptyStr(cdsDados.FieldByName('SOL_FISORI').AsString)) Then
      begin
        If (not FExecutandoAcaoEmMassa) Then
          pMensagemOk('Para item sem lote, a Localização Física de Origem precisa ser definada!');
        cdsDados.FieldByName('SOL_STATUS').AsInteger := cdsDados.FieldByName('OLD_SOL_STATUS').AsInteger;
      End
      Else If (cdsDados.FieldByName('TEM_LOTE').AsInteger > 0) and
              (cdsDados.FieldByName('SOL_LOTORI').AsString = '') Then
      Begin
        If (not FExecutandoAcaoEmMassa) Then
          pMensagemOk('O Lote precisa ser definido!');
        cdsDados.FieldByName('SOL_STATUS').AsInteger := cdsDados.FieldByName('OLD_SOL_STATUS').AsInteger;
      End

    End;

    If cdsDados.FieldByName('SOL_STATUS').AsInteger = 0 Then
      cdsDados.FieldByName('SOL_OBSTRA').AsString := '';
    If Not blnDesmarcarTodos Then
      cdsDados.FieldByName('MARCAD').AsString := '';
    If (cdsDados.FieldByName('SOL_QTDATD').AsFloat <= 0) then
        cdsDados.FieldByName('SOL_QTDATD').AsFloat := 1;

    If blnPedeMotivo then
      If (cdsDados.FieldByName('SOL_STATUS').AsInteger <> 0) And
         (cdsDados.FieldByName('SOL_OBSTRA').AsString = '') and
         (Not (cdsDados.FieldByName('OLD_SOL_STATUS').AsInteger = cdsDados.FieldByName('SOL_STATUS').AsInteger)) Then
      cdsDados.FieldByName('SOL_OBSTRA').AsString := TfrmDigMotivo.fDigMotivo('Motivo:');

    //Desmacando autorizado
    If (cdsDados.FieldByName('OLD_SOL_STATUS').AsInteger = 2) and
       (cdsDados.FieldByName('SOL_STATUS').AsInteger <> 2) Then
    begin
      cdsDados.FieldByName('SOL_IMPREA').AsString := 'N';
      cdsDados.FieldByName('SOL_OBSTRA').AsString := '';
      cdsDados.FieldByName('OPESEL').AsString := '';
      cdsDados.FieldByName('SOL_OPESEP').Clear;
      cdsDados.FieldByName('SOL_LOTORI').AsString := '';
      cdsDados.FieldByName('SOL_FISORI').AsString := '';
    End;
    cdsDados.FieldByName('OLD_SOL_STATUS').AsInteger := cdsDados.FieldByName('SOL_STATUS').AsInteger;

    If cdsDados.FieldByName('TEM_LOTE').AsInteger > 0 Then
    begin
      If cdsDados.FieldByName('SOL_LOTORI').AsString = cdsDados.FieldByName('SOL_NUMLOT').AsString Then
      begin
        pMensagemOk('Lote de Origem não pode ser igual ao Lote de Destino!');
        cdsDados.FieldByName('SOL_LOTORI').AsString := '';
      End;

      If Not blnDesmarcarTodos Then
      begin
        If (not fEmptyStr(cdsDados.FieldByName('SOL_LOTORI').AsString)) And (strLoteOriginal <> cdsDados.FieldByName('SOL_LOTORI').AsString) then
        begin
          If (Not fLoteValido(cdsDados.FieldByName('SOL_CODITE').AsString, cdsDados.FieldByName('SOL_LOTORI').AsString, strMensagem, strLocFis)) Then
          begin
            pMensagemOk(strMensagem);
            cdsDados.FieldByName('SOL_LOTORI').AsString := '';
          End
          Else If  strLocFis <> '' Then
            cdsDados.FieldByName('SOL_FISORI').AsString := strLocFis;

        End;
        cdsDados.FieldByName('SALDIS').AsFloat := fRetornaSaldoDisponivel(cdsDados.FieldByName('SOL_CODITE').AsString,
                                                                                                 False,
                                                                                                 False,
                                                                                                 cdsDados.FieldByName('SOL_LOTORI').AsString,
                                                                                                 True,
                                                                                                 VS_StrCodEmp,
                                                                                                 '',
                                                                                                 False,
                                                                                                 True,
                                                                                                 True,
                                                                                                 False,
                                                                                                 False,
                                                                                                 False,
                                                                                                 '',
                                                                                                 '',
                                                                                                 False,
                                                                                                 True);
        If cdsDados.FieldByName('SALDIS').AsFloat < cdsDados.FieldByName('SOL_QTDATD').AsFloat then
          cdsDados.FieldByName('SOL_QTDATD').AsFloat := cdsDados.FieldByName('SALDIS').AsFloat;
      End;
    End;
    Salvar;

  Except
    on e: Exception do
      pMensagemOk(e.message);
  End

end;

procedure TGerenciaMovimentacaoGondola.pAcaoEmMassa(Acao: TAcaoManutGandola);
  var frmGravando: TFrmGravando;
      strAcao: string;
begin
  FAcaoExcutando:= Acao;
  pCriarFormularios(TfrmGravando, frmGravando);
  try
     case Acao of
       tamgIndefini: strAcao := 'Indifinido';
       tamgNegar: strAcao := 'Negado';
       tamgAutorizar: strAcao := 'Autorizado';
     end;
     frmGravando.lblGravando.Caption := 'Definindo marcados como ' + strAcao;
     frmGravando.fExecutarAcao := fAcaoEmMassa;
     frmGravando.ShowModal;
  Finally
    pFreeAndNil(frmGravando);
  End;
end;

procedure TGerenciaMovimentacaoGondola.pAtualizaComoImpresso();
var qryComand: TUniQuery;
begin
  qryComand := fCriaQuery;
  try

    if Not FReimpressao Then
    Begin
      cdsDados.Filter := 'SOL_STATUS = 2';
      cdsDados.Filtered := True;
    End;

    qryComand.SQL.Add('UPDATE SOLGON SET SOL_IMPREA = "S" WHERE AUTOINCREM = :AUTINC');
    cdsDados.First;
    while not cdsDados.Eof Do
    Begin
      qryComand.ParamByName('AUTINC').AsString :=  cdsDados.FieldByName('AUTOINCREM').AsString;
      qryComand.ExecSQL;
      cdsDados.Next;
    End;
  Finally
    FreeAndNil(qryComand);
  End;

end;

procedure TGerenciaMovimentacaoGondola.pImprimir(blnConteudoTela: Boolean; AOrigem: String = '');
Var
  objImpressao: TEditorFastImpressao;
  strNomeFila, strTipImp: String;
  qryCfgRel: TUniQuery;
Begin
  objImpressao := TEditorFastImpressao.Create(Nil);


  qryCfgRel := fCriaQuery;
  try
    If AOrigem = '' Then
      pCarregaConfImpr(qryCfgRel, 'frmPainelMovimentacaoGondola')
    Else
      pCarregaConfImpr(qryCfgRel, AOrigem);
    fPreImpressao(qryCfgRel, strNomeFila, strTipImp, False, '');

    objImpressao.tpeTipoEtiqueta     := tpeSeparacaoGondola;
    objImpressao.recDocume.intQtdImp := 1;
    objImpressao.recDocume.blnReimpr := False;
    objImpressao.recDocume.blnDocCan := False;
    objImpressao.recDocume.blnQtdOri := False;
    objImpressao.recDocume.blnConfir := False;
    objImpressao.recDocume.blnDocSep := False;
    objImpressao.recDocume.blnImpExpedicao := False;
    objImpressao.recDocume.blnFilEmp := False;
    objImpressao.recDocume.blnImpFil := False;
    objImpressao.recDocume.blnSepFut := False;
    objImpressao.recDocume.blnEnt_CD := False;
    objImpressao.recDocume.blnSimples               := False;
    objImpressao.recDocume.blnSempreEntr            := False;
    objImpressao.recDocume.blnRequisicao            := False;
    objImpressao.recDocume.blnLocFisEmpEmi          := False;
    objImpressao.recDocume.blnAgruparItensSeparacao := False;
    objImpressao.recDocume.blnVisPdf := True;
    objImpressao.recDocume.strSaida  := 'P';
//    objImpressao.recDocume.strPasPdf := AForceLocalPDF;
    objImpressao.recDocume.strNomImp   := strNomeFila;
    objImpressao.recDocume.strTipImp   := strTipImp;

    objImpressao.recDocume.SeparacaoGondolaFiltro.strListaSolGon := '';
    objImpressao.recDocume.SeparacaoGondolaFiltro.blnFiltraApenasListaSolGon := False;
    If blnConteudoTela Then
      objImpressao.recDocume.SeparacaoGondolaFiltro.blnFiltraApenasListaSolGon := True;

    while not cdsDados.Eof Do
    Begin
      objImpressao.recDocume.SeparacaoGondolaFiltro.strListaSolGon := objImpressao.recDocume.SeparacaoGondolaFiltro.strListaSolGon +
                                                                      '"' +cdsDados.FieldByName('AUTOINCREM').AsString + '"';
      objImpressao.recDocume.SeparacaoGondolaFiltro.strListaSolGon := AnsiReplaceStr(objImpressao.recDocume.SeparacaoGondolaFiltro.strListaSolGon, '""', '","');
      cdsDados.Next;
    End;
    If objImpressao.fImprimeDocumento(tpaPDF, '', '') Then
     If Not blnConteudoTela Then
      pAtualizaComoImpresso;
  Finally
    FreeAndNil(objImpressao);
    FreeAndNil(qryCfgRel);
  End;

end;

function TGerenciaMovimentacaoGondola.fLiberaReimpressao: Boolean;
var objLiberacao : TLiberacao;
begin
  objLiberacao := TLiberacao.create;
  Try
    objLiberacao.Clear;
    objLiberacao.strDirAce    := 'LIBGONREIMP';
    objLiberacao.strMsgSen    := 'Reimprimir separação gôndola';
    objLiberacao.strCodOpe    := strLoginUsuarioLogado;
    objLiberacao.objMsgLibera.pAddTexto('Liberação para reimpressão da separação.');
    Result := objLiberacao.fLibera;
  Finally
    FreeAndNil(objLiberacao)
  End;
End;

procedure TGerenciaMovimentacaoGondola.pImprimirSeparacao(blnConteudoTela: Boolean; blnReimpressao: Boolean = False);
var
  OperadorDeDestino: String;
  lNomOpe: string;
begin
  lNomOpe := '';
  cdsDados.DisableControls;
  Try
    OperadorDeDestino := '';
    cdsDados.Filter := 'SOL_STATUS = 2';
    If blnConteudoTela then
    begin
      cdsDados.Filter := cdsDados.Filter + ' AND SOL_IMPREA = ' + IIf(blnReimpressao,  QuotedStr('S'), QuotedStr('N'));
      If blnReimpressao then
      begin
        OperadorDeDestino := TfrmDigOperador.fGetCodOperador_ComDescricao('', 'Informe para qual operador deseja reimprimir!', lNomOpe);
        cdsDados.Filter := cdsDados.Filter + ' AND SOL_OPESEP = ' + QuotedStr(OperadorDeDestino);
        If fEmptyStr(OperadorDeDestino) then
        begin
          pMensagemOk('Operador da separação precisa ser informado!');
          Exit;
        End;
      End;
    End;

    cdsDados.Filtered := True;
    Try
      If cdsDados.IsEmpty then
      begin
        pMensagemOk('Sem dados para imprimir!');
        Exit;
      End;

      if  blnReimpressao then
        If not fLiberaReimpressao then
          Exit;

      If blnConteudoTela and (not blnReimpressao) Then
      begin
        OperadorDeDestino := TfrmDigOperador.fGetCodOperador_ComDescricao('', 'Selecione o operador que vai fazer a separação!', lNomOpe);
        If fEmptyStr(OperadorDeDestino) then
        begin
          pMensagemOk('Operador de separação precisa ser definido!');
          Exit;
        End;
      end;

      If (blnConteudoTela) And (Not blnReimpressao) And (Not fPergunta('Deseja imprimir os produtos que devem ser separados e transferidos?')) Then
        Exit;

      pImprimir(blnConteudoTela, '');

      cdsDados.First;
      If Not blnReimpressao Then
      Begin
        while not cdsDados.IsEmpty Do
        Begin
          cdsDados.Edit;
          If blnConteudoTela Then
          begin
            cdsDados.FieldByName('SOL_OPESEP').AsString := OperadorDeDestino;
            cdsDados.FieldByName('OPESEL').AsString := OperadorDeDestino + '-' + lNomOpe;
          End;
          cdsDados.FieldByName('SOL_IMPREA').AsString := 'S';
          cdsDados.Post;
        End;
      End;
    finally
      cdsDados.Filtered := False;
    End;
  Finally
    cdsDados.EnableControls;
  End;
end;

class procedure TGerenciaMovimentacaoGondola.pPainelGondola;
var GerenciaMovimentacaoGondola: TGerenciaMovimentacaoGondola;
begin

  GerenciaMovimentacaoGondola := TGerenciaMovimentacaoGondola.Create;
  Try
    GerenciaMovimentacaoGondola.CriaCdsPainel;
    If GerenciaMovimentacaoGondola.cdsDados.IsEmpty Then
    begin
      pMensagemOk('Sem pendências!');
      Exit;
    End;
    TfrmPainelMovimentacaoGondola.pAbrePainel(GerenciaMovimentacaoGondola);
  Finally
    FreeAndNil(GerenciaMovimentacaoGondola)
  End;

end;

procedure TGerenciaMovimentacaoGondola.processaReimpressao(ALocal: String; ASeparacaoGondolaFiltro: TSeparacaoGondolaFiltro);
begin
  If Assigned(cdsDados) Then
    FreeAndNil(cdsDados);

  cdsDados := TZClient.Create(nil);
  Try

    cdsDados.qryQuery.SQL.Add('SELECT SOLGON.AUTOINCREM');
    cdsDados.qryQuery.SQL.Add('  FROM SOLGON');
    cdsDados.qryQuery.SQL.Add('  INNER JOIN CADITE C ON C.ITE_CODITE = SOL_CODITE');
    cdsDados.qryQuery.SQL.Add('  LEFT JOIN CADOPE OS ON OS.OPE_CODOPE = SOL_CODOPE');
    cdsDados.qryQuery.SQL.Add('  LEFT JOIN CADOPE OB ON OB.OPE_CODOPE = SOL_OPEBAI');
    cdsDados.qryQuery.SQL.Add(' WHERE SOL_CODEMP = "'+VS_strCodEmp+'"');
    If not fEmptyStr(ASeparacaoGondolaFiltro.strOperadorSolicitacao) Then
      cdsDados.qryQuery.SQL.Add(' AND OS.OPE_CODOPE = "'+ASeparacaoGondolaFiltro.strOperadorSolicitacao+'"');
    If not fEmptyStr(ASeparacaoGondolaFiltro.strOperadorEfetivacao) Then
      cdsDados.qryQuery.SQL.Add(' AND OB.OPE_CODOPE = "'+ASeparacaoGondolaFiltro.strOperadorEfetivacao+'"');
    Case ASeparacaoGondolaFiltro.TipoSeparacaoGondolaImpressaoFiltro of
      tsgiImpresso:      cdsDados.qryQuery.SQL.Add('  AND SOL_IMPREA = "S"');
      tsgiffNaoImpresso: cdsDados.qryQuery.SQL.Add('  AND SOL_IMPREA = "N"');
    End;
    cdsDados.qryQuery.SQL.Add('  AND SOL_STATUS = 2');

    If ASeparacaoGondolaFiltro.dtaDataEfetivacao > 0 Then
      cdsDados.qryQuery.SQL.Add('  AND DATE(SOL_DTABAI) = :DTABAI')
    Else
      cdsDados.qryQuery.SQL.Add('  AND SOL_DTABAI IS NOT NULL');
    If Not fEmptyStr(ASeparacaoGondolaFiltro.strListaSolGon) Then
      cdsDados.qryQuery.SQL.Add('  AND SOLGON.AUTOINCREM IN ('+ASeparacaoGondolaFiltro.strListaSolGon+')');

    cdsDados.qryQuery.ParamByName('DTABAI').AsDate := ASeparacaoGondolaFiltro.dtaDataEfetivacao;

    cdsDados.fAbreClient(False, '[TGerenciaMovimentacaoGondola.processaReimpressao]');
    If cdsDados.IsEmpty Then
    Begin
      pMensagemOK('Sem dados para imprimir!');
      Exit;
    End;
    pImprimir(False, ALocal);
  Finally
    FreeAndNil(cdsDados) ;
  End;
end;

class procedure TGerenciaMovimentacaoGondola.pSolicitacaodeReposicaodeGondola;
var frmSolicitacaodeReposicaodeGondola: TfrmSolicitacaodeReposicaodeGondola;
begin
  pCriarFormularios(TfrmSolicitacaodeReposicaodeGondola, frmSolicitacaodeReposicaodeGondola);
  Try
    frmSolicitacaodeReposicaodeGondola.Showmodal;
  Finally
    FreeAndNil(frmSolicitacaodeReposicaodeGondola);
  End
end;

procedure TGerenciaMovimentacaoGondola.Salvar;
//  var frmGravando: TFrmGravando;
begin
//  pCriarFormularios(TfrmGravando, frmGravando);
//  try
//     frmGravando.lblGravando.Caption := 'Salvando dados!';
//     frmGravando.fExecutarAcao := fSalvar;
//     frmGravando.ShowModal;
    fSalvar;
//  Finally
//    pFreeAndNil(frmGravando);
//  End;
end;

end.
