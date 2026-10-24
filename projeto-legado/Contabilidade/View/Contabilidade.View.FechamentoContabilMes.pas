unit Contabilidade.View.FechamentoContabilMes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Contabilidade.View.TfrmPaiContabilidade, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, EditFocus, Vcl.Mask, MaskEditFocus, Uni, cxProgressBar,
  Contabilidade.Classes.TGravacaoEmLote, FireDAC.Comp.Client, FireDAC.Stan.Param,
  Data.DB, StrUtils, untTypesSistema, Contabilidade.Interfaces;

type
  TfrmFechamentoContabilMes = class(TfrmPaiContabilidade)
    Panel1: TPanel;
    Label2: TLabel;
    btnGerar: TBitBtnLocked;
    mskPeriodo: TMaskEditFocus;
    Label1: TLabel;
    edtEmpGrv: TEditFocus;
    edtNomEmpGrv: TEditFocus;
    btnCheckList: TBitBtnLocked;
    procedure btnGerarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure edtEmpGrvKeyPress(Sender: TObject; var Key: Char);
    procedure btnCheckListClick(Sender: TObject);
  private
    { Private declarations }
    intTamanhoLote : integer;
    FGravacaoEmLote : TGravacaoEmLote;
    qryConDetails : TUniQuery;
    arrEmpSel: TConsultasArray;
    const HISTORICO_APURACAO : String = 'APURAÇÃO DO RESULTADO DO EXERCÍCIO';
    procedure pApuracao(strDigito: string; pgbProgresso: TcxProgressBar; strTexto: string; blnApuracaoAposLucroOperacional: boolean = false);
    procedure pLucroPrejuizo(pgbProgresso: TcxProgressBar);
    function fExercicio: integer;
    function fGerar(pgbProgresso: TcxProgressBar): Boolean;
    procedure pSetaTextoProgresso(pgbProgresso: TcxProgressBar; strTexto: String);
    procedure pDeletaLanMes;
    procedure pDeletaPlaMes;
    function fDataInicial: TDate;
    function fDataFinalAnterior: TDate;
    function fDataFinal: TDate;
    procedure pGravaBalancete(pgbProgresso: TcxProgressBar);
    procedure pAtualizarSaldoInicialDoAnoSeguinteSubContas(pgbProgresso: TcxProgressBar);
    procedure pDeletaBalancete;
    procedure pDeletaFecMes;
    procedure pGravaFecMes;
    function fValidaMesesAnteriores: boolean;
    procedure pAtualizarSaldoInicialDoAnoSeguinte(const ADataFinal: TDate;
      const AValorFinal: double; const ACodigoConta: string;
      const ACentroCusto: string);
    function fGetInEmpresas: string;
    function fValidaCnpjEmpresasEnvolvidas: boolean;
    function fCampoCCustoLanBal(blCfg:boolean):string ;
    function fCampoCCustoPlaMes(blCfg:boolean):string ;
    function fCampoCCustoLanMes(blCfg:boolean):string ;
    procedure pDeletaPlaIniProximoExercicio(const ADataFinal:TDate) ;
    function fVerificaFechamentoOutrasEmpresas(const AintAno, AintMes:integer): boolean ;
  public
    { Public declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

var
  frmFechamentoContabilMes: TfrmFechamentoContabilMes;

implementation

uses
  untFuncoesSimples, untConsultas, System.Generics.Collections, untFuncoesConsulta,
  Contabilidade.Model.TDadosImportacaoContabil, DateUtils, Contabilidade.Funcoes,
  FireDAC.Stan.Option, Contabilidade.View.CheckListImportacao;

{$R *.dfm}

procedure TfrmFechamentoContabilMes.btnCheckListClick(Sender: TObject);
var
  LfrmCheckListImportacao : TfrmCheckListImportacao;
begin
  pCriarFormularios(TfrmCheckListImportacao, LfrmCheckListImportacao);
  try
    LfrmCheckListImportacao.TipoCheckList := tclFechamentoContabilMes ;
    LfrmCheckListImportacao.Caption := 'CheckList Fechamento Contábil Mensal' ;
    LfrmCheckListImportacao.ShowModal;
  finally
    pFreeAndNil(LfrmCheckListImportacao);
  end;
end;

procedure TfrmFechamentoContabilMes.btnGerarClick(Sender: TObject);
  const
    MSG_FEC_CONTABIL_NAO_REALIZADO : string = 'Fechamento contábil ainda não realizado, acesse a rotina e execute primeiro o fechamento contábil!';
begin
  if not fVerificaCampos then
    exit;

  If fEmptyStr(mskPeriodo.Text, True) Then
  Begin
    fMensagem('ATENÇÃO!', 'Obrigatório preenchimento do período!', ['&OK']);
    pSetFocus(mskPeriodo);
    Exit;
  End;

  arrEmpSel := fObtemEmpresasFiliais(edtEmpGrv.Text) ;

  if not fPeriodoFechado(fDataInicial, fDataFinal, edtEmpGrv.Text) then
  begin
    fMensagem('ATENÇÃO!', MSG_FEC_CONTABIL_NAO_REALIZADO, ['&OK']);
    Exit;
  end;

  if fEmptyStr(fCfgSis('DIGATI')) then
  begin
    fMensagem('ATENÇÃO!', 'Dígito identificador - "Ativo" não está preenchido, verifique a configuração "CFG_DIGATI"', ['&Ok']);
    exit;
  end;

  if fEmptyStr(fCfgSis('DIGPAS')) then
  begin
    fMensagem('ATENÇÃO!', 'Dígito identificador - "Passivo" não está preenchido, verifique a configuração "CFG_DIGPAS"', ['&Ok']);
    exit;
  end;

  if fEmptyStr(fCfgDigrec) then
  begin
    fMensagem('ATENÇÃO!', 'Dígito identificador - "Receita" não está preenchido, verifique a configuração "CFG_DIGREC"', ['&Ok']);
    exit;
  end;

  if fEmptyStr(fCfgDigdes) then
  begin
    fMensagem('ATENÇÃO!', 'Dígito identificador - "Despesa" não está preenchido, verifique a configuração "CFG_DIGDES"', ['&Ok']);
    exit;
  end;

  if fEmptyStr(fCfgSis('CONRES')) then
  begin
    fMensagem('ATENÇÃO!', 'Conta para "APURAÇÃO DO RESULTADO DO EXERCÍCIO" não está preenchida, verifique a configuração "CFG_CONRES"', ['&Ok']);
    exit;
  end;

  if fEmptyStr(fCfgSis('CONLUC')) then
  begin
    fMensagem('ATENÇÃO!', 'Conta para lançamento "LUCRO" não está preenchida, verifique a configuração "CFG_CONLUC"', ['&Ok']);
    exit;
  end;

  if fEmptyStr(fCfgSis('CONPRE')) then
  begin
    fMensagem('ATENÇÃO!', 'Conta para lançamento "PREJUÍZO" não está preenchida, verifique a configuração "CFG_CONPRE"', ['&Ok']);
    exit;
  end;

  if (not fValidaMesesAnteriores) then
  begin
    fMensagem('ATENÇÃO!', 'É necessário efetuar o fechamento dos meses anteriores!', ['&Ok']);
    exit;
  end;

  if fEmptyStr(fGetInEmpresas) then
    Exit;

  if not fValidaCnpjEmpresasEnvolvidas then
  begin
    fMensagem('ATENÇÃO!', 'Somente podem estar selecionadas juntas, empresas do mesmo CNPJ base - Matriz/Filiais!', ['&OK']);
    exit;
  end;

  if not fVerificaFechamentoOutrasEmpresas(YearOf(strToDate('01/'+mskPeriodo.Text)), MonthOf(strToDate('01/'+mskPeriodo.Text))) then
  begin
    exit ;
  end;

  if fMensagem('ATENÇÃO!', 'Todas as empresas pertencentes a Raiz do CNPJ serão consolidadas, confirma?', ['&Sim', '&Não'], 1) = 2 then
    Exit;

  fChamaTelaGravando(fGerar);

  pSetFocus(mskPeriodo);
end;

procedure TfrmFechamentoContabilMes.edtEmpGrvKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrEmp: TConsultasArray;
begin
  inherited;
  If fPesqEmpresa(conEmpSimples, Self, edtEmpGrv, edtNomEmpGrv, Nil, Key, arrEmp) Then
  Begin
    If fValidaCampos(edtEmpGrv) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmFechamentoContabilMes.fCampoCCustoLanBal(blCfg:boolean): string;
begin
  if blCfg then
    result := 'IFNULL(BAL_CCUSTO,'+QuotedStr('')+')'
  else
    result := 'CONVERT(NULL, CHAR(5))' ;
end;

function TfrmFechamentoContabilMes.fCampoCCustoLanMes(blCfg:boolean): string;
begin
  if blCfg then
    result := 'IFNULL(CON_CCUSTO,'+QuotedStr('')+')'
  else
    result := 'CONVERT(NULL, CHAR(5))' ;
end;


function TfrmFechamentoContabilMes.fCampoCCustoPlaMes(blCfg:boolean): string;
begin
  if blCfg then
    result := 'IFNULL(MES_CCUSTO,'+QuotedStr('')+')'
  else
    result := 'CONVERT(NULL, CHAR(5))' ;
end;

function TfrmFechamentoContabilMes.fDataFinal: TDate;
begin
  Result := DateOf(EndOfTheMonth(fDataInicial));
end;

function TfrmFechamentoContabilMes.fDataFinalAnterior: TDate;
begin
  Result := DateOf(EndOfTheMonth(IncMonth(fDataInicial, -1)));
end;

function TfrmFechamentoContabilMes.fDataInicial: TDate;
  Var
    wordDia, wordMes, wordAno: Word;
begin
  wordDia := 1;
  wordMes := StrToInt(LeftStr(mskPeriodo.Text, 2));
  wordAno := StrToInt(RightStr(mskPeriodo.Text, 4));
  Result := EncodeDate(wordAno, wordMes, wordDia);
end;

function TfrmFechamentoContabilMes.fExercicio: integer;
begin
  Result := StrToInt(RightStr(mskPeriodo.Text, 4));
end;

function TfrmFechamentoContabilMes.fGerar(pgbProgresso: TcxProgressBar): Boolean;
begin
  FGravacaoEmLote.fStartTransaction;
  try
    pDeletaLanMes;
    pDeletaPlaMes;
    pApuracao(fCfgDigrec, pgbProgresso, 'Receita');
    pApuracao(fCfgDigdes, pgbProgresso, 'Despesa');
    pApuracao(fCfgDigcus, pgbProgresso, 'Custo');
    pApuracao(fCfgSis('DIGATI'), pgbProgresso, 'Ativo');
    pApuracao(fCfgSis('DIGPAS'), pgbProgresso, 'Passivo');
    pApuracao('', pgbProgresso, 'Apuração após lucro operacional', True);
    pLucroPrejuizo(pgbProgresso);
    pDeletaBalancete;
    pDeletaFecMes;
    pDeletaPlaIniProximoExercicio(fDataFinal);
    pGravaBalancete(pgbProgresso);
    pAtualizarSaldoInicialDoAnoSeguinteSubContas(pgbProgresso) ;
    pGravaFecMes ;
    FGravacaoEmLote.fCommit;
    Result := True;
    fMensagem('ATENÇÃO!', 'Fechamento concluído com sucesso!', ['&OK']);
  except
    On E: Exception do
    begin
      FGravacaoEmLote.fRollBack;
      raise;
    end;
  end;
end;

procedure TfrmFechamentoContabilMes.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(mskPeriodo);
end;

procedure TfrmFechamentoContabilMes.FormCreate(Sender: TObject);
begin
  inherited;
  intTamanhoLote := fCfgSis('LOTCON', varInteger);

  edtEmpGrv.Text := VS_strCodEmp;
  edtNomEmpGrv.Text := fRetNomeEmpresaSelec(VS_strCodEmp);

  qryConDetails := fCriaQuery;
  FGravacaoEmLote := TGravacaoEmLote.Create(Nil, qryConDetails.Connection.Database,
    qryConDetails.Connection.Username, qryConDetails.Connection.Password,
    IntToStr(qryConDetails.Connection.Port), qryConDetails.Connection.Server);
end;

procedure TfrmFechamentoContabilMes.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FGravacaoEmLote);
  FreeAndNil(qryConDetails);
  inherited;
end;

function TfrmFechamentoContabilMes.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = edtEmpGrv) Then
    Begin
      If (Not fEmptyStr(edtEmpGrv.Text)) Then
      Begin
        edtNomEmpGrv.Text := fCampoTabela('EMP_NOMEMP', 'CADEMP', ['EMP_CODEMP'], [edtEmpGrv.Text], False);
        If (fEmptyStr(edtNomEmpGrv.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa empresa não está cadastrada!', ['&Ok']);
          Result := False;
        End;
      End
      Else
      begin
        edtNomEmpGrv.Clear;
        fMensagem('ATENÇÃO!', 'Empresa de gravação deve ser preenchida!', ['&Ok']);
        Result := False;
      end;
    End;

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

function TfrmFechamentoContabilMes.fValidaMesesAnteriores: boolean;
  var
    qryFecMes : TUniQuery;
begin
  Result := True;
  if (LeftStr(mskPeriodo.Text, 2) <> '01') then
  begin
    qryFecMes := fCriaQuery;
    try
      qryFecMes.SQL.Text := 'SELECT COUNT(*) AS CNT FROM FECMES WHERE MES_CODEMP = :CODEMP AND MES_MESDTA = :MESDTA';
      qryFecMes.ParamByName('CODEMP').AsString := edtEmpGrv.Text;
      qryFecMes.ParamByName('MESDTA').AsDate := fDataFinalAnterior;
      qryFecMes.Open;
      Result := (qryFecMes.FieldByName('CNT').AsInteger > 0);
      qryFecMes.Close;
    finally
      FreeAndNil(qryFecMes);
    end;
  end;
end;

function TfrmFechamentoContabilMes.fVerificaFechamentoOutrasEmpresas(
  const AintAno, AintMes: integer): boolean;
var
  qryVer: TUniQuery ;
  strMensagem: string ;
  LintNumeroLinhas: Integer ;
begin
  result := True ;
  qryVer := fCriaQuery;
  try
    qryVer.Close ;
    qryVer.SQL.Clear ;
    qryVer.SQL.Add(' SELECT DISTINCT MES_CODEMP, CADEMP.EMP_NOMEMP ') ;
    qryVer.SQL.Add('  FROM FECMES INNER JOIN CADEMP ON CADEMP.EMP_CODEMP = FECMES.MES_CODEMP ') ;
    qryVer.SQL.Add('  WHERE MES_CODEMP <> :CODEMP ') ;
    qryVer.SQL.Add('        AND MES_CODEMP IN (' + fGetInEmpresas + ') ') ;
    qryVer.SQL.Add('        AND EXTRACT(YEAR FROM MES_MESDTA) =  :ANO ') ;
    qryVer.SQL.Add('        AND EXTRACT(MONTH FROM MES_MESDTA) = :MES ') ;
    qryVer.ParamByName('ANO').AsInteger := AintAno ;
    qryVer.ParamByName('MES').AsInteger := AintMes ;
    qryVer.ParamByName('CODEMP').AsString := edtEmpGrv.Text;
    qryVer.Open ;
    if not qryVer.IsEmpty then
    begin
      strMensagem := '' ;
      qryVer.First ;
      LintNumeroLinhas := 2 ;
      while not qryVer.Eof do
      begin
        strMensagem := strMensagem +  qryVer.FieldByName('MES_CODEMP').AsString + ' - ' + qryVer.FieldByName('EMP_NOMEMP').AsString + #13#10 ;
        LintNumeroLinhas := LintNumeroLinhas + 1 ;
        qryVer.Next ;
      end;

      result := fMensagem('Aviso',
                          'Há fechamento contábil nas seguintes empresas:' + #13#10 + strMensagem + #13#10 + 'Confirma a exclusão?',
                          ['&Sim', '&Não'],
                          1,
                          False,
                          1,
                          0,
                          False,
                          0,
                          False,
                          False,
                          False,
                          0,
                          0,
                          LintNumeroLinhas) = 1 ;
    end;
  finally
    FreeAndNil(qryVer);
  end;
end;

procedure TfrmFechamentoContabilMes.pApuracao(strDigito: string; pgbProgresso: TcxProgressBar; strTexto: string; blnApuracaoAposLucroOperacional: boolean = false);
  var
    qryApuracao : TUniQuery;
    dados : TDadosImportacaoContabil;
    lstDados : TObjectList<TDadosImportacaoContabil>;
    intCount : integer;
    intRecordCount : Integer;
    blCfg : boolean ;
    strCampoCCustoPlaIni : string ;
    strCampoCCustoLanBal : string ;
    strCampoCCustoPlaMes : string ;
    strCampoCCustoLanMes : string ;
    strCampoCCustoLanConDeb : string ;
    strCampoCCustoLanConCred : string ;
    fltValor : double ;
    intTamanhoDigito: integer ;
begin
  if fEmptyStr(strDigito) then
  begin
    exit ;
  end;
  pSetaTextoProgresso(pgbProgresso, 'Apurando: ' + strTexto);

  blCfg := fTemCfgFconcc ;
  strCampoCCustoPlaIni := fCampoCCustoPlaIni(blCfg) ;
  strCampoCCustoLanBal := fCampoCCustoLanBal(blCfg) ;
  strCampoCCustoPlaMes := fCampoCCustoPlaMes(blCfg) ;
  strCampoCCustoLanMes := fCampoCCustoLanMes(blCfg) ;
  strCampoCCustoLanConDeb := fCampoCCustoLanConDeb(blCfg) ;
  strCampoCCustoLanConCred := fCampoCCustoLanConCred(blCfg) ;
  intTamanhoDigito := fLenDig(fSemMascaraPlaNco(strDigito)) ;
  qryApuracao := fCriaQuery(Self);
  lstDados := TObjectList<TDadosImportacaoContabil>.Create;
  try
    qryApuracao.Close;
    qryApuracao.SQL.Clear;
    qryApuracao.SQL.Add(' SELECT CONTA, SUM(VALOR) AS VALOR, CENTRO_CUSTO ');
    qryApuracao.SQL.Add('   FROM ( ');

    // Saldo Inicial (Anual)
    qryApuracao.SQL.Add('          SELECT INI_CODCON AS CONTA, CAST(' + fCampoSaldoInicialPlaIni + ' AS DECIMAL(12,2)) AS VALOR, ' + strCampoCCustoPlaIni + ' as CENTRO_CUSTO ');
    qryApuracao.SQL.Add('            FROM PLAINI ');
    qryApuracao.SQL.Add('       INNER JOIN CADEMP ON INI_CODEMP = EMP_CODEMP ');
    qryApuracao.SQL.Add('       LEFT JOIN PLANCO ON NCO_CODCON = INI_CODCON AND NCO_TPLACO = EMP_TPLACO  ');
    qryApuracao.SQL.Add('           WHERE INI_CODEMP IN (' + fGetInEmpresas + ') AND INI_EXERCI = :EXERCI ');

    if not blnApuracaoAposLucroOperacional then
      qryApuracao.SQL.Add(' AND LEFT(INI_CODCON,' + intToStr(intTamanhoDigito) + ') = :DIGITO ')
    else
      qryApuracao.SQL.Add(' AND IFNULL(NCO_APURAC,0) = 1 ');

    qryApuracao.SQL.Add('           UNION ALL ');

    // Saldo Inicial (Mensal, ANTES PERÍODO)
    qryApuracao.SQL.Add('          SELECT MES_CODCON AS CONTA, CAST(' + fCampoSaldoInicialPlaMes + ' AS DECIMAL(12,2)) AS VALOR, ' + strCampoCCustoPlaMes + ' as CENTRO_CUSTO ');
    qryApuracao.SQL.Add('            FROM PLAMES ');
    qryApuracao.SQL.Add('       INNER JOIN CADEMP ON MES_CODEMP = EMP_CODEMP ');
    qryApuracao.SQL.Add('       LEFT  JOIN PLANCO ON NCO_CODCON = MES_CODCON AND NCO_TPLACO = EMP_TPLACO ');
    qryApuracao.SQL.Add('           WHERE MES_CODEMP IN (' + fGetInEmpresas + ') AND MES_DTASAL < :DTAINI ');

    if not blnApuracaoAposLucroOperacional then
      qryApuracao.SQL.Add(' AND LEFT(MES_CODCON,' + intToStr(intTamanhoDigito) + ') = :DIGITO ')
    else
      qryApuracao.SQL.Add(' AND IFNULL(NCO_APURAC,0) = 1 ');

    qryApuracao.SQL.Add('           UNION ALL ');

    // Saldo Inicial (Mensal)
    qryApuracao.SQL.Add('          SELECT MES_CODCON AS CONTA, CAST(' + fCampoSaldoInicialPlaMes + '  AS DECIMAL(12,2)) AS VALOR, ' + strCampoCCustoPlaMes + ' as CENTRO_CUSTO ');
    qryApuracao.SQL.Add('            FROM PLAMES ');
    qryApuracao.SQL.Add('       INNER JOIN CADEMP ON MES_CODEMP = EMP_CODEMP ');
    qryApuracao.SQL.Add('       LEFT JOIN PLANCO ON NCO_CODCON = MES_CODCON AND NCO_TPLACO = EMP_TPLACO ');
    qryApuracao.SQL.Add('           WHERE MES_CODEMP IN (' + fGetInEmpresas + ') AND MES_DTASAL = :DTAINI ');

    if not blnApuracaoAposLucroOperacional then
      qryApuracao.SQL.Add(' AND LEFT(MES_CODCON,' + intToStr(intTamanhoDigito) + ') = :DIGITO ')
    else
      qryApuracao.SQL.Add(' AND IFNULL(NCO_APURAC,0) = 1 ');

    qryApuracao.SQL.Add('           UNION ALL ');

    // Apuração até antes do período (LANCON, Crédito)
    qryApuracao.SQL.Add('          SELECT CON_CONCRE AS CONTA, CAST(-SUM(ABS(CON_VALLAN)) AS DECIMAL(12,2)) AS VALOR, ' + strCampoCCustoLanConCred + ' as CENTRO_CUSTO ');
    qryApuracao.SQL.Add('            FROM LANCON ');
    qryApuracao.SQL.Add('       INNER JOIN CADEMP ON CON_EMPLAN = EMP_CODEMP ');
    qryApuracao.SQL.Add('       LEFT JOIN PLANCO ON NCO_CODCON = CON_CONCRE AND NCO_TPLACO = EMP_TPLACO ');
    qryApuracao.SQL.Add('           WHERE CON_EMPLAN IN (' + fGetInEmpresas + ') AND CON_DTALAN < :DTAINI AND YEAR(CON_DTALAN) = :EXERCI ');

    if not blnApuracaoAposLucroOperacional then
      qryApuracao.SQL.Add(' AND LEFT(CON_CONCRE,' + intToStr(intTamanhoDigito) + ') = :DIGITO ')
    else
      qryApuracao.SQL.Add(' AND IFNULL(NCO_APURAC,0) = 1 ');

    qryApuracao.SQL.Add('           GROUP BY CON_CONCRE, '+strCampoCCustoLanConCred);

    qryApuracao.SQL.Add('           UNION ALL ');

    // Apuração até antes do período (LANMES, Crédito)
    qryApuracao.SQL.Add('          SELECT CON_CONCRE AS CONTA, CAST(-SUM(ABS(CON_VALLAN)) AS DECIMAL(12,2)) AS VALOR, ' + strCampoCCustoLanMes + ' as CENTRO_CUSTO ');
    qryApuracao.SQL.Add('            FROM LANMES ');
    qryApuracao.SQL.Add('       INNER JOIN CADEMP ON CON_EMPLAN = EMP_CODEMP ');
    qryApuracao.SQL.Add('       LEFT JOIN PLANCO ON NCO_CODCON = CON_CONCRE AND NCO_TPLACO = EMP_TPLACO ');
    qryApuracao.SQL.Add('           WHERE CON_EMPLAN IN (' + fGetInEmpresas + ') AND CON_DTALAN < :DTAINI AND YEAR(CON_DTALAN) = :EXERCI ');

    if not blnApuracaoAposLucroOperacional then
      qryApuracao.SQL.Add(' AND LEFT(CON_CONCRE,' + intToStr(intTamanhoDigito) + ') = :DIGITO ')
    else
      qryApuracao.SQL.Add(' AND IFNULL(NCO_APURAC,0) = 1 ');

    qryApuracao.SQL.Add('           GROUP BY CON_CONCRE, ' + strCampoCCustoLanMes );

    qryApuracao.SQL.Add('           UNION ALL ');

    // Apuração até antes do período (LANCON, Débito)
    qryApuracao.SQL.Add('          SELECT CON_CONDEB AS CONTA, CAST(SUM(ABS(CON_VALLAN)) AS DECIMAL(12,2)) AS VALOR, ' + strCampoCCustoLanCondeb + ' as CENTRO_CUSTO ');
    qryApuracao.SQL.Add('            FROM LANCON ');
    qryApuracao.SQL.Add('       INNER JOIN CADEMP ON CON_EMPLAN = EMP_CODEMP ');
    qryApuracao.SQL.Add('       LEFT JOIN PLANCO ON NCO_CODCON = CON_CONDEB AND NCO_TPLACO = EMP_TPLACO ');
    qryApuracao.SQL.Add('           WHERE CON_EMPLAN IN (' + fGetInEmpresas + ') AND CON_DTALAN < :DTAINI AND YEAR(CON_DTALAN) = :EXERCI ');

    if not blnApuracaoAposLucroOperacional then
      qryApuracao.SQL.Add(' AND LEFT(CON_CONDEB,' + intToStr(intTamanhoDigito) + ') = :DIGITO ')
    else
      qryApuracao.SQL.Add(' AND IFNULL(NCO_APURAC,0) = 1 ');

    qryApuracao.SQL.Add('           GROUP BY CON_CONDEB, ' + strCampoCCustoLanCondeb );

    qryApuracao.SQL.Add('           UNION ALL ');

    // Apuração até antes do período (LANMES, Débito)
    qryApuracao.SQL.Add('          SELECT CON_CONDEB AS CONTA, CAST(SUM(ABS(CON_VALLAN)) AS DECIMAL(12,2)) AS VALOR, ' + strCampoCCustoLanMes + ' as CENTRO_CUSTO ');
    qryApuracao.SQL.Add('            FROM LANMES ');
    qryApuracao.SQL.Add('       INNER JOIN CADEMP ON CON_EMPLAN = EMP_CODEMP ');
    qryApuracao.SQL.Add('       LEFT JOIN PLANCO ON NCO_CODCON = CON_CONDEB AND NCO_TPLACO = EMP_TPLACO ');
    qryApuracao.SQL.Add('           WHERE CON_EMPLAN IN (' + fGetInEmpresas + ') AND CON_DTALAN < :DTAINI AND YEAR(CON_DTALAN) = :EXERCI ');

    if not blnApuracaoAposLucroOperacional then
      qryApuracao.SQL.Add(' AND LEFT(CON_CONDEB,' + intToStr(intTamanhoDigito) + ') = :DIGITO ')
    else
      qryApuracao.SQL.Add(' AND IFNULL(NCO_APURAC,0) = 1 ');

    qryApuracao.SQL.Add('           GROUP BY CON_CONDEB, ' + strCampoCCustoLanMes);

    qryApuracao.SQL.Add('           UNION ALL ');

    // Apuração do período (Crédito)
    qryApuracao.SQL.Add('          SELECT CON_CONCRE AS CONTA, CAST(-SUM(ABS(CON_VALLAN)) AS DECIMAL(12,2)) AS VALOR, ' + strCampoCCustoLanConCred + ' as CENTRO_CUSTO ');
    qryApuracao.SQL.Add('            FROM LANCON ');
    qryApuracao.SQL.Add('       INNER JOIN CADEMP ON CON_EMPLAN = EMP_CODEMP ');
    qryApuracao.SQL.Add('       LEFT JOIN PLANCO ON NCO_CODCON = CON_CONCRE AND NCO_TPLACO = EMP_TPLACO');
    qryApuracao.SQL.Add('           WHERE CON_EMPLAN IN (' + fGetInEmpresas + ') AND CON_DTALAN BETWEEN :DTAINI AND :DTAFIN ');

    if not blnApuracaoAposLucroOperacional then
      qryApuracao.SQL.Add(' AND LEFT(CON_CONCRE,' + intToStr(intTamanhoDigito) + ') = :DIGITO ')
    else
      qryApuracao.SQL.Add(' AND IFNULL(NCO_APURAC,0) = 1 ');

    qryApuracao.SQL.Add('           GROUP BY CON_CONCRE, ' + strCampoCCustoLanConCred);

    qryApuracao.SQL.Add('           UNION ALL ');

    // Apuração do período (Débito)
    qryApuracao.SQL.Add('          SELECT CON_CONDEB, CAST(SUM(ABS(CON_VALLAN)) AS DECIMAL(12,2)) AS DEBITO, ' + strCampoCCustoLanConDeb + ' as CENTRO_CUSTO ');
    qryApuracao.SQL.Add('            FROM LANCON ');
    qryApuracao.SQL.Add('       INNER JOIN CADEMP ON CON_EMPLAN = EMP_CODEMP ');
    qryApuracao.SQL.Add('       LEFT JOIN PLANCO ON NCO_CODCON = CON_CONDEB AND NCO_TPLACO = EMP_TPLACO ');
    qryApuracao.SQL.Add('           WHERE CON_EMPLAN IN (' + fGetInEmpresas + ') AND CON_DTALAN BETWEEN :DTAINI AND :DTAFIN ');

    if not blnApuracaoAposLucroOperacional then
      qryApuracao.SQL.Add(' AND LEFT(CON_CONDEB,' + intToStr(intTamanhoDigito) + ') = :DIGITO ')
    else
      qryApuracao.SQL.Add(' AND IFNULL(NCO_APURAC,0) = 1 ');

    qryApuracao.SQL.Add('           GROUP BY CON_CONDEB, ' + strCampoCCustoLanConDeb);
    qryApuracao.SQL.Add('          ) AS TMP_APURACA ');
    qryApuracao.SQL.Add('      GROUP BY CONTA, CENTRO_CUSTO ');
    qryApuracao.ParamByName('EXERCI').AsInteger := fExercicio;
    qryApuracao.ParamByName('DTAINI').AsDate := fDataInicial;
    qryApuracao.ParamByName('DTAFIN').AsDate := fDataFinal;
    if not blnApuracaoAposLucroOperacional then
      qryApuracao.ParamByName('DIGITO').AsString := strDigito;
    qryApuracao.Open;

    intCount := 0;
    intRecordCount := qryApuracao.RecordCount;
    pgbProgresso.Properties.Max := intRecordCount;

    qryApuracao.First;
    while not qryApuracao.Eof do
    begin
      intCount := intCount + 1;

      pgbProgresso.Position := qryApuracao.RecNo;
      pSetaTextoProgresso(pgbProgresso, 'Apurando: ' + strTexto + ' - ' + IntToStr(intCount) + '/' + IntToStr(intRecordCount));//

      fltValor := qryApuracao.FieldByName('VALOR').AsFloat ;

      if (fltValor <> 0) then
      begin
        dados := TDadosImportacaoContabil.Create(VC_StrVersaoContabilidade, VS_strCodEmp);
        dados.strCodigoEmpresa := edtEmpGrv.Text;
        dados.dtaLancamento := fDataFinal;
        dados.strTipoLancamento := 'FEC';
        dados.intCodigoHistoricoPadrao := -1;
        dados.intAutomatico := 1;
        dados.strCodigoOperador := strLoginUsuarioLogado;

        if fltValor < 0 then
        begin
          dados.strContaDebito := qryApuracao.FieldByName('CONTA').AsString;
          dados.strContaCredito := fCfgSis('CONRES');
        end
        else
        begin
          dados.strContaCredito := qryApuracao.FieldByName('CONTA').AsString;
          dados.strContaDebito := fCfgSis('CONRES');
        end;

        dados.fltValorLancamento := Abs(fltValor);
        dados.strHistorico := HISTORICO_APURACAO;
        dados.strCCusto := qryApuracao.FieldByName('CENTRO_CUSTO').AsString ;
        lstDados.Add(dados);
      end;

      qryApuracao.Next;

      if ((qryApuracao.Eof) or (intCount >= intTamanhoLote)) then
      begin
        intCount := 0;
        FGravacaoEmLote.pGravarLanMes(lstDados);
        lstDados.Clear;
      end;
    end;

    pgbProgresso.Position := 0;

    if lstDados.Count > 0 then
      FGravacaoEmLote.pGravarLanMes(lstDados);
  finally
    FreeAndNil(qryApuracao);
    FreeAndNil(lstDados);
  end;
end;

procedure TfrmFechamentoContabilMes.pAtualizarSaldoInicialDoAnoSeguinte(const ADataFinal: TDate;
  const AValorFinal: double; const ACodigoConta: string; const ACentroCusto: string);
var
  qryLanBal : TFDQuery;
  blCfg : Boolean ;
  blColIniCCusto : boolean ;
begin
  if (ADataFinal = 0) then
    Exit;

  if (MonthOf(ADataFinal) <> MonthsPerYear) then
    exit;

  if (copy(ACodigoConta,1,1) <> fCfgSis('DIGATI')) and (copy(ACodigoConta,1,1) <> fCfgSis('DIGPAS')) then
    exit;

  blCfg := fTemCfgFconcc ;
  /////verifica se a coluna INI_CCUSTO existe na PLAINI, por questões de compatibilidade
  blColIniCCusto := fCampoExiste('PLAINI', 'INI_CCUSTO');

  qryLanBal := TFDQuery.Create(Self);
  qryLanBal.Connection := FGravacaoEmLote.getDataBase;
  try
    qryLanBal.Close;
    qryLanBal.SQL.Clear;
    qryLanBal.SQL.Add('SELECT * FROM PLAINI WHERE INI_EXERCI = :EXERCI AND INI_CODEMP = :CODEMP AND INI_CODCON = :CODCON ');
    if (blCfg) and (blColIniCCusto) then
    begin
      if not fEmptyStr(ACentroCusto) then
      begin
        qryLanBal.SQL.Add(' AND INI_CCUSTO = :CCUSTO');
        qryLanBal.ParamByName('CCUSTO').AsString := ACentroCusto;
      end
      else
      begin
        qryLanBal.SQL.Add(' AND TRIM(COALESCE(INI_CCUSTO,'+quotedstr('')+')) = '+quotedstr('')+' ');
      end;
    end;
    qryLanBal.ParamByName('CODEMP').AsString := edtEmpGrv.Text;
    qryLanBal.ParamByName('EXERCI').AsString := YearOf(IncMonth(ADataFinal)).ToString;
    qryLanBal.ParamByName('CODCON').AsString := ACodigoConta;
    qryLanBal.Open;

    if (qryLanBal.IsEmpty) then
    begin
      qryLanBal.Insert;
      qryLanBal.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('PLAINI', VS_strCodEmp);
      qryLanBal.FieldByName('INI_EXERCI').AsString := YearOf(IncMonth(ADataFinal)).ToString;
      qryLanBal.FieldByName('INI_CODEMP').AsString := edtEmpGrv.Text;
      qryLanBal.FieldByName('INI_CODCON').AsString := ACodigoConta;
      if (blCfg) and (blColIniCCusto) then
      begin
        qryLanBal.FieldByName('INI_CCUSTO').AsString := ACentroCusto;
      end;
    end
    else
      qryLanBal.Edit;

    if Assigned(qryLanBal.FindField('INI_CREDEB')) then
    begin
      qryLanBal.FieldByName('INI_CREDEB').AsString := IIF(AValorFinal > 0, 'D', 'C');
      qryLanBal.FieldByName('INI_SALINI').AsFloat := Abs(AValorFinal);
    end
    else
      qryLanBal.FieldByName('INI_SALINI').AsFloat := AValorFinal;

    qryLanBal.Post;
  finally
    FreeAndNil(qryLanBal);
  end;
end;

procedure TfrmFechamentoContabilMes.pAtualizarSaldoInicialDoAnoSeguinteSubContas(
  pgbProgresso: TcxProgressBar);
var
  LqrySubCon, LqryIncluir: TUniQuery ;
  LdtaIni, LdtaFin: TDateTime ;
  LintAno: Integer ;
  LintAnoPosterior: Integer ;
  LintRecordCount: Integer ;
begin
  if fCfgDesmembrarSubContaCliFor = 'N' then
    Exit ;

  if (MonthOf(fDataFinal) <> MonthsPerYear) then
    exit;

  pSetaTextoProgresso(pgbProgresso, 'Saldo Inicial Sub-Contas...');

  LdtaIni := EncodeDate(YearOf(fDataFinal), 1, 1) ;
  LdtaFin := EncodeDate(YearOf(fDataFinal), 12, 31) ;
  LintAno := YearOf(fDataFinal) ;
  LintAnoPosterior := YearOf(fDataFinal)+1 ;

  LqrySubCon := fCriaQuery() ;
  LqryIncluir := fCriaQuery() ;
  try
    LqrySubCon.Close ;
    LqrySubCon.SQL.Clear ;
    LqrySubCon.SQL.Add('DELETE FROM DPRINI WHERE INI_EXERCI = :EXERCI AND INI_CODEMP = :CODEMP');
    LqrySubCon.ParamByName('EXERCI').AsInteger := LintAnoPosterior ;
    LqrySubCon.ParamByName('CODEMP').AsString := edtEmpGrv.Text ;
    LqrySubCon.ExecSQL ;

    LqrySubCon.Close ;
    LqrySubCon.SQL.Clear ;
    LqrySubCon.SQL.Add(' SELECT CON_EMPLAN, CONTA, CON_CLIFOR, CON_TIP_FC, ABS(VALOR) AS VALOR, CASE WHEN VALOR > 0 THEN "D" ELSE "C" END AS CREDEB FROM ( ') ;
    LqrySubCon.SQL.Add('    SELECT CON_EMPLAN, CONTA, CON_CLIFOR, CON_TIP_FC, SUM(VALOR) AS VALOR FROM ( ') ;
    LqrySubCon.SQL.Add('       SELECT CAST("'+edtEmpGrv.Text+'" AS CHAR(3)) AS CON_EMPLAN, CON_CONCRE AS CONTA, CON_CLIFOR, CON_TIP_FC, ') ;
    LqrySubCon.SQL.Add('              COALESCE(-CON_VALLAN, 0.00) AS VALOR ') ;
    LqrySubCon.SQL.Add('       FROM LANCON ') ;
    LqrySubCon.SQL.Add('            LEFT JOIN PLANCO PC ON LANCON.CON_CONCRE = PC.NCO_CODCON ') ;
    LqrySubCon.SQL.Add('       WHERE PC.NCO_SUBCNT = "S" ') ;
    LqrySubCon.SQL.Add('             AND LANCON.CON_DTALAN BETWEEN :DTAINI AND :DTAFIN ') ;
    LqrySubCon.SQL.Add('             AND LANCON.CON_EMPLAN IN ( ' + fGetInEmpresas + ' ) ') ;
    LqrySubCon.SQL.Add('       UNION ALL ') ;
    LqrySubCon.SQL.Add('       SELECT CAST("'+edtEmpGrv.Text+'" AS CHAR(3)) AS CON_EMPLAN, CON_CONDEB AS CONTA, CON_CLIFOR, CON_TIP_FC, ') ;
    LqrySubCon.SQL.Add('              COALESCE(CON_VALLAN, 0.00) AS VALOR ') ;
    LqrySubCon.SQL.Add('       FROM LANCON ') ;
    LqrySubCon.SQL.Add('            LEFT JOIN PLANCO PD ON LANCON.CON_CONDEB = PD.NCO_CODCON ') ;
    LqrySubCon.SQL.Add('       WHERE PD.NCO_SUBCNT = "S" ') ;
    LqrySubCon.SQL.Add('             AND LANCON.CON_DTALAN BETWEEN :DTAINI AND :DTAFIN ') ;
    LqrySubCon.SQL.Add('             AND LANCON.CON_EMPLAN IN ( ' + fGetInEmpresas + ' ) ') ;
    LqrySubCon.SQL.Add('       UNION ALL ') ;
    LqrySubCon.SQL.Add('       SELECT INI_CODEMP AS CON_EMPLAN, INI_CODCON AS CONTA, INI_CLIFOR AS CON_CLIFOR, INI_TIP_FC AS CON_TIP_FC, ') ;
    LqrySubCon.SQL.Add('              COALESCE(CASE WHEN INI_CREDEB = "C" THEN -INI_SALINI ELSE INI_SALINI END, 0.00) AS VALOR ') ;
    LqrySubCon.SQL.Add('       FROM DPRINI ') ;
    LqrySubCon.SQL.Add('       WHERE DPRINI.INI_EXERCI = :ANO ') ;
    LqrySubCon.SQL.Add('             AND DPRINI.INI_CODEMP IN ( ' + edtEmpGrv.Text + ' ) ') ;
    LqrySubCon.SQL.Add('    ) AS SEL ') ;
    LqrySubCon.SQL.Add('    GROUP BY CON_EMPLAN, CONTA, CON_CLIFOR, CON_TIP_FC ') ;
    LqrySubCon.SQL.Add(' ) AS SEL ') ;
    LqrySubCon.ParamByName('DTAINI').AsDate := LdtaIni ;
    LqrySubCon.ParamByName('DTAFIN').AsDate := LdtaFin ;
    LqrySubCon.ParamByName('ANO').AsInteger := LintAno ;
    LqrySubCon.Open ;

    LqryIncluir.Close ;
    LqryIncluir.SQL.Clear ;
    LqryIncluir.SQL.Add('SELECT * FROM DPRINI WHERE FALSE ');
    LqryIncluir.Open ;

    LintRecordCount := LqrySubCon.RecordCount;
    pgbProgresso.Properties.Max := LintRecordCount;

    LqrySubCon.First ;
    while not LqrySubCon.Eof do
    begin

      pgbProgresso.Position := LqrySubCon.RecNo;
      Application.ProcessMessages ;

      LqryIncluir.Append ;
      LqryIncluir.FieldByName('INI_CODCON').AsString := LqrySubCon.FieldByName('CONTA').AsString ;
      LqryIncluir.FieldByName('INI_EXERCI').AsString := IntToStr(LintAnoPosterior) ;
      LqryIncluir.FieldByName('INI_SALINI').AsFloat := LqrySubCon.FieldByName('VALOR').AsFloat ;
      LqryIncluir.FieldByName('INI_CODEMP').AsString := LqrySubCon.FieldByName('CON_EMPLAN').AsString ;
      LqryIncluir.FieldByName('INI_CREDEB').AsString := LqrySubCon.FieldByName('CREDEB').AsString ;
      LqryIncluir.FieldByName('INI_CLIFOR').AsString := LqrySubCon.FieldByName('CON_CLIFOR').AsString ;
      LqryIncluir.FieldByName('INI_TIP_FC').AsString := LqrySubCon.FieldByName('CON_TIP_FC').AsString ;
      LqryIncluir.Post ;

      LqrySubCon.Next ;
    end ;

  finally
    FreeAndNil(LqrySubCon);
    FreeAndNil(LqryIncluir);
  end ;

  pgbProgresso.Position := 0;
end;

procedure TfrmFechamentoContabilMes.pDeletaBalancete;
  var
    qryLanBal : TFDQuery;
begin
  qryLanBal := TFDQuery.Create(Self);
  qryLanBal.Connection := FGravacaoEmLote.getDataBase;
  try
    qryLanBal.Close;
    qryLanBal.SQL.Clear;
    qryLanBal.SQL.Add('DELETE FROM LANBAL WHERE BAL_CODEMP IN (' + fGetInEmpresas + ') AND BAL_DTAMOV = :DTAMOV');
    qryLanBal.ParamByName('DTAMOV').AsDate := fDataFinal;
    qryLanBal.ExecSQL;
  finally
    FreeAndNil(qryLanBal);
  end;
end;

procedure TfrmFechamentoContabilMes.pDeletaFecMes;
  var
    LqryFecMes : TFDQuery;
begin
  LqryFecMes := TFDQuery.Create(Self);
  try
    LqryFecMes.Connection := FGravacaoEmLote.getDataBase;
    LqryFecMes.Close;
    LqryFecMes.SQL.Clear;
    LqryFecMes.SQL.Add('DELETE FROM FECMES WHERE MES_CODEMP IN (' + fGetInEmpresas + ') AND MES_MESDTA = :MESDTA');
    LqryFecMes.ParamByName('MESDTA').AsDate := fDataFinal;
    LqryFecMes.ExecSQL;
  finally
    FreeAndNil(LqryFecMes);
  end;
end;

procedure TfrmFechamentoContabilMes.pDeletaLanMes;
  var
    qryLanMes : TFDQuery;
begin
  qryLanMes := TFDQuery.Create(Self);
  qryLanMes.Connection := FGravacaoEmLote.getDataBase;
  try
    qryLanMes.Close;
    qryLanMes.SQL.Clear;
    qryLanMes.SQL.Add('DELETE FROM LANMES WHERE CON_DTALAN >= :DTAINI AND CON_EMPLAN  IN (' + fGetInEmpresas + ') ');
    qryLanMes.ParamByName('DTAINI').AsDate := fDataInicial;
    qryLanMes.ExecSQL;
  finally
    FreeAndNil(qryLanMes);
  end;
end;

procedure TfrmFechamentoContabilMes.pDeletaPlaIniProximoExercicio(const ADataFinal:TDate);
var
  qryLanBal : TFDQuery;
begin
  if (ADataFinal = 0) then
    Exit;

  if (MonthOf(ADataFinal) <> MonthsPerYear) then
    exit;

  qryLanBal := TFDQuery.Create(Self);
  qryLanBal.Connection := FGravacaoEmLote.getDataBase;
  try
    qryLanBal.Close;
    qryLanBal.SQL.Clear;
    qryLanBal.SQL.Add('DELETE FROM PLAINI WHERE INI_EXERCI = :EXERCI AND INI_CODEMP  IN (' + fGetInEmpresas + ') ');
    qryLanBal.ParamByName('EXERCI').AsInteger := YearOf(ADataFinal)+1;
    qryLanBal.ExecSQL;
  finally
    FreeAndNil(qryLanBal);
  end;
end;

procedure TfrmFechamentoContabilMes.pDeletaPlaMes;
  var
    qryPlaMes : TFDQuery;
begin
  qryPlaMes := TFDQuery.Create(Self);
  qryPlaMes.Connection := FGravacaoEmLote.getDataBase;
  try
    qryPlaMes.Close;
    qryPlaMes.SQL.Clear;
    qryPlaMes.SQL.Add('DELETE FROM PLAMES WHERE MES_DTASAL > :DTAINI AND MES_CODEMP  IN (' + fGetInEmpresas + ') ');
    qryPlaMes.ParamByName('DTAINI').AsDate := fDataInicial;
    qryPlaMes.ExecSQL;
  finally
    FreeAndNil(qryPlaMes);
  end;
end;

procedure TfrmFechamentoContabilMes.pLucroPrejuizo(pgbProgresso: TcxProgressBar);
var
  qryLucroPrejuizo : TFDQuery;

  blCfg : boolean ;
  strCampoCCustoLanMes : string ;
  fltValor : Double ;

  LdfcpDado : TDadosFechamentoContabilPlaMes;
  LlstDados : TObjectList<TDadosFechamentoContabilPlaMes>;
  LintCount : Integer ;
begin
  pSetaTextoProgresso(pgbProgresso, 'Apurando: Lucro/Prejuizo');

  blCfg := fTemCfgFconcc ;
  strCampoCCustoLanMes := fCampoCCustoLanMes(blCfg) ;

  qryLucroPrejuizo := TFDQuery.Create(Self);
  LlstDados := TObjectList<TDadosFechamentoContabilPlaMes>.Create;
  try
    qryLucroPrejuizo.Connection := FGravacaoEmLote.getDataBase;

    qryLucroPrejuizo.Close;
    qryLucroPrejuizo.SQL.Clear;
    qryLucroPrejuizo.SQL.Add(' SELECT CAST(SUM(IF(IFNULL(CON_CONDEB,"") = :CODCON, CON_VALLAN, 0.00)) - ');
    qryLucroPrejuizo.SQL.Add('        SUM(IF(IFNULL(CON_CONCRE,"") = :CODCON, CON_VALLAN, 0.00)) AS DECIMAL(12,2)) AS VALOR, ');
    qryLucroPrejuizo.SQL.Add('        CON_CONDEB, '+strCampoCCustoLanMes+' AS CON_CCUSTO ');
    qryLucroPrejuizo.SQL.Add('   FROM LANMES ');
    qryLucroPrejuizo.SQL.Add('  WHERE CON_DTALAN = :DTALAN ');
    qryLucroPrejuizo.SQL.Add('    AND CON_TIPLAN = "FEC" ');
    qryLucroPrejuizo.SQL.Add('    AND CON_EMPLAN = :CODEMP ');
    qryLucroPrejuizo.SQL.Add('    AND (IFNULL(CON_CONCRE,"") = :CODCON) ');
    qryLucroPrejuizo.SQL.Add('    GROUP BY CON_CONDEB, ' + strCampoCCustoLanMes);
    qryLucroPrejuizo.ParamByName('DTALAN').AsDate := fDataFinal;
    qryLucroPrejuizo.ParamByName('CODCON').AsString := fCfgSis('CONRES');
    qryLucroPrejuizo.ParamByName('CODEMP').AsString := edtEmpGrv.Text;
    qryLucroPrejuizo.Open;

    LintCount := 0 ;
    qryLucroPrejuizo.First;
    while not qryLucroPrejuizo.Eof do
    begin
      fltValor := qryLucroPrejuizo.FieldByName('VALOR').AsFloat ;
      if fltValor <> 0.00 then
      begin
        LintCount := LintCount + 1 ;

        LdfcpDado := TDadosFechamentoContabilPlaMes.Create ;
        LdfcpDado.CodCon := qryLucroPrejuizo.FieldByName('CON_CONDEB').AsString ;
        LdfcpDado.SalIni := abs(fltValor) ;
        LdfcpDado.CodEmp := edtEmpGrv.Text ;
        LdfcpDado.DtaSal := IncDay(fDataFinal) ;
        LdfcpDado.CreDeb := fCreDebPeloValor(fltValor) ;
        LdfcpDado.CCusto := qryLucroPrejuizo.FieldByName('CON_CCUSTO').AsString ;

        LlstDados.Add(LdfcpDado);

        if LintCount >= intTamanhoLote then
        begin
          LintCount := 0;
          FGravacaoEmLote.pGravarPlaMes(LlstDados);
          LlstDados.Clear;
        end;

      end;
      qryLucroPrejuizo.Next;
    end;

    if LlstDados.Count > 0 then
    begin
      FGravacaoEmLote.pGravarPlaMes(LlstDados);
      LlstDados.Clear;
    end ;

    qryLucroPrejuizo.Close;
    qryLucroPrejuizo.SQL.Clear;
    qryLucroPrejuizo.SQL.Add(' SELECT CAST(SUM(IF(IFNULL(CON_CONDEB,"") = :CODCON, CON_VALLAN, 0.00)) - ');
    qryLucroPrejuizo.SQL.Add('        SUM(IF(IFNULL(CON_CONCRE,"") = :CODCON, CON_VALLAN, 0.00)) AS DECIMAL(12,2)) AS VALOR, ');
    qryLucroPrejuizo.SQL.Add('        CON_CONCRE, '+strCampoCCustoLanMes+' AS CON_CCUSTO ');
    qryLucroPrejuizo.SQL.Add('   FROM LANMES ');
    qryLucroPrejuizo.SQL.Add('  WHERE CON_DTALAN = :DTALAN ');
    qryLucroPrejuizo.SQL.Add('    AND CON_TIPLAN = "FEC" ');
    qryLucroPrejuizo.SQL.Add('    AND CON_EMPLAN = :CODEMP ');
    qryLucroPrejuizo.SQL.Add('    AND (IFNULL(CON_CONDEB,"") = :CODCON) ');
    qryLucroPrejuizo.SQL.Add('    GROUP BY CON_CONCRE, ' + strCampoCCustoLanMes);
    qryLucroPrejuizo.ParamByName('DTALAN').AsDate := fDataFinal;
    qryLucroPrejuizo.ParamByName('CODCON').AsString := fCfgSis('CONRES');
    qryLucroPrejuizo.ParamByName('CODEMP').AsString := edtEmpGrv.Text;
    qryLucroPrejuizo.Open;

    LintCount := 0 ;
    qryLucroPrejuizo.First;
    while not qryLucroPrejuizo.Eof do
    begin
      fltValor := qryLucroPrejuizo.FieldByName('VALOR').AsFloat ;
      if fltValor <> 0.00 then
      begin
        LintCount := LintCount + 1 ;

        LdfcpDado := TDadosFechamentoContabilPlaMes.Create ;
        LdfcpDado.CodCon := qryLucroPrejuizo.FieldByName('CON_CONCRE').AsString ;
        LdfcpDado.SalIni := abs(fltValor) ;
        LdfcpDado.CodEmp := edtEmpGrv.Text ;
        LdfcpDado.DtaSal := IncDay(fDataFinal) ;
        LdfcpDado.CreDeb := fCreDebPeloValor(fltValor) ;
        LdfcpDado.CCusto := qryLucroPrejuizo.FieldByName('CON_CCUSTO').AsString ;

        LlstDados.Add(LdfcpDado);

        if LintCount >= intTamanhoLote then
        begin
          LintCount := 0;
          FGravacaoEmLote.pGravarPlaMes(LlstDados);
          LlstDados.Clear;
        end;

      end;
      qryLucroPrejuizo.Next;
    end;

    if LlstDados.Count > 0 then
    begin
      FGravacaoEmLote.pGravarPlaMes(LlstDados);
      LlstDados.Clear;
    end ;

  finally
    FreeAndNil(qryLucroPrejuizo);
    FreeAndNil(LlstDados);
  end;
end;

procedure TfrmFechamentoContabilMes.pSetaTextoProgresso(pgbProgresso: TcxProgressBar; strTexto: String);
begin
  If Assigned(pgbProgresso) And (GetParentForm(pgbProgresso).FindComponent('lblGravando') <> Nil) Then
  Begin
    TLabel(GetParentForm(pgbProgresso).FindComponent('lblGravando')).Caption := strTexto;
    Application.ProcessMessages;
  End;
end;

procedure TfrmFechamentoContabilMes.pGravaBalancete(pgbProgresso: TcxProgressBar);

  function fFiltroPatrimonialEResultadoComSaldo: string;
  var
    intTamanhoDigCus: integer ;
    intTamanhoDigDes: integer ;
    intTamanhoDigRec: integer ;
  begin
    intTamanhoDigCus := fLenDig(fSemMascaraPlaNco(fCfgDigcus)) ;
    intTamanhoDigDes := fLenDig(fSemMascaraPlaNco(fCfgDigdes)) ;
    intTamanhoDigRec := fLenDig(fSemMascaraPlaNco(fCfgDigrec)) ;
    Result := '';
    Result := Result + ' (   (NCO_PATRIM = "S") OR (LEFT(NCO_CODCON,' + intToStr(intTamanhoDigRec) + ') = :DIGREC) ';
    Result := Result + ' OR  (LEFT(NCO_CODCON,' + intToStr(intTamanhoDigDes) + ') = :DIGDES) OR (IFNULL(NCO_APURAC,0) = 1) ';
    Result := Result + ' OR  (LEFT(NCO_CODCON,1) = :DIGATI) OR (LEFT(NCO_CODCON,1) = :DIGPAS) ';

    if not fEmptyStr(fCfgSis('CONRES')) then
      Result := Result + ' OR (NCO_CODCON = ' + QuotedStr(fCfgSis('CONRES')) + ') ';

    if not fEmptyStr(fCfgDigcus) then
      Result := Result + ' OR (LEFT(NCO_CODCON,' + intToStr(intTamanhoDigCus) + ') = ' + QuotedStr(fCfgDigcus) + ') ';

    Result := Result + ' )';
  end;

  var
    qryApuracao : TFDQuery;
    intCount : integer;
    intRecordCount : Integer;

    blCfg : boolean ;
    strCampoCCustoPlaIni : string ;
    strCampoCCustoLanBal : string ;
    strCampoCCustoPlaMes : string ;
    strCampoCCustoLanMes : string ;
    strCampoCCustoLanConDeb : string ;
    strCampoCCustoLanConCred : string ;
    fltSaldoFinal : double ;
    fltSaldoInicial : double ;
    LdfclDado : TDadosFechamentoContabilLanBal;
    LlstDados : TObjectList<TDadosFechamentoContabilLanBal>;
    LintCntItens : Integer ;
begin
  pSetaTextoProgresso(pgbProgresso, 'Balancete...');

  blCfg := fTemCfgFconcc ;
  strCampoCCustoPlaIni := fCampoCCustoPlaIni(blCfg) ;
  strCampoCCustoLanBal := fCampoCCustoLanBal(blCfg) ;
  strCampoCCustoPlaMes := fCampoCCustoPlaMes(blCfg) ;
  strCampoCCustoLanMes := fCampoCCustoLanMes(blCfg) ;
  strCampoCCustoLanConDeb := fCampoCCustoLanConDeb(blCfg) ;
  strCampoCCustoLanConCred := fCampoCCustoLanConCred(blCfg) ;

  qryApuracao := TFDQuery.Create(Self);
  LlstDados := TObjectList<TDadosFechamentoContabilLanBal>.Create;
  try
    qryApuracao.Connection := FGravacaoEmLote.getDataBase;
    qryApuracao.FetchOptions.Mode := fmAll ;
    qryApuracao.Close;
    qryApuracao.SQL.Clear;
    qryApuracao.SQL.Add(' SELECT CONTA, CCUSTO, SUM(SALDO_INICIAL) AS SALDO_INICIAL, SUM(DEBITO) AS DEBITO, SUM(CREDITO) AS CREDITO  ');
    qryApuracao.SQL.Add('   FROM ( ');

    if (LeftStr(mskPeriodo.Text, 2) = '01') then
    begin
      // Saldo Inicial (Ano)
      qryApuracao.SQL.Add('          SELECT INI_CODCON AS CONTA, ' + strCampoCCustoPlaIni + ' AS CCUSTO, ' + fCampoSaldoInicialPlaIni + ' AS SALDO_INICIAL, 0.00 AS DEBITO, 0.00 AS CREDITO ');
      qryApuracao.SQL.Add('            FROM PLAINI ');
      qryApuracao.SQL.Add('       INNER JOIN CADEMP ON INI_CODEMP = EMP_CODEMP ');
      qryApuracao.SQL.Add('       LEFT JOIN PLANCO ON NCO_CODCON = INI_CODCON AND NCO_TPLACO = EMP_TPLACO AND :DTAINI < COALESCE(PLANCO.NCO_DTAFIN,"9999-01-01") AND :DTAFIN > COALESCE(PLANCO.NCO_DTAINI,"2000-01-01") ');
      qryApuracao.SQL.Add('           WHERE INI_CODEMP IN (' + fGetInEmpresas + ') AND INI_EXERCI = :EXERCI ');
      qryApuracao.SQL.Add('             AND ' + fFiltroPatrimonialEResultadoComSaldo);
    end
    else
    begin
      // Saldo Inicial (Mês Anterior)
      qryApuracao.SQL.Add('          SELECT BAL_CODCON AS CONTA, ' + strCampoCCustoLanBal + ' AS CCUSTO, ' + fCampoSaldoFinalLanBal + ' AS SALDO_INICIAL, 0.00 AS DEBITO, 0.00 AS CREDITO ');
      qryApuracao.SQL.Add('            FROM LANBAL ');
      qryApuracao.SQL.Add('       INNER JOIN CADEMP ON BAL_CODEMP = EMP_CODEMP ');
      qryApuracao.SQL.Add('       LEFT JOIN PLANCO ON NCO_CODCON = BAL_CODCON AND NCO_TPLACO = EMP_TPLACO AND :DTAINI < COALESCE(PLANCO.NCO_DTAFIN,"9999-01-01") AND :DTAFIN > COALESCE(PLANCO.NCO_DTAINI,"2000-01-01") ');
      qryApuracao.SQL.Add('           WHERE BAL_CODEMP IN (' + fGetInEmpresas + ') AND BAL_DTAMOV = :DTAANT ');
      qryApuracao.SQL.Add('             AND ' + fFiltroPatrimonialEResultadoComSaldo);
    end;

    qryApuracao.SQL.Add('           UNION ALL ');

    // Apuração do período (Crédito)
    qryApuracao.SQL.Add('          SELECT CON_CONCRE AS CONTA, ' + strCampoCCustoLanConCred + ' AS CCUSTO, 0.00 AS SALDO_INICIAL, 0.00 AS DEBITO, -SUM(ABS(CON_VALLAN)) AS CREDITO ');
    qryApuracao.SQL.Add('            FROM LANCON ');
    qryApuracao.SQL.Add('       INNER JOIN CADEMP ON CON_EMPLAN = EMP_CODEMP ');
    qryApuracao.SQL.Add('       LEFT JOIN PLANCO ON NCO_CODCON = CON_CONCRE AND NCO_TPLACO = EMP_TPLACO AND :DTAINI < COALESCE(PLANCO.NCO_DTAFIN,"9999-01-01") AND :DTAFIN > COALESCE(PLANCO.NCO_DTAINI,"2000-01-01") ');
    qryApuracao.SQL.Add('           WHERE CON_EMPLAN IN (' + fGetInEmpresas + ') AND CON_DTALAN BETWEEN :DTAINI AND :DTAFIN ');
    qryApuracao.SQL.Add('             AND ' + fFiltroPatrimonialEResultadoComSaldo);
    qryApuracao.SQL.Add('           GROUP BY CON_CONCRE, ' + strCampoCCustoLanConCred );

    qryApuracao.SQL.Add('           UNION ALL ');

    // Apuração do período (Débito)
    qryApuracao.SQL.Add('          SELECT CON_CONDEB, ' + strCampoCCustoLanConDeb + ' AS CCUSTO, 0.00 AS SALDO_INICIAL, SUM(ABS(CON_VALLAN)) DEBITO, 0.00 AS CREDITO ');
    qryApuracao.SQL.Add('            FROM LANCON ');
    qryApuracao.SQL.Add('       INNER JOIN CADEMP ON CON_EMPLAN = EMP_CODEMP ');
    qryApuracao.SQL.Add('       LEFT JOIN PLANCO ON NCO_CODCON = CON_CONDEB AND NCO_TPLACO = EMP_TPLACO AND :DTAINI < COALESCE(PLANCO.NCO_DTAFIN,"9999-01-01") AND :DTAFIN > COALESCE(PLANCO.NCO_DTAINI,"2000-01-01") ');
    qryApuracao.SQL.Add('           WHERE CON_EMPLAN IN (' + fGetInEmpresas + ') AND CON_DTALAN BETWEEN :DTAINI AND :DTAFIN ');
    qryApuracao.SQL.Add('             AND ' + fFiltroPatrimonialEResultadoComSaldo);
    qryApuracao.SQL.Add('           GROUP BY CON_CONDEB, ' + strCampoCCustoLanConDeb);

    qryApuracao.SQL.Add('          ) AS TMP_APURACA ');
    qryApuracao.SQL.Add('      GROUP BY CONTA, CCUSTO ');

    if (Assigned(qryApuracao.FindParam('EXERCI'))) then
      qryApuracao.ParamByName('EXERCI').AsInteger := fExercicio;

    qryApuracao.ParamByName('DTAINI').AsDate := fDataInicial;
    qryApuracao.ParamByName('DTAFIN').AsDate := fDataFinal;
    qryApuracao.ParamByName('DIGREC').AsString := fCfgDigrec;
    qryApuracao.ParamByName('DIGDES').AsString := fCfgDigdes;
    qryApuracao.ParamByName('DIGATI').AsString := fCfgSis('DIGATI');
    qryApuracao.ParamByName('DIGPAS').AsString := fCfgSis('DIGPAS');

    if (Assigned(qryApuracao.FindParam('DTAANT'))) then
      qryApuracao.ParamByName('DTAANT').AsDate := fDataFinalAnterior;

    qryApuracao.Open;

    intCount := 0;
    intRecordCount := qryApuracao.RecordCount;
    pgbProgresso.Properties.Max := intRecordCount;
    LintCntItens := 0;
    qryApuracao.First;
    while not qryApuracao.Eof do
    begin
      intCount := intCount + 1;
      LintCntItens := LintCntItens + 1 ;

      pgbProgresso.Position := qryApuracao.RecNo;
      pSetaTextoProgresso(pgbProgresso, 'Balancete: ' + IntToStr(intCount) + '/' + IntToStr(intRecordCount));
      fltSaldoFinal := qryApuracao.FieldByName('SALDO_INICIAL').AsFloat + abs(qryApuracao.FieldByName('DEBITO').AsFloat) - abs(qryApuracao.FieldByName('CREDITO').AsFloat) ;
      fltSaldoInicial := qryApuracao.FieldByName('SALDO_INICIAL').AsFloat ;

      LdfclDado := TDadosFechamentoContabilLanBal.Create;
      LdfclDado.CodEmp := edtEmpGrv.Text;
      LdfclDado.CCusto := qryApuracao.FieldByName('CCUSTO').AsString;
      LdfclDado.DtaMov := fDataFinal;
      LdfclDado.CodCon := qryApuracao.FieldByName('CONTA').AsString;
      LdfclDado.SalAnt := abs(fltSaldoInicial);
      LdfclDado.CrDeAn := fCreDebPeloValor(fltSaldoInicial);
      LdfclDado.Debito := abs(qryApuracao.FieldByName('DEBITO').AsFloat);
      LdfclDado.Credit := abs(qryApuracao.FieldByName('CREDITO').AsFloat);
      LdfclDado.SalFin := abs(fltSaldoFinal);
      LdfclDado.CrDeFi := fCreDebPeloValor(fltSaldoFinal);

      LlstDados.Add(LdfclDado);

      if LintCntItens >= intTamanhoLote then
      begin
        LintCntItens := 0;
        FGravacaoEmLote.pGravarLanBal(LlstDados);
        LlstDados.Clear;
      end;

      pAtualizarSaldoInicialDoAnoSeguinte(fDataFinal, fltSaldoFinal, qryApuracao.FieldByName('CONTA').AsString, qryApuracao.FieldByName('CCUSTO').AsString);

      qryApuracao.Next;
    end;

    if LlstDados.Count > 0 then
    begin
      FGravacaoEmLote.pGravarLanBal(LlstDados);
      LlstDados.Clear;
    end ;

    pgbProgresso.Position := 0;
  finally
    FreeAndNil(qryApuracao);
    FreeAndNil(LlstDados);
  end;
end;

procedure TfrmFechamentoContabilMes.pGravaFecMes;
  var
    LstrEmpresas : string;
    LlstEmpresas : TStringList;
    LintCnt: Integer;
    LdfcfDado : TDadosFechamentoContabilFecMes;
    LlstDados : TObjectList<TDadosFechamentoContabilFecMes>;
    LintCntItens : Integer ;
begin
  LlstEmpresas := TStringList.Create ;
  LlstDados := TObjectList<TDadosFechamentoContabilFecMes>.Create;
  try
    LstrEmpresas := fGetInEmpresas ;
    LlstEmpresas.StrictDelimiter := True;
    LlstEmpresas.Delimiter := ',' ;
    LlstEmpresas.DelimitedText := StringReplace(LstrEmpresas, ' ', '', [rfReplaceAll]) ;
    LintCntItens := 0 ;
    for LintCnt := 0 to LlstEmpresas.Count-1  do
    begin
      LintCntItens := LintCntItens + 1 ;

      LdfcfDado := TDadosFechamentoContabilFecMes.Create ;
      LdfcfDado.CodOpe := strLoginUsuarioLogado ;
      LdfcfDado.DtaFec := VS_Date ;
      LdfcfDado.MesDta := fDataFinal ;
      LdfcfDado.CodEmp := StringReplace(LlstEmpresas.Strings[LintCnt], '''', '', [rfReplaceAll]) ;
      LdfcfDado.EmpGrv :=  edtEmpGrv.Text ;

      LlstDados.Add(LdfcfDado);

      if LintCntItens >= intTamanhoLote then
      begin
        LintCntItens := 0;
        FGravacaoEmLote.pGravarFecMes(LlstDados);
        LlstDados.Clear;
      end;
    end ;

    if LlstDados.Count > 0 then
    begin
      FGravacaoEmLote.pGravarFecMes(LlstDados);
      LlstDados.Clear;
    end ;

  finally
    FreeAndNil(LlstEmpresas);
    FreeAndNil(LlstDados);
  end;
end;

function TfrmFechamentoContabilMes.fGetInEmpresas: string;
  var
    intIndex : Integer;
begin
  if Length(arrEmpSel) > 0 Then
  begin
    For intIndex := Low(arrEmpSel) To High(arrEmpSel) Do
    Begin
      if not arrEmpSel[intIndex].strCodigo.IsEmpty then
      begin
        If Result.IsEmpty then
          Result := QuotedStr(arrEmpSel[intIndex].strCodigo)
        else
          Result := Result + ', ' + QuotedStr(arrEmpSel[intIndex].strCodigo);
      end;
    end;
  end;

  if Result.IsEmpty then
    raise Exception.Create('Empresa de seleção não foi informada corretamente!');
end;

function TfrmFechamentoContabilMes.fValidaCnpjEmpresasEnvolvidas: boolean;
  var
    intIndex : Integer;
    strCnpjBase : string;
begin
  Result := False;

  strCnpjBase := LeftStr(fCampoTabela('EMP_C_G_C_', 'CADEMP', ['EMP_CODEMP'], [edtEmpGrv.Text], False), 8);

  if Length(arrEmpSel) > 0 Then
  begin
    For intIndex := Low(arrEmpSel) To High(arrEmpSel) Do
    Begin
      if not arrEmpSel[intIndex].strCodigo.IsEmpty then
      begin
        Result := (strCnpjBase = LeftStr(fCampoTabela('EMP_C_G_C_', 'CADEMP', ['EMP_CODEMP'], [arrEmpSel[intIndex].strCodigo], False), 8));
        if not Result then
          Exit;
      end;
    end;
  end;

end;

end.
