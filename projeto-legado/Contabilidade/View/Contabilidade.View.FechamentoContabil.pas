unit Contabilidade.View.FechamentoContabil;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, System.Generics.Collections, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Contabilidade.View.TfrmPaiContabilidade, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, EditFocus, Vcl.Mask, MaskEditFocus, Uni, cxProgressBar,
  Contabilidade.Classes.TGravacaoEmLote, FireDAC.Comp.Client, FireDAC.Stan.Param,
  Data.DB, untTypesSistema, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, cxGroupBox, cxCheckGroup,
  Contabilidade.Funcoes, Contabilidade.Interfaces,
  Contabilidade.Model.TDadosImportacaoContabil, Contabilidade.Classes.Utils ;

type
  TfrmFechamentoContabil = class(TfrmPaiContabilidade)
    Panel1: TPanel;
    lbPeriodoExercicio: TLabel;
    btnGerar: TBitBtnLocked;
    Label1: TLabel;
    edtEmpGrv: TEditFocus;
    edtNomEmpGrv: TEditFocus;
    rdgFormaFechamento: TRadioGroup;
    mskExercicio: TMaskEditFocus;
    chkGrpPeriodoFechamento: TcxCheckGroup;
    btnCheckList: TBitBtnLocked;
    procedure btnGerarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure edtEmpGrvKeyPress(Sender: TObject; var Key: Char);
    procedure rdgFormaFechamentoClick(Sender: TObject);
    procedure btnCheckListClick(Sender: TObject);
  private
    { Private declarations }
    intTamanhoLote : integer;
    FGravacaoEmLote : TGravacaoEmLote;
    qryConDetails : TUniQuery;
    arrEmpSel: TConsultasArray;
    dtaDtaIni : TDate;
    dtaDtaFin : TDate;
    strUltimoErro : string;
    array_of_TRecFecCon : TDynamicArrayFecCon ;
    FblnTabelaEPREGTexiste: Boolean ;
    FblnTabelaPLADETExiste: Boolean ;
    FblnTabelaLANDETExiste: Boolean ;
    FblnTabelaDPRDETExiste: Boolean ;
    FCON_ANOLANExiste: Boolean ;
    procedure pDefinirLucroOuPrejuizo;
    function fGetTotalConta(const AContaLucro, AContaPrejuizo, AContaResultado: String): Double;
    const HISTORICO_APURACAO : String = 'APURAÇÃO DO RESULTADO DO EXERCÍCIO';
    procedure pApuracao(strDigito: string; pgbProgresso: TcxProgressBar; strTexto: string; blnApuracaoAposLucroOperacional: boolean = false);
    procedure pLucroPrejuizo(pgbProgresso: TcxProgressBar);
    function fExercicio: integer;
    function fGerar(pgbProgresso: TcxProgressBar): Boolean;
    procedure pSetaTextoProgresso(pgbProgresso: TcxProgressBar; strTexto: String);
    procedure pGravarFecCon;
    function fValidaCnpjEmpresasEnvolvidas: boolean;
    procedure pTravarDigitacaoTela(const ATravar : boolean);
    procedure pCarregaArrayFecCon(Const ATipoFechamento: TTipoFechamentoContabil) ;
    procedure pCriaPeriodoCustomizadoFechamento(Const ATipoFechamento: TTipoFechamentoContabil) ;
    function fValidaPeriodoCustomizadoFechamento(var AMensagem: string; dtaDtaIni, dtaDtaFin: TDate; strCodEmp: string; ATipoFechamento: TTipoFechamentoContabil): boolean ;
    function fDiferencaDiasPeriodo(const AAno: integer; const ATipoFechamento: TTipoFechamentoContabil; const AComparacao: TTipoComparacao):integer ;
    function fTrataMensagemCustomizadoFechamento(const ATipoFechamento: TTipoFechamentoContabil; i: Integer): string;
    function fVerificaFechamentoOutrasEmpresasFec(const AExercicio:integer): boolean ;
    function fVerificaLancamentosAbertosLote(const AExercicio: integer):boolean ;
    function fVerificaFechamentoAnteriorPosterior(AqryTodosExercicios: TUniQuery; AintIndex: Integer; var AstrMensagem: String): Boolean ;
    procedure pConfiguraFormaFechamento(const AstrCodEmp: String;
                                        const AintExercicio: Integer;
                                        const AblnBuscaPorChave: Boolean) ;
    procedure pLimpaOpcoesFormaFechamento ;
    function fValidaOpcaoSelecionadaFormaFechamento: Boolean ;
    function fCampoCCustoLanBal(blCfg:boolean):string ;
    function fCampoCCustoPlaMes(blCfg:boolean):string ;
    function fCampoCCustoLanMes(blCfg:boolean):string ;
    function fDataFinalAnterior(const AdtaIni: TDateTime): TDate;
    procedure pAtualizarSaldoInicialDoAnoSeguinte(const ADataFinal: TDate; const AValorFinal: double; const ACodigoConta: string; const ACentroCusto: string; AdictDet: TDictLanDet);
    procedure pApuracaoMensal(strDigito: string; pgbProgresso: TcxProgressBar; strTexto: string; const AdtaIni, AdtaFin: TDateTime; blnApuracaoAposLucroOperacional: boolean = false);
    procedure pLucroPrejuizoMensal(pgbProgresso: TcxProgressBar; const AdtaIni, AdtaFin: TDateTime);
    procedure pDeletaBalanceteMensal(const AdtaFin: TDateTime);
    procedure pDeletaFecMes(const AdtaFin: TDateTime);
    procedure pDeletaPlaIniProximoExercicio(const ADataFinal:TDate);
    procedure pGravaBalanceteMensal(pgbProgresso: TcxProgressBar; const AdtaIni, AdtaFin: TDateTime);
    procedure pAtualizarSaldoInicialDoAnoSeguinteSubContas(pgbProgresso: TcxProgressBar; const AdtaFin: TDateTime);
    procedure pGravaFecMes(const AdtaFin: TDateTime);
    procedure pDeletaLanMes(const AdtaIni: TDateTime);
    procedure pDeletaPlaMes(const AdtaIni: TDateTime);
    function fPeriodoSelecionado: Boolean ;
    function fBloqueiaPorPendenciaContabil: Boolean;
    function fJoinPlaDet: string;
    function fJoinLanDet: string;
    function fJoinDprDet: string;
    function fStrChaveDprIni(const AConta, ATipFC, AForCli: string): string;
    function fTrataFiltroCampoDataLancon: String ;
  public
    { Public declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

var
  frmFechamentoContabil: TfrmFechamentoContabil;

implementation

uses
  untFuncoesSimples, untConsultas, untFuncoesConsulta, DateUtils,
  StrUtils, Contabilidade.View.CheckListImportacao, FireDAC.Stan.Option,
  Contabilidade.OutrosFechamentos.Funcoes,
  Contabilidade.Classes.FechamentoDiaMes,
  Contabilidade.Classes.TListaValidacoesContabeis, Contabilidade.View.ErrosContabeis,
  UniClientDataSet ;

{$R *.dfm}

function TfrmFechamentoContabil.fDataFinalAnterior(const AdtaIni: TDateTime): TDate;
begin
  Result := DateOf(EndOfTheMonth(IncMonth(AdtaIni, -1)));
end;

function TfrmFechamentoContabil.fCampoCCustoLanBal(blCfg:boolean): string;
begin
  if blCfg then
    result := 'IFNULL(BAL_CCUSTO,'+QuotedStr('')+')'
  else
    result := 'CONVERT(NULL, CHAR(5))' ;
end;

function TfrmFechamentoContabil.fCampoCCustoLanMes(blCfg:boolean): string;
begin
  if blCfg then
    result := 'IFNULL(CON_CCUSTO,'+QuotedStr('')+')'
  else
    result := 'CONVERT(NULL, CHAR(5))' ;
end;


function TfrmFechamentoContabil.fCampoCCustoPlaMes(blCfg:boolean): string;
begin
  if blCfg then
    result := 'IFNULL(MES_CCUSTO,'+QuotedStr('')+')'
  else
    result := 'CONVERT(NULL, CHAR(5))' ;
end;

procedure TfrmFechamentoContabil.pDeletaPlaMes(const AdtaIni: TDateTime);
  var
    qryPlaMes : TFDQuery;
begin
  qryPlaMes := TFDQuery.Create(Self);
  qryPlaMes.Connection := FGravacaoEmLote.getDataBase;
  try
    qryPlaMes.Close;
    qryPlaMes.SQL.Clear;
    qryPlaMes.SQL.Add('DELETE FROM PLAMES WHERE MES_DTASAL > :DTAINI AND MES_CODEMP  IN (' + fGetInEmpresas(arrEmpSel) + ') ');
    qryPlaMes.ParamByName('DTAINI').AsDate := AdtaIni ;
    qryPlaMes.ExecSQL;
  finally
    FreeAndNil(qryPlaMes);
  end;
end;

procedure TfrmFechamentoContabil.pDeletaLanMes(const AdtaIni: TDateTime);
  var
    qryLanMes : TFDQuery;
begin
  qryLanMes := TFDQuery.Create(Self);
  qryLanMes.Connection := FGravacaoEmLote.getDataBase;
  try
    qryLanMes.Close;
    qryLanMes.SQL.Clear;
    qryLanMes.SQL.Add('DELETE FROM LANMES WHERE CON_DTALAN >= :DTAINI AND CON_EMPLAN  IN (' + fGetInEmpresas(arrEmpSel) + ') ');
    qryLanMes.ParamByName('DTAINI').AsDate := AdtaIni;
    qryLanMes.ExecSQL;
  finally
    FreeAndNil(qryLanMes);
  end;
end;

procedure TfrmFechamentoContabil.pGravaFecMes(const AdtaFin: TDateTime);
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
    LstrEmpresas := fGetInEmpresas(arrEmpSel) ;
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
      LdfcfDado.MesDta := AdtaFin ;
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

procedure TfrmFechamentoContabil.pAtualizarSaldoInicialDoAnoSeguinte(const ADataFinal: TDate;
  const AValorFinal: double; const ACodigoConta: string; const ACentroCusto: string; AdictDet: TDictLanDet);
var
  qryLanBal : TFDQuery;
  blCfg : Boolean ;
  blColIniCCusto : boolean ;
  LblnUpdate: Boolean;
  LstrAutoincrem: String;
  LPair: TPairLanDet;
  LintCount: Integer;
  LstrCfgAtv, LstrCfgPas, LstrCfgCom: string;
begin
  if (ADataFinal = 0) then
    Exit;

  if (MonthOf(ADataFinal) <> MonthsPerYear) then
    exit;

  LstrCfgAtv := fCfgSis('DIGATI');
  LstrCfgPas := fCfgSis('DIGPAS');
  LstrCfgCom := fSemMascaraPlaNco(fCfgDigCom);
  if (copy(ACodigoConta,1,fLenDig(LstrCfgAtv)) <> LstrCfgAtv) and (copy(ACodigoConta,1,fLenDig(LstrCfgPas)) <> LstrCfgPas) and (copy(ACodigoConta,1,fLenDig(LstrCfgCom)) <> LstrCfgCom) then
    exit;

  LstrAutoincrem := '';
  LblnUpdate := False;

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
      LstrAutoincrem := fRetAutoIncrem('PLAINI', VS_strCodEmp);
      qryLanBal.Insert;
      qryLanBal.FieldByName('AUTOINCREM').AsString := LstrAutoincrem;
      qryLanBal.FieldByName('INI_EXERCI').AsString := YearOf(IncMonth(ADataFinal)).ToString;
      qryLanBal.FieldByName('INI_CODEMP').AsString := edtEmpGrv.Text;
      qryLanBal.FieldByName('INI_CODCON').AsString := ACodigoConta;
      if (blCfg) and (blColIniCCusto) then
      begin
        qryLanBal.FieldByName('INI_CCUSTO').AsString := ACentroCusto;
      end;
    end
    else
    begin
      LblnUpdate := True;
      LstrAutoincrem := qryLanBal.FieldByName('AUTOINCREM').AsString;
      qryLanBal.Edit;
    end;

    if Assigned(qryLanBal.FindField('INI_CREDEB')) then
    begin
      qryLanBal.FieldByName('INI_CREDEB').AsString := IIF(AValorFinal > 0, 'D', 'C');
      qryLanBal.FieldByName('INI_SALINI').AsFloat := Abs(AValorFinal);
    end
    else
      qryLanBal.FieldByName('INI_SALINI').AsFloat := AValorFinal;

    qryLanBal.FieldByName('INI_DTAALT').AsDateTime := fNow();
    qryLanBal.FieldByName('INI_OPEALT').AsString := strLoginUsuarioLogado;

    qryLanBal.Post;

    if FblnTabelaPLADETExiste and Assigned(AdictDet) then
    begin
      if LblnUpdate then
      begin
        qryLanBal.Close;
        qryLanBal.SQL.Clear;
        qryLanBal.SQL.Add('DELETE FROM PLADET WHERE DET_PLAINC = :PLAINC ');
        qryLanBal.Params.ClearValues();
        qryLanBal.ParamByName('PLAINC').AsString := LstrAutoincrem;
        qryLanBal.ExecSQL;
      end;

      if AdictDet.Count = 0 then
        Exit;

      qryLanBal.Close;
      qryLanBal.SQL.Clear;
      qryLanBal.SQL.Add('INSERT INTO PLADET (DET_PLAINC, DET_EMPDET, DET_CREDEB, DET_SALINI) VALUES(:PLAINC, :EMPDET, :CREDEB, :SALINI) ');
      qryLanBal.Params.ClearValues();
      qryLanBal.Params.ArraySize := AdictDet.Count;
      qryLanBal.ParamByName('PLAINC').DataType := ftString;
      qryLanBal.ParamByName('EMPDET').DataType := ftString;
      qryLanBal.ParamByName('CREDEB').DataType := ftString;
      qryLanBal.ParamByName('SALINI').DataType := ftFloat;

      LintCount := 0;
      for LPair in AdictDet do
      begin
        qryLanBal.ParamByName('PLAINC').AsStrings[LintCount] := LstrAutoincrem;
        qryLanBal.ParamByName('EMPDET').AsStrings[LintCount] := LPair.Key;
        qryLanBal.ParamByName('CREDEB').AsStrings[LintCount] := LPair.Value.CrDeFi;
        qryLanBal.ParamByName('SALINI').AsFloats[LintCount]  := LPair.Value.SalFin;

        Inc(LintCount);
      end;
      qryLanBal.Execute(AdictDet.Count, 0);
    end;

  finally
    FreeAndNil(qryLanBal);
  end;
end;

procedure TfrmFechamentoContabil.pAtualizarSaldoInicialDoAnoSeguinteSubContas(
  pgbProgresso: TcxProgressBar; const AdtaFin: TDateTime);

type TEmpValor = record
   strCodEmp : string;
   fltValor  : double;
end;

var
  LqrySubCon, LqryIncluir, LqryIncluirDet: TFDQuery ;
  LdtaIni, LdtaFin: TDateTime ;
  LintAno: Integer ;
  LintAnoPosterior: Integer ;
  LintRecordCount: Integer ;
  LstrConta, LstrTipFC, LstrForCli: String;
  LfltSaldo: Double;
  LlistEmpValor: TList<TEmpValor>;
  LEmpValor : TEmpValor;

begin
  if fCfgDesmembrarSubContaCliFor = 'N' then
    Exit ;

  if (MonthOf(AdtaFin) <> MonthsPerYear) then
    exit;

  pSetaTextoProgresso(pgbProgresso, 'Saldo Inicial Sub-Contas...');

  LdtaIni := EncodeDate(YearOf(AdtaFin), 1, 1) ;
  LdtaFin := EncodeDate(YearOf(AdtaFin), 12, 31) ;
  LintAno := YearOf(AdtaFin) ;
  LintAnoPosterior := YearOf(AdtaFin)+1 ;

  LqrySubCon := TFDQuery.Create(Self);
  LqrySubCon.Connection := FGravacaoEmLote.getDataBase;
  LqryIncluir := TFDQuery.Create(Self);
  LqryIncluir.Connection := FGravacaoEmLote.getDataBase;
  LqryIncluirDet := TFDQuery.Create(Self);
  LqryIncluirDet.Connection := FGravacaoEmLote.getDataBase;
  LlistEmpValor := TList<TEmpValor>.Create;
  try
    if FblnTabelaDPRDETExiste then
    begin
      LqrySubCon.Close ;
      LqrySubCon.SQL.Clear ;
      LqrySubCon.SQL.Add('DELETE FROM DPRDET WHERE DET_EXERCI = :EXERCI AND DET_CODEMP = :CODEMP;');
      LqrySubCon.ParamByName('EXERCI').AsInteger := LintAnoPosterior ;
      LqrySubCon.ParamByName('CODEMP').AsString := edtEmpGrv.Text ;
      LqrySubCon.ExecSQL ;
    end;
    LqrySubCon.Close ;
    LqrySubCon.SQL.Clear ;
    LqrySubCon.SQL.Add('DELETE FROM DPRINI WHERE INI_EXERCI = :EXERCI AND INI_CODEMP = :CODEMP;');

    LqrySubCon.ParamByName('EXERCI').AsInteger := LintAnoPosterior ;
    LqrySubCon.ParamByName('CODEMP').AsString := edtEmpGrv.Text ;

    LqrySubCon.ExecSQL ;

    LqrySubCon.Close ;
    LqrySubCon.SQL.Clear ;
    LqrySubCon.SQL.Add('SELECT EMPDET, CONTA, CON_CLIFOR, CON_TIP_FC, SUM(VALOR) AS VALOR FROM ( ') ;

    LqrySubCon.SQL.Add('   SELECT CON_EMPLAN AS EMPDET, CON_CONCRE AS CONTA, CON_CLIFOR, CON_TIP_FC, ') ;
    LqrySubCon.SQL.Add('     COALESCE(-CON_VALLAN, 0.00) AS VALOR ') ;
    LqrySubCon.SQL.Add('   FROM LANCON ') ;
    LqrySubCon.SQL.Add('   LEFT JOIN PLANCO PC ON LANCON.CON_CONCRE = PC.NCO_CODCON ') ;
    LqrySubCon.SQL.Add('   WHERE PC.NCO_SUBCNT = "S" ') ;
    LqrySubCon.SQL.Add('     AND LANCON.CON_DTALAN BETWEEN :DTAINI AND :DTAFIN ') ;
    LqrySubCon.SQL.Add('     AND LANCON.CON_EMPLAN IN ( ' + fGetInEmpresas(arrEmpSel) + ' ) ') ;

    LqrySubCon.SQL.Add('   UNION ALL ') ;

    LqrySubCon.SQL.Add('   SELECT CON_EMPLAN AS EMPDET, CON_CONDEB AS CONTA, CON_CLIFOR, CON_TIP_FC, ') ;
    LqrySubCon.SQL.Add('     COALESCE(CON_VALLAN, 0.00) AS VALOR ') ;
    LqrySubCon.SQL.Add('   FROM LANCON ') ;
    LqrySubCon.SQL.Add('   LEFT JOIN PLANCO PD ON LANCON.CON_CONDEB = PD.NCO_CODCON ') ;
    LqrySubCon.SQL.Add('   WHERE PD.NCO_SUBCNT = "S" ') ;
    LqrySubCon.SQL.Add('     AND LANCON.CON_DTALAN BETWEEN :DTAINI AND :DTAFIN ') ;
    LqrySubCon.SQL.Add('     AND LANCON.CON_EMPLAN IN ( ' + fGetInEmpresas(arrEmpSel) + ' ) ') ;

    LqrySubCon.SQL.Add('   UNION ALL ') ;

    LqrySubCon.SQL.Add('   SELECT IFNULL(DET_EMPDET, INI_CODEMP) AS EMPDET, INI_CODCON AS CONTA, INI_CLIFOR AS CON_CLIFOR, INI_TIP_FC AS CON_TIP_FC, ') ;
    LqrySubCon.SQL.Add('     IF(DET_SALINI IS NOT NULL, CASE WHEN DET_CREDEB = "C" THEN -DET_SALINI ELSE DET_SALINI END, COALESCE(CASE WHEN INI_CREDEB = "C" THEN -INI_SALINI ELSE INI_SALINI END, 0.00)) AS VALOR ') ;
    LqrySubCon.SQL.Add('   FROM DPRINI ') ;
    LqrySubCon.SQL.Add('   LEFT JOIN ' + fJoinDprDet + ' ON DET_CODCON = INI_CODCON ');
    LqrySubCon.SQL.Add('     AND DET_CLIFOR = INI_CLIFOR ');
    LqrySubCon.SQL.Add('     AND DET_TIP_FC = INI_TIP_FC ');
    LqrySubCon.SQL.Add('     AND DET_EXERCI = INI_EXERCI ');
    LqrySubCon.SQL.Add('     AND DET_CODEMP = INI_CODEMP ');
    LqrySubCon.SQL.Add('   WHERE DPRINI.INI_EXERCI = :ANO ') ;
    LqrySubCon.SQL.Add('     AND DPRINI.INI_CODEMP IN ( ' + fGetInEmpresas(arrEmpSel) + ' ) ') ;

    LqrySubCon.SQL.Add(') AS SEL ') ;
    LqrySubCon.SQL.Add('GROUP BY CONTA, CON_CLIFOR, CON_TIP_FC, EMPDET ') ;
    LqrySubCon.SQL.Add('ORDER BY CONTA, CON_CLIFOR, CON_TIP_FC ');

    LqrySubCon.ParamByName('DTAINI').AsDate := LdtaIni ;
    LqrySubCon.ParamByName('DTAFIN').AsDate := LdtaFin ;
    LqrySubCon.ParamByName('ANO').AsInteger := LintAno ;

    LqrySubCon.Open ;

    LqryIncluir.Close ;
    LqryIncluir.SQL.Clear ;
    LqryIncluir.SQL.Add('SELECT * FROM DPRINI WHERE FALSE ');
    LqryIncluir.Open ;

    LqryIncluirDet.Close;
    LqryIncluirDet.SQL.Clear;
    LqryIncluirDet.SQL.Add('INSERT INTO DPRDET (DET_CODCON, DET_EXERCI, DET_TIP_FC, DET_CLIFOR, DET_CODEMP, DET_EMPDET, DET_CREDEB, DET_SALINI) ');
    LqryIncluirDet.SQL.Add('VALUES (:CODCON, :EXERCI, :TIP_FC, :CLIFOR, :CODEMP, :EMPDET, :CREDEB, :SALINI) ');

    LintRecordCount := LqrySubCon.RecordCount;
    pgbProgresso.Properties.Max := LintRecordCount;

    LqrySubCon.First ;
    while not LqrySubCon.Eof do
    begin
      pgbProgresso.Position := LqrySubCon.RecNo;
      Application.ProcessMessages ;

      LlistEmpValor.Clear;

      LstrConta := LqrySubCon.FieldByName('CONTA').AsString ;
      LstrTipFC := LqrySubCon.FieldByName('CON_TIP_FC').AsString ;
      LstrForCli := LqrySubCon.FieldByName('CON_CLIFOR').AsString ;

      LfltSaldo := 0;

      while (not LqrySubCon.Eof) and (
        fStrChaveDprIni(LstrConta, LstrTipFC, LstrForCli) =
        fStrChaveDprIni(LqrySubCon.FieldByName('CONTA').AsString, LqrySubCon.FieldByName('CON_TIP_FC').AsString, LqrySubCon.FieldByName('CON_CLIFOR').AsString)
      ) do
      begin
        LEmpValor.strCodEmp := LqrySubCon.FieldByName('EMPDET').AsString;
        LEmpValor.fltValor  := LqrySubCon.FieldByName('VALOR').AsFloat;
        LlistEmpValor.Add(LEmpValor);

        LfltSaldo := LfltSaldo + LqrySubCon.FieldByName('VALOR').AsFloat ;

        LqrySubCon.Next ;
      end;

      LqryIncluir.Append ;
      LqryIncluir.FieldByName('INI_CODCON').AsString := LstrConta ;
      LqryIncluir.FieldByName('INI_EXERCI').AsString := IntToStr(LintAnoPosterior) ;
      LqryIncluir.FieldByName('INI_SALINI').AsFloat := abs(LfltSaldo) ;
      LqryIncluir.FieldByName('INI_CODEMP').AsString := edtEmpGrv.Text ;
      LqryIncluir.FieldByName('INI_CREDEB').AsString := fCreDebPeloValor(LfltSaldo);
      LqryIncluir.FieldByName('INI_CLIFOR').AsString := LstrForCli ;
      LqryIncluir.FieldByName('INI_TIP_FC').AsString := LstrTipFC ;
      LqryIncluir.FieldByName('INI_DTAALT').AsDateTime := fNow();
      LqryIncluir.FieldByName('INI_OPEALT').AsString := strLoginUsuarioLogado;
      LqryIncluir.Post ;

      if FblnTabelaDPRDETExiste then
      begin
        for LEmpValor in LlistEmpValor do
        begin
          LqryIncluirDet.ParamByName('CODCON').AsString := LstrConta;
          LqryIncluirDet.ParamByName('EXERCI').AsString := IntToStr(LintAnoPosterior);
          LqryIncluirDet.ParamByName('CODEMP').AsString := edtEmpGrv.Text ;
          LqryIncluirDet.ParamByName('TIP_FC').AsString := LstrTipFC;
          LqryIncluirDet.ParamByName('CLIFOR').AsString := LstrForCli;
          LqryIncluirDet.ParamByName('EMPDET').AsString := LEmpValor.strCodEmp;
          LqryIncluirDet.ParamByName('CREDEB').AsString := fCreDebPeloValor(LEmpValor.fltValor);
          LqryIncluirDet.ParamByName('SALINI').AsFloat := abs(LEmpValor.fltValor);
          LqryIncluirDet.ExecSQL;
        end;
      end;
    end ;

  finally
    FreeAndNil(LqrySubCon);
    FreeAndNil(LqryIncluir);
    FreeAndNil(LqryIncluirDet);
    FreeAndNil(LlistEmpValor);
  end ;

  pgbProgresso.Position := 0;
end;

procedure TfrmFechamentoContabil.pGravaBalanceteMensal(pgbProgresso: TcxProgressBar; const AdtaIni, AdtaFin: TDateTime);

  function fFiltroPatrimonialEResultadoComSaldo: string;
  var
    intTamanhoDigCus: integer ;
    intTamanhoDigDes: integer ;
    intTamanhoDigRec: integer ;
    intTamanhoDigAti: integer ;
    intTamanhoDigPas: integer ;
    intTamanhoDigOut: integer;
  begin
    intTamanhoDigCus := fLenDig(fSemMascaraPlaNco(fCfgDigcus)) ;
    intTamanhoDigDes := fLenDig(fSemMascaraPlaNco(fCfgDigdes)) ;
    intTamanhoDigRec := fLenDig(fSemMascaraPlaNco(fCfgDigrec)) ;
    intTamanhoDigAti := fLenDig(fCfgSis('DIGATI'));
    intTamanhoDigPas := fLenDig(fCfgSis('DIGPAS'));
    intTamanhoDigOut := fLenDig(fSemMascaraPlaNco(fCfgSis('DIGOUT'))) ;

    Result := '';
    Result := Result + ' (   (NCO_PATRIM = "S") OR (LEFT(NCO_CODCON,' + intToStr(intTamanhoDigRec) + ') = :DIGREC) ';
    Result := Result + ' OR  (LEFT(NCO_CODCON,' + intToStr(intTamanhoDigDes) + ') = :DIGDES) OR (IFNULL(NCO_APURAC,0) = 1) ';
    Result := Result + ' OR  (LEFT(NCO_CODCON,' + intToStr(intTamanhoDigAti) + ') = :DIGATI) OR (LEFT(NCO_CODCON,' + intToStr(intTamanhoDigPas) + ') = :DIGPAS) ';
    if not fEmptyStr(fCfgSis('DIGOUT')) then
      Result := Result + ' OR (LEFT(NCO_CODCON,' + intToStr(intTamanhoDigOut) + ') = :DIGOUT) ';

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
    LfltSaldoFinal, LfltSaldoInicial, LfltDebito, LfltCredito : Double;
    LfltDetSaldoFinal, LfltDetSaldoInicial, LfltDetDebito, LfltDetCredito : Double;
    LdfclDado : TDadosFechamentoContabilLanBal;
    LlstDados : TObjectList<TDadosFechamentoContabilLanBal>;
    LintCntItens : Integer ;
    LintCntDet: Integer ;
    LrecSaldosLanDet: TSaldosLanDet;
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

    qryApuracao.SQL.Add('SELECT CONTA, CCUSTO, EMPDET, SUM(SALDO_INICIAL) AS SALDO_INICIAL, SUM(DEBITO) AS DEBITO, SUM(CREDITO) AS CREDITO FROM ( ');

    if MonthOf(AdtaIni) = 1 then
    begin
      // Saldo Inicial (Ano)
      qryApuracao.SQL.Add('SELECT INI_CODCON AS CONTA, ' + strCampoCCustoPlaIni + ' AS CCUSTO, IFNULL(DET_EMPDET, INI_CODEMP) AS EMPDET, ');
      qryApuracao.SQL.Add('  IF(DET_SALINI IS NOT NULL, IF(DET_CREDEB = "D", ABS(DET_SALINI), -ABS(DET_SALINI)), ' + fCampoSaldoInicialPlaIni + ') AS SALDO_INICIAL, ');
      qryApuracao.SQL.Add('  0.00 AS DEBITO, 0.00 AS CREDITO ');
      qryApuracao.SQL.Add('FROM PLAINI ');
      qryApuracao.SQL.Add('LEFT JOIN '+fJoinPlaDet+' ON DET_PLAINC = PLAINI.AUTOINCREM ');
      qryApuracao.SQL.Add('INNER JOIN CADEMP ON INI_CODEMP = EMP_CODEMP ');
      qryApuracao.SQL.Add('LEFT JOIN PLANCO ON NCO_CODCON = INI_CODCON AND NCO_TPLACO = EMP_TPLACO AND :DTAINI <= COALESCE(PLANCO.NCO_DTAFIN,"9999-01-01") AND :DTAFIN >= COALESCE(PLANCO.NCO_DTAINI,"2000-01-01") ');
      qryApuracao.SQL.Add('WHERE INI_CODEMP IN (' + fGetInEmpresas(arrEmpSel) + ') AND INI_EXERCI = :EXERCI ');
      qryApuracao.SQL.Add('  AND ' + fFiltroPatrimonialEResultadoComSaldo);
    end
    else
    begin
      // Saldo Inicial (Mês Anterior)
      qryApuracao.SQL.Add('SELECT BAL_CODCON AS CONTA, ' + strCampoCCustoLanBal + ' AS CCUSTO, IFNULL(DET_EMPDET, BAL_CODEMP) AS EMPDET, ');
      qryApuracao.SQL.Add('  IF(DET_SALFIN IS NOT NULL, IF(DET_CRDEFI = "D", ABS(DET_SALFIN), -ABS(DET_SALFIN)), '+fCampoSaldoFinalLanBal+') AS SALDO_INICIAL, ');
      qryApuracao.SQL.Add('  0.00 AS DEBITO, 0.00 AS CREDITO ');
      qryApuracao.SQL.Add('FROM LANBAL ');
      qryApuracao.SQL.Add('LEFT JOIN '+fJoinLanDet+' ON DET_DTAMOV = BAL_DTAMOV ');
      qryApuracao.SQL.Add('  AND DET_CODCON = BAL_CODCON ');
      qryApuracao.SQL.Add('  AND IFNULL(DET_CCUSTO, "") = IFNULL(' + strCampoCCustoLanBal + ', "") ');
      qryApuracao.SQL.Add('  AND DET_CODEMP = BAL_CODEMP ');
      qryApuracao.SQL.Add('INNER JOIN CADEMP ON BAL_CODEMP = EMP_CODEMP ');
      qryApuracao.SQL.Add('LEFT JOIN PLANCO ON NCO_CODCON = BAL_CODCON AND NCO_TPLACO = EMP_TPLACO AND :DTAINI <= COALESCE(PLANCO.NCO_DTAFIN,"9999-01-01") AND :DTAFIN >= COALESCE(PLANCO.NCO_DTAINI,"2000-01-01") ');
      qryApuracao.SQL.Add('WHERE BAL_CODEMP IN (' + fGetInEmpresas(arrEmpSel) + ') AND BAL_DTAMOV = :DTAANT ');
      qryApuracao.SQL.Add('  AND ' + fFiltroPatrimonialEResultadoComSaldo);
    end;

    qryApuracao.SQL.Add('UNION ALL ');

    // Apuração do período (Crédito)
    qryApuracao.SQL.Add('SELECT CON_CONCRE AS CONTA, ' + strCampoCCustoLanConCred + ' AS CCUSTO, CON_EMPLAN AS EMPDET, 0.00 AS SALDO_INICIAL, 0.00 AS DEBITO, -ABS(CON_VALLAN) AS CREDITO ');
    qryApuracao.SQL.Add('FROM LANCON ');
    qryApuracao.SQL.Add('INNER JOIN CADEMP ON CON_EMPLAN = EMP_CODEMP ');
    qryApuracao.SQL.Add('LEFT JOIN PLANCO ON NCO_CODCON = CON_CONCRE AND NCO_TPLACO = EMP_TPLACO AND :DTAINI <= COALESCE(PLANCO.NCO_DTAFIN,"9999-01-01") AND :DTAFIN >= COALESCE(PLANCO.NCO_DTAINI,"2000-01-01") ');
    qryApuracao.SQL.Add('WHERE CON_EMPLAN IN (' + fGetInEmpresas(arrEmpSel) + ') AND CON_DTALAN BETWEEN :DTAINI AND :DTAFIN ');
    qryApuracao.SQL.Add('  AND ' + fFiltroPatrimonialEResultadoComSaldo);

    qryApuracao.SQL.Add('UNION ALL ');

    // Apuração do período (Débito)
    qryApuracao.SQL.Add('SELECT CON_CONDEB AS CONTA, ' + strCampoCCustoLanConDeb + ' AS CCUSTO, CON_EMPLAN AS EMPDET, 0.00 AS SALDO_INICIAL, ABS(CON_VALLAN) DEBITO, 0.00 AS CREDITO ');
    qryApuracao.SQL.Add('FROM LANCON ');
    qryApuracao.SQL.Add('INNER JOIN CADEMP ON CON_EMPLAN = EMP_CODEMP ');
    qryApuracao.SQL.Add('LEFT JOIN PLANCO ON NCO_CODCON = CON_CONDEB AND NCO_TPLACO = EMP_TPLACO AND :DTAINI <= COALESCE(PLANCO.NCO_DTAFIN,"9999-01-01") AND :DTAFIN >= COALESCE(PLANCO.NCO_DTAINI,"2000-01-01") ');
    qryApuracao.SQL.Add('WHERE CON_EMPLAN IN (' + fGetInEmpresas(arrEmpSel) + ') AND CON_DTALAN BETWEEN :DTAINI AND :DTAFIN ');
    qryApuracao.SQL.Add('  AND ' + fFiltroPatrimonialEResultadoComSaldo);

    qryApuracao.SQL.Add(') AS TMP_APURACA ');
    qryApuracao.SQL.Add('GROUP BY CONTA, CCUSTO, EMPDET ');
    qryApuracao.SQL.Add('ORDER BY CONTA, CCUSTO ');

    if (Assigned(qryApuracao.FindParam('EXERCI'))) then
      qryApuracao.ParamByName('EXERCI').AsInteger := fExercicio;

    qryApuracao.ParamByName('DTAINI').AsDate := AdtaIni;
    qryApuracao.ParamByName('DTAFIN').AsDate := AdtaFin;
    qryApuracao.ParamByName('DIGREC').AsString := fCfgDigrec;
    qryApuracao.ParamByName('DIGDES').AsString := fCfgDigdes;
    qryApuracao.ParamByName('DIGATI').AsString := fCfgSis('DIGATI');
    qryApuracao.ParamByName('DIGPAS').AsString := fCfgSis('DIGPAS');
    if (Assigned(qryApuracao.FindParam('DIGOUT'))) then
      qryApuracao.ParamByName('DIGOUT').AsString := fCfgSis('DIGOUT');

    if (Assigned(qryApuracao.FindParam('DTAANT'))) then
      qryApuracao.ParamByName('DTAANT').AsDate := fDataFinalAnterior(AdtaIni);

    qryApuracao.Open;

    LintCntDet := 0;
    LintCntItens := 0;
    intCount := 1;
    intRecordCount := qryApuracao.RecordCount;
    pgbProgresso.Properties.Max := intRecordCount;

    while not qryApuracao.Eof do
    begin
      pgbProgresso.Position := qryApuracao.RecNo;
      pSetaTextoProgresso(pgbProgresso, 'Balancete: ' + IntToStr(intCount) + '/' + IntToStr(intRecordCount));

      LdfclDado := TDadosFechamentoContabilLanBal.Create;
      LdfclDado.CodCon := qryApuracao.FieldByName('CONTA').AsString ;
      LdfclDado.CCusto := qryApuracao.FieldByName('CCUSTO').AsString ;
      LdfclDado.CodEmp := edtEmpGrv.Text;
      LdfclDado.DtaMov := AdtaFin;

      LfltSaldoFinal := 0;
      LfltSaldoInicial := 0;
      LfltDebito := 0;
      LfltCredito := 0;

      while (not qryApuracao.Eof)
        and (LdfclDado.CodCon = qryApuracao.FieldByName('CONTA').AsString)
        and (LdfclDado.CCusto = qryApuracao.FieldByName('CCUSTO').AsString) do
      begin
        intCount := intCount + 1;

        LfltDetSaldoInicial := qryApuracao.FieldByName('SALDO_INICIAL').AsFloat ;
        LfltDetDebito       := qryApuracao.FieldByName('DEBITO').AsFloat ;
        LfltDetCredito      := qryApuracao.FieldByName('CREDITO').AsFloat ;
        LfltDetSaldoFinal   := LfltDetSaldoInicial + abs(LfltDetDebito) - abs(LfltDetCredito);

        LrecSaldosLanDet.SalAnt := Abs(LfltDetSaldoInicial);
        LrecSaldosLanDet.Debito := Abs(LfltDetDebito);
        LrecSaldosLanDet.Credit := Abs(LfltDetCredito);
        LrecSaldosLanDet.SalFin := Abs(LfltDetSaldoFinal);
        LrecSaldosLanDet.CrDeAn := fCreDebPeloValor(LfltDetSaldoInicial);
        LrecSaldosLanDet.CrDeFi := fCreDebPeloValor(LfltDetSaldoFinal);

        //acumula dict LANDET
        LdfclDado.LanDet.Add(qryApuracao.FieldByName('EMPDET').AsString, LrecSaldosLanDet);

        //acumula valores LANBAL
        LfltSaldoInicial := LfltSaldoInicial + LfltDetSaldoInicial;
        LfltDebito       := LfltDebito + LfltDetDebito;
        LfltCredito      := LfltCredito + LfltDetCredito;
        LfltSaldoFinal   := LfltSaldoFinal + LfltDetSaldoFinal;

        qryApuracao.Next;
      end;

      pAtualizarSaldoInicialDoAnoSeguinte(AdtaFin, LfltSaldoFinal, LdfclDado.CodCon, LdfclDado.CCusto, LdfclDado.LanDet);

      LdfclDado.SalAnt := Abs(LfltSaldoInicial);
      LdfclDado.Debito := Abs(LfltDebito);
      LdfclDado.Credit := Abs(LfltCredito);
      LdfclDado.SalFin := Abs(LfltSaldoFinal);
      LdfclDado.CrDeAn := fCreDebPeloValor(LfltSaldoInicial);
      LdfclDado.CrDeFi := fCreDebPeloValor(LfltSaldoFinal);

      LlstDados.Add(LdfclDado);

      LintCntDet := LintCntDet + LdfclDado.LanDet.Count;
      LintCntItens := LintCntItens + 1 ;
      if LintCntItens >= intTamanhoLote then
      begin
        FGravacaoEmLote.pGravarLanBal(LlstDados, LintCntDet);
        LlstDados.Clear;
        LintCntItens := 0;
        LintCntDet := 0;
      end;
    end;

    if LlstDados.Count > 0 then
    begin
      FGravacaoEmLote.pGravarLanBal(LlstDados, LintCntDet);
      LlstDados.Clear;
    end ;

    pgbProgresso.Position := 0;
  finally
    FreeAndNil(qryApuracao);
    FreeAndNil(LlstDados);
  end;
end;

procedure TfrmFechamentoContabil.pDeletaPlaIniProximoExercicio(const ADataFinal:TDate);
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
    //PLADET É DELETADA VIA CASCADE
    qryLanBal.SQL.Add('DELETE FROM PLAINI WHERE INI_EXERCI = :EXERCI AND INI_CODEMP  IN (' + fGetInEmpresas(arrEmpSel) + ') ');
    qryLanBal.ParamByName('EXERCI').AsInteger := YearOf(ADataFinal)+1;
    qryLanBal.ExecSQL;
  finally
    FreeAndNil(qryLanBal);
  end;
end;

procedure TfrmFechamentoContabil.pDeletaFecMes(const AdtaFin: TDateTime);
  var
    LqryFecMes : TFDQuery;
begin
  LqryFecMes := TFDQuery.Create(Self);
  try
    LqryFecMes.Connection := FGravacaoEmLote.getDataBase;
    LqryFecMes.Close;
    LqryFecMes.SQL.Clear;
    LqryFecMes.SQL.Add('DELETE FROM FECMES WHERE MES_CODEMP IN (' + fGetInEmpresas(arrEmpSel) + ') AND MES_MESDTA = :MESDTA');
    LqryFecMes.ParamByName('MESDTA').AsDate := AdtaFin;
    LqryFecMes.ExecSQL;
  finally
    FreeAndNil(LqryFecMes);
  end;
end;

procedure TfrmFechamentoContabil.pDeletaBalanceteMensal(const AdtaFin: TDateTime);
  var
    qryLanBal : TFDQuery;
begin
  qryLanBal := TFDQuery.Create(Self);
  qryLanBal.Connection := FGravacaoEmLote.getDataBase;
  try
    qryLanBal.Close;
    qryLanBal.SQL.Clear;
    if FblnTabelaLANDETExiste then
      qryLanBal.SQL.Add('DELETE FROM LANDET WHERE DET_CODEMP IN (' + fGetInEmpresas(arrEmpSel) + ') AND DET_DTAMOV = :DTAMOV;');
    qryLanBal.SQL.Add('DELETE FROM LANBAL WHERE BAL_CODEMP IN (' + fGetInEmpresas(arrEmpSel) + ') AND BAL_DTAMOV = :DTAMOV;');
    qryLanBal.ParamByName('DTAMOV').AsDate := AdtaFin;
    qryLanBal.ExecSQL;
  finally
    FreeAndNil(qryLanBal);
  end;
end;

procedure TfrmFechamentoContabil.pLucroPrejuizoMensal(pgbProgresso: TcxProgressBar; const AdtaIni, AdtaFin: TDateTime);
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
    qryLucroPrejuizo.ParamByName('DTALAN').AsDate := AdtaFin;
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
        LdfcpDado.DtaSal := IncDay(AdtaFin) ;
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
    qryLucroPrejuizo.ParamByName('DTALAN').AsDate := AdtaFin;
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
        LdfcpDado.DtaSal := IncDay(AdtaFin) ;
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

procedure TfrmFechamentoContabil.pApuracaoMensal(strDigito: string; pgbProgresso: TcxProgressBar; strTexto: string; const AdtaIni, AdtaFin: TDateTime; blnApuracaoAposLucroOperacional: boolean = false);
  var
    qryApuracao : TFDQuery;
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
  qryApuracao := TFDQuery.Create(Self);
  qryApuracao.Connection := FGravacaoEmLote.getDataBase;
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
    qryApuracao.SQL.Add('           WHERE INI_CODEMP IN (' + fGetInEmpresas(arrEmpSel) + ') AND INI_EXERCI = ":EXERCI" ');

    if not blnApuracaoAposLucroOperacional then
      qryApuracao.SQL.Add(' AND INI_CODCON LIKE :DIGITO ')
    else
      qryApuracao.SQL.Add(' AND IFNULL(NCO_APURAC,0) = 1 ');

    qryApuracao.SQL.Add('           UNION ALL ');

    // Saldo Inicial (Mensal, ANTES PERÍODO)
    qryApuracao.SQL.Add('          SELECT MES_CODCON AS CONTA, CAST(' + fCampoSaldoInicialPlaMes + ' AS DECIMAL(12,2)) AS VALOR, ' + strCampoCCustoPlaMes + ' as CENTRO_CUSTO ');
    qryApuracao.SQL.Add('            FROM PLAMES ');
    qryApuracao.SQL.Add('       INNER JOIN CADEMP ON MES_CODEMP = EMP_CODEMP ');
    qryApuracao.SQL.Add('       LEFT  JOIN PLANCO ON NCO_CODCON = MES_CODCON AND NCO_TPLACO = EMP_TPLACO ');
    qryApuracao.SQL.Add('           WHERE MES_CODEMP IN (' + fGetInEmpresas(arrEmpSel) + ') AND MES_DTASAL < :DTAINI ');

    if not blnApuracaoAposLucroOperacional then
      qryApuracao.SQL.Add(' AND MES_CODCON LIKE :DIGITO ')
    else
      qryApuracao.SQL.Add(' AND IFNULL(NCO_APURAC,0) = 1 ');

    qryApuracao.SQL.Add('           UNION ALL ');

    // Saldo Inicial (Mensal)
    qryApuracao.SQL.Add('          SELECT MES_CODCON AS CONTA, CAST(' + fCampoSaldoInicialPlaMes + '  AS DECIMAL(12,2)) AS VALOR, ' + strCampoCCustoPlaMes + ' as CENTRO_CUSTO ');
    qryApuracao.SQL.Add('            FROM PLAMES ');
    qryApuracao.SQL.Add('       INNER JOIN CADEMP ON MES_CODEMP = EMP_CODEMP ');
    qryApuracao.SQL.Add('       LEFT JOIN PLANCO ON NCO_CODCON = MES_CODCON AND NCO_TPLACO = EMP_TPLACO ');
    qryApuracao.SQL.Add('           WHERE MES_CODEMP IN (' + fGetInEmpresas(arrEmpSel) + ') AND MES_DTASAL = :DTAINI ');

    if not blnApuracaoAposLucroOperacional then
      qryApuracao.SQL.Add(' AND MES_CODCON LIKE :DIGITO ')
    else
      qryApuracao.SQL.Add(' AND IFNULL(NCO_APURAC,0) = 1 ');

    qryApuracao.SQL.Add('           UNION ALL ');

    // Apuração até antes do período (LANCON, Crédito)
    qryApuracao.SQL.Add('          SELECT CON_CONCRE AS CONTA, CAST(-SUM(ABS(CON_VALLAN)) AS DECIMAL(12,2)) AS VALOR, ' + strCampoCCustoLanConCred + ' as CENTRO_CUSTO ');
    qryApuracao.SQL.Add('            FROM LANCON ');
    qryApuracao.SQL.Add('       INNER JOIN CADEMP ON CON_EMPLAN = EMP_CODEMP ');
    qryApuracao.SQL.Add('       LEFT JOIN PLANCO ON NCO_CODCON = CON_CONCRE AND NCO_TPLACO = EMP_TPLACO ');
    qryApuracao.SQL.Add('           WHERE CON_EMPLAN IN (' + fGetInEmpresas(arrEmpSel) + ') AND CON_DTALAN < :DTAINI AND ' + fTrataFiltroCampoDataLancon + ' = :EXERCI ');

    if not blnApuracaoAposLucroOperacional then
      qryApuracao.SQL.Add(' AND CON_CONCRE LIKE :DIGITO ')
    else
      qryApuracao.SQL.Add(' AND IFNULL(NCO_APURAC,0) = 1 ');

    qryApuracao.SQL.Add('           GROUP BY CON_CONCRE, '+strCampoCCustoLanConCred);

    qryApuracao.SQL.Add('           UNION ALL ');

    // Apuração até antes do período (LANMES, Crédito)
    qryApuracao.SQL.Add('          SELECT CON_CONCRE AS CONTA, CAST(-SUM(ABS(CON_VALLAN)) AS DECIMAL(12,2)) AS VALOR, ' + strCampoCCustoLanMes + ' as CENTRO_CUSTO ');
    qryApuracao.SQL.Add('            FROM LANMES ');
    qryApuracao.SQL.Add('       INNER JOIN CADEMP ON CON_EMPLAN = EMP_CODEMP ');
    qryApuracao.SQL.Add('       LEFT JOIN PLANCO ON NCO_CODCON = CON_CONCRE AND NCO_TPLACO = EMP_TPLACO ');
    qryApuracao.SQL.Add('           WHERE CON_EMPLAN IN (' + fGetInEmpresas(arrEmpSel) + ') AND CON_DTALAN < :DTAINI AND YEAR(CON_DTALAN) = :EXERCI ');

    if not blnApuracaoAposLucroOperacional then
      qryApuracao.SQL.Add(' AND CON_CONCRE LIKE :DIGITO ')
    else
      qryApuracao.SQL.Add(' AND IFNULL(NCO_APURAC,0) = 1 ');

    qryApuracao.SQL.Add('           GROUP BY CON_CONCRE, ' + strCampoCCustoLanMes );

    qryApuracao.SQL.Add('           UNION ALL ');

    // Apuração até antes do período (LANCON, Débito)
    qryApuracao.SQL.Add('          SELECT CON_CONDEB AS CONTA, CAST(SUM(ABS(CON_VALLAN)) AS DECIMAL(12,2)) AS VALOR, ' + strCampoCCustoLanCondeb + ' as CENTRO_CUSTO ');
    qryApuracao.SQL.Add('            FROM LANCON ');
    qryApuracao.SQL.Add('       INNER JOIN CADEMP ON CON_EMPLAN = EMP_CODEMP ');
    qryApuracao.SQL.Add('       LEFT JOIN PLANCO ON NCO_CODCON = CON_CONDEB AND NCO_TPLACO = EMP_TPLACO ');
    qryApuracao.SQL.Add('           WHERE CON_EMPLAN IN (' + fGetInEmpresas(arrEmpSel) + ') AND CON_DTALAN < :DTAINI AND ' + fTrataFiltroCampoDataLancon + ' = :EXERCI ');

    if not blnApuracaoAposLucroOperacional then
      qryApuracao.SQL.Add(' AND CON_CONDEB LIKE :DIGITO ')
    else
      qryApuracao.SQL.Add(' AND IFNULL(NCO_APURAC,0) = 1 ');

    qryApuracao.SQL.Add('           GROUP BY CON_CONDEB, ' + strCampoCCustoLanCondeb );

    qryApuracao.SQL.Add('           UNION ALL ');

    // Apuração até antes do período (LANMES, Débito)
    qryApuracao.SQL.Add('          SELECT CON_CONDEB AS CONTA, CAST(SUM(ABS(CON_VALLAN)) AS DECIMAL(12,2)) AS VALOR, ' + strCampoCCustoLanMes + ' as CENTRO_CUSTO ');
    qryApuracao.SQL.Add('            FROM LANMES ');
    qryApuracao.SQL.Add('       INNER JOIN CADEMP ON CON_EMPLAN = EMP_CODEMP ');
    qryApuracao.SQL.Add('       LEFT JOIN PLANCO ON NCO_CODCON = CON_CONDEB AND NCO_TPLACO = EMP_TPLACO ');
    qryApuracao.SQL.Add('           WHERE CON_EMPLAN IN (' + fGetInEmpresas(arrEmpSel) + ') AND CON_DTALAN < :DTAINI AND YEAR(CON_DTALAN) = :EXERCI ');

    if not blnApuracaoAposLucroOperacional then
      qryApuracao.SQL.Add(' AND CON_CONDEB LIKE :DIGITO ')
    else
      qryApuracao.SQL.Add(' AND IFNULL(NCO_APURAC,0) = 1 ');

    qryApuracao.SQL.Add('           GROUP BY CON_CONDEB, ' + strCampoCCustoLanMes);

    qryApuracao.SQL.Add('           UNION ALL ');

    // Apuração do período (Crédito)
    qryApuracao.SQL.Add('          SELECT CON_CONCRE AS CONTA, CAST(-SUM(ABS(CON_VALLAN)) AS DECIMAL(12,2)) AS VALOR, ' + strCampoCCustoLanConCred + ' as CENTRO_CUSTO ');
    qryApuracao.SQL.Add('            FROM LANCON ');
    qryApuracao.SQL.Add('       INNER JOIN CADEMP ON CON_EMPLAN = EMP_CODEMP ');
    qryApuracao.SQL.Add('       LEFT JOIN PLANCO ON NCO_CODCON = CON_CONCRE AND NCO_TPLACO = EMP_TPLACO');
    qryApuracao.SQL.Add('           WHERE CON_EMPLAN IN (' + fGetInEmpresas(arrEmpSel) + ') AND CON_DTALAN BETWEEN :DTAINI AND :DTAFIN ');

    if not blnApuracaoAposLucroOperacional then
      qryApuracao.SQL.Add(' AND CON_CONCRE LIKE :DIGITO ')
    else
      qryApuracao.SQL.Add(' AND IFNULL(NCO_APURAC,0) = 1 ');

    qryApuracao.SQL.Add('           GROUP BY CON_CONCRE, ' + strCampoCCustoLanConCred);

    qryApuracao.SQL.Add('           UNION ALL ');

    // Apuração do período (Débito)
    qryApuracao.SQL.Add('          SELECT CON_CONDEB, CAST(SUM(ABS(CON_VALLAN)) AS DECIMAL(12,2)) AS DEBITO, ' + strCampoCCustoLanConDeb + ' as CENTRO_CUSTO ');
    qryApuracao.SQL.Add('            FROM LANCON ');
    qryApuracao.SQL.Add('       INNER JOIN CADEMP ON CON_EMPLAN = EMP_CODEMP ');
    qryApuracao.SQL.Add('       LEFT JOIN PLANCO ON NCO_CODCON = CON_CONDEB AND NCO_TPLACO = EMP_TPLACO ');
    qryApuracao.SQL.Add('           WHERE CON_EMPLAN IN (' + fGetInEmpresas(arrEmpSel) + ') AND CON_DTALAN BETWEEN :DTAINI AND :DTAFIN ');

    if not blnApuracaoAposLucroOperacional then
      qryApuracao.SQL.Add(' AND CON_CONDEB LIKE :DIGITO ')
    else
      qryApuracao.SQL.Add(' AND IFNULL(NCO_APURAC,0) = 1 ');

    qryApuracao.SQL.Add('           GROUP BY CON_CONDEB, ' + strCampoCCustoLanConDeb);
    qryApuracao.SQL.Add('          ) AS TMP_APURACA ');
    qryApuracao.SQL.Add('      GROUP BY CONTA, CENTRO_CUSTO ');
    qryApuracao.ParamByName('EXERCI').AsInteger := fExercicio;
    qryApuracao.ParamByName('DTAINI').AsDate := AdtaIni;
    qryApuracao.ParamByName('DTAFIN').AsDate := AdtaFin;
    if not blnApuracaoAposLucroOperacional then
      qryApuracao.ParamByName('DIGITO').AsString := strDigito+'%';
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
        dados.dtaLancamento := AdtaFin;
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

procedure TfrmFechamentoContabil.btnCheckListClick(Sender: TObject);
var
  LfrmCheckListImportacao : TfrmCheckListImportacao;
begin
  pCriarFormularios(TfrmCheckListImportacao, LfrmCheckListImportacao);
  try
    LfrmCheckListImportacao.TipoCheckList := tclFechamentoContabil ;
    LfrmCheckListImportacao.Caption := 'CheckList Fechamento Contábil' ;
    LfrmCheckListImportacao.ShowModal;
  finally
    pFreeAndNil(LfrmCheckListImportacao);
  end;
end;

procedure TfrmFechamentoContabil.btnGerarClick(Sender: TObject);
  var
    objFormaFec : TFormaFechamentoContabil;
    intCnt : Integer;
    blnErro, blnIgnorarMsg : Boolean;
    sMensagem : string ;
begin
  if not fValidaOpcaoSelecionadaFormaFechamento then
    exit;

  arrEmpSel := fObtemEmpresasFiliais(edtEmpGrv.Text) ;

  if fEmptyStr(fGetInEmpresas(arrEmpSel)) then
    Exit;

  if not fValidaCnpjEmpresasEnvolvidas then
  begin
    fMensagem('ATENÇÃO!', 'Somente podem estar selecionadas juntas, empresas do mesmo CNPJ base - Matriz/Filiais!', ['&OK']);
    exit;
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

  //////carrega as data iniciais de acordo com a forma de fechamento
  pCarregaArrayFecCon(TTipoFechamentoContabil(rdgFormaFechamento.ItemIndex)) ;

  //////valida o fechamento customizado caso tenha
  if not fValidaPeriodoCustomizadoFechamento(sMensagem, EncodeDate(fExercicio, 01, 01), EncodeDate(fExercicio, 12, 31), edtEmpGrv.Text, TTipoFechamentoContabil(rdgFormaFechamento.ItemIndex)) then
  begin
    fMensagem('ATENÇÃO!', sMensagem, ['&Ok']);
    exit ;
  end;

  if fVerificaLancamentosAbertosLote(fExercicio) then
  begin
    exit ;
  end;

  if not fVerificaFechamentoOutrasEmpresasFec(fExercicio) then
  begin
    exit ;
  end;

  if fBloqueiaPorPendenciaContabil then
    Exit;

  if fMensagem('ATENÇÃO!', 'Todas as empresas pertencentes a Raiz do CNPJ serão consolidadas, confirma?', ['&Sim', '&Não'], 1) = 2 then
    Exit;

  if not fExcluirFechamentos(EncodeDate(fExercicio, 01, 01), EncodeDate(fExercicio, 12, 31), edtEmpGrv.Text, False, True, array_of_TRecFecCon, fGetInEmpresas(arrEmpSel)) then
    exit;

  try
    pTravarDigitacaoTela(False);

    objFormaFec := TFormaFechamentoContabil.Create(fExercicio, TTipoFechamentoContabil(rdgFormaFechamento.ItemIndex));
    try
      blnErro := False;
      blnIgnorarMsg := False;

      for intCnt := 0 to Pred(objFormaFec.Iteracoes) do
      begin
        dtaDtaIni := objFormaFec.DataInicial(intCnt);
        dtaDtaFin := objFormaFec.DataFinal(intCnt);

        //verifica apenas o último dia do fechamento (data que grava os LANCON FEC)
        if TVerificaFechamentoDiaMes.fTemFechamento(dtaDtaFin, dtaDtaFin, edtEmpGrv.Text, False) then
        begin
          blnIgnorarMsg := True;
          break;
        end;

        if not fChamaTelaGravando(fGerar) then
        begin
          blnErro := True;
          break;
        end;
      end;

      if not blnIgnorarMsg then
      begin
        if (not blnErro) then
          fMensagem('ATENÇÃO!', 'Fechamento concluído com sucesso!', ['&OK'])
        else
          fMensagem('ATENÇÃO!', 'Erro ao efetuar o fechamento' + sLineBreak + strUltimoErro, ['&OK']);
      end;
    finally
      FreeAndNil(objFormaFec);
    end;
  finally
    pTravarDigitacaoTela(True);
  end;

  pSetFocus(mskExercicio);
end;

procedure TfrmFechamentoContabil.edtEmpGrvKeyPress(Sender: TObject;
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

function TfrmFechamentoContabil.fExercicio: integer;
begin
  Result := StrToInt(mskExercicio.Text);
end;

function TfrmFechamentoContabil.fDiferencaDiasPeriodo(const AAno: integer; const ATipoFechamento: TTipoFechamentoContabil; const AComparacao: TTipoComparacao):integer;
var
  intIncrem: integer ;
  dtInicio: TDateTime ;
  dtFinal: TDateTime ;
  intCnt: integer ;
  lstDifPeriodos: TList<integer> ;
  intDiferenca: integer ;
begin
  lstDifPeriodos := TList<integer>.Create ;
  try
    intIncrem := 0 ;
    dtInicio := EncodeDate(AAno, 1, 1) ;
    if ATipoFechamento = tfcTrimestral then
    begin
      intIncrem := 3 ;
    end
    else if ATipoFechamento = tfcMensal then
    begin
      intIncrem := 1 ;
    end ;
    intCnt := 0 ;
    while intCnt < 12 do
    begin
      intCnt := intCnt + intIncrem ;
      dtFinal := EndOfAMonth(AAno, intCnt) ;
      lstDifPeriodos.Add(DaysBetween(dtFinal, dtInicio)) ;
      dtInicio := IncDay(dtFinal) ;
    end;
    if AComparacao = tcMaior then
    begin
      result := -1 ;
      for intDiferenca in lstDifPeriodos do
      begin
        if intDiferenca > result then
        begin
          result := intDiferenca ;
        end;
      end;
    end
    else ///menor
    begin
      result := 10000 ;
      for intDiferenca in lstDifPeriodos do
      begin
        if intDiferenca < result then
        begin
          result := intDiferenca ;
        end;
      end;
    end;
  finally
    FreeAndNil(lstDifPeriodos) ;
  end;
end;

function TfrmFechamentoContabil.fGerar(pgbProgresso: TcxProgressBar): Boolean;
var
  LintPeriodo: Integer ;
  LintMesInicio : Integer ;
  LintMesFinal  : Integer ;
  LintAno: Integer ;
  LdtaIni, LdtaFin: TDateTime ;
  LstrMsgErro: String ;
begin
  Result := True;
  if not fPeriodoSelecionado then
    Exit ;

  FGravacaoEmLote.fStartTransaction;
  try
    strUltimoErro := '';
    pGravarFecCon;
    pApuracao(fCfgDigrec, pgbProgresso, 'Receita');
    pApuracao(fCfgDigdes, pgbProgresso, 'Despesa');
    pApuracao(fCfgDigcus, pgbProgresso, 'Custo');
    pApuracao('', pgbProgresso, 'Apuração após lucro operacional', True);
    pLucroPrejuizo(pgbProgresso);

    ///faz o processamento mensal
    LintMesInicio := MonthOf(dtaDtaIni) ;
    LintMesFinal := MonthOf(dtaDtaFin) ;
    LintAno := YearOf(dtaDtaIni) ;
    for LintPeriodo := LintMesInicio to LintMesFinal do
    begin
      LdtaIni := EncodeDate(LintAno, LintPeriodo, 1) ;
      LdtaFin :=  DateOf(EndOfTheMonth(LdtaIni)) ;

      pDeletaLanMes(LdtaIni);
      pDeletaPlaMes(LdtaIni);
      pApuracaoMensal(fCfgDigrec, pgbProgresso, 'Receita', LdtaIni, LdtaFin);
      pApuracaoMensal(fCfgDigdes, pgbProgresso, 'Despesa', LdtaIni, LdtaFin);
      pApuracaoMensal(fCfgDigcus, pgbProgresso, 'Custo', LdtaIni, LdtaFin);
      pApuracaoMensal(fCfgSis('DIGATI'), pgbProgresso, 'Ativo', LdtaIni, LdtaFin);
      pApuracaoMensal(fCfgSis('DIGPAS'), pgbProgresso, 'Passivo', LdtaIni, LdtaFin);
      pApuracaoMensal('', pgbProgresso, 'Apuração após lucro operacional', LdtaIni, LdtaFin, True);
      pLucroPrejuizoMensal(pgbProgresso, LdtaIni, LdtaFin);
      pDeletaBalanceteMensal(LdtaFin);
      pDeletaFecMes(LdtaFin);
      pDeletaPlaIniProximoExercicio(LdtaFin);
      pGravaBalanceteMensal(pgbProgresso, LdtaIni, LdtaFin);
      pAtualizarSaldoInicialDoAnoSeguinteSubContas(pgbProgresso, LdtaFin) ;
      pGravaFecMes(LdtaFin) ;

      if not TOutrosFechamentos.fGravaFechamento(arrEmpSel, LdtaFin, LstrMsgErro) then
        raise Exception.Create('Problemas ao gravar ' + LstrMsgErro);

    end ;

    FGravacaoEmLote.fCommit;
  except
    On E: Exception do
    begin
      FGravacaoEmLote.fRollBack;
      strUltimoErro := E.Message;
      Result := False;
    end;
  end;
end;

procedure TfrmFechamentoContabil.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(mskExercicio);
end;

procedure TfrmFechamentoContabil.FormCreate(Sender: TObject);
begin
  inherited;
  FblnTabelaDPRDETExiste := fTabelaExiste('DPRDET') ;
  FblnTabelaLANDETExiste := fTabelaExiste('LANDET') ;
  FblnTabelaPLADETExiste := fTabelaExiste('PLADET') ;
  FblnTabelaEPREGTexiste := fTabelaExiste('EPREGT') ;
  FCON_ANOLANExiste := fCampoExiste('LANCON', 'CON_ANOLAN') ;
  if not FblnTabelaEPREGTexiste then
  begin
    rdgFormaFechamento.Enabled := True ;
    rdgFormaFechamento.ItemIndex := 0 ;
    pCriaPeriodoCustomizadoFechamento(TTipoFechamentoContabil(rdgFormaFechamento.ItemIndex)) ;
  end ;
  intTamanhoLote := fCfgSis('LOTCON', varInteger);

  edtEmpGrv.Text := VS_strCodEmp;
  edtNomEmpGrv.Text := fRetNomeEmpresaSelec(VS_strCodEmp);

  qryConDetails := fCriaQuery;
  FGravacaoEmLote := TGravacaoEmLote.Create(Nil, qryConDetails.Connection.Database,
    qryConDetails.Connection.Username, qryConDetails.Connection.Password,
    IntToStr(qryConDetails.Connection.Port), qryConDetails.Connection.Server);
end;

procedure TfrmFechamentoContabil.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FGravacaoEmLote);
  FreeAndNil(qryConDetails);
  inherited;
end;

function TfrmFechamentoContabil.fPeriodoSelecionado: Boolean;
var
  LauxRecCon : TRecFecCon ;
begin
  Result := False ;

  if fProcuraPeriodoFechamentoPelaData(dtaDtaIni, array_of_TRecFecCon, LauxRecCon) then
    if not LauxRecCon.Selecionado then
      exit ;

  Result := True ;
end;

function TfrmFechamentoContabil.fStrChaveDprIni(const AConta, ATipFC,
  AForCli: string): string;
begin
  Result := AConta + '|' + ATipFC + '|' + AForCli ;
end;

function TfrmFechamentoContabil.fTrataFiltroCampoDataLancon: String;
begin
  Result := 'YEAR(CON_DTALAN)' ;
  if FCON_ANOLANExiste then
    Result := 'CON_ANOLAN' ;
end;

function TfrmFechamentoContabil.fTrataMensagemCustomizadoFechamento(
  const ATipoFechamento: TTipoFechamentoContabil; i: Integer): string;
var
  msgEspecifica : string ;
begin
  if ATipoFechamento = tfcMensal then
  begin
    msgEspecifica := 'mês '+fRetMes(monthOf(array_of_TRecFecCon[i].FecIni)) ;
  end
  else ////trimestral
  begin
    msgEspecifica := inttostr(i+1)+'º Trimestre' ;
  end;
  result := msgEspecifica ;
end;

function TfrmFechamentoContabil.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (mskExercicio.Visible) and (Sender = mskExercicio) Then
    Begin
      If fEmptyStr(fTiraCaracEspeciais(mskExercicio.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'O exercício deve ser preenchido!', ['&OK']);
        pLimpaOpcoesFormaFechamento ;
        Result := False;
      End
      else if (Length(mskExercicio.Text) <> 4) then
      begin
        fMensagem('ATENÇÃO!', 'Exercício inválido!', ['&OK']);
        pLimpaOpcoesFormaFechamento ;
        Result := False;
      end
      else if (StrToIntDef(mskExercicio.Text, 0) = 0) then
      begin
        fMensagem('ATENÇÃO!', 'Exercício inválido!', ['&OK']);
        pLimpaOpcoesFormaFechamento ;
        Result := False;
      end
      else
      begin
        if Not fEmptyStr(edtEmpGrv.Text) then
          pConfiguraFormaFechamento(edtEmpGrv.Text, StrToIntDef(mskExercicio.Text, 0), blnBuscaPorChave) ;
      end ;
    End
    Else If (Sender = edtEmpGrv) Then
    Begin
      If (Not fEmptyStr(edtEmpGrv.Text)) Then
      Begin
        edtNomEmpGrv.Text := fCampoTabela('EMP_NOMEMP', 'CADEMP', ['EMP_CODEMP'], [edtEmpGrv.Text], False);
        If (fEmptyStr(edtNomEmpGrv.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa empresa não está cadastrada!', ['&Ok']);
          pLimpaOpcoesFormaFechamento ;
          Result := False;
        End
        else
        begin
          if Not fEmptyStr(mskExercicio.Text) then
            pConfiguraFormaFechamento(edtEmpGrv.Text, StrToIntDef(mskExercicio.Text, 0), blnBuscaPorChave) ;
        end ;
      End
      Else
      begin
        edtNomEmpGrv.Clear;
        fMensagem('ATENÇÃO!', 'Empresa de gravação deve ser preenchida!', ['&Ok']);
        pLimpaOpcoesFormaFechamento ;
        Result := False;
      end;
    End;

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

function TfrmFechamentoContabil.fValidaCnpjEmpresasEnvolvidas: boolean;
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

function TfrmFechamentoContabil.fValidaOpcaoSelecionadaFormaFechamento: Boolean;
begin
  Result := False ;

  if rdgFormaFechamento.ItemIndex < 0 then
  begin
    fMensagem('ATENÇÃO!', '"Efetuar o Fechamento de Forma" deve estar selecionado!', ['&OK']);
    pSetFocus(mskExercicio) ;
    exit ;
  end ;

  if not fVerificaCampos then
    exit;

  Result := True ;
end;

function TfrmFechamentoContabil.fValidaPeriodoCustomizadoFechamento(var AMensagem: string; dtaDtaIni, dtaDtaFin: TDate; strCodEmp: string; ATipoFechamento: TTipoFechamentoContabil): boolean;
var
  i, iOcorr : integer ;
  flagIniAnalise, flagDesmarcado, flagPeriodo : boolean ;
  qryDados : TUniQuery;
  LqryTodosExercicios: TUniquery;
  LblnPeloMenosUmSelecionado: Boolean ;
begin
  AMensagem := '' ;
  Result := False ;

  ///////verifica se há lacunas
  flagIniAnalise := False ;
  flagDesmarcado := False ;
  iOcorr := 0 ;
  LblnPeloMenosUmSelecionado := False ;
  for i := 0 to pred(chkGrpPeriodoFechamento.Properties.Items.Count) do
  begin
    if chkGrpPeriodoFechamento.States[I] = cbsChecked then
      LblnPeloMenosUmSelecionado := True ;

    if (chkGrpPeriodoFechamento.States[I] = cbsChecked) and (not flagIniAnalise) then
    begin
      flagIniAnalise := True ;
    end
    else if (chkGrpPeriodoFechamento.States[I] = cbsChecked) and (flagIniAnalise) then
    begin
      if flagDesmarcado then
        iOcorr := iOcorr + 1 ;
    end
    else if (chkGrpPeriodoFechamento.States[I] <> cbsChecked) and (flagIniAnalise) then
    begin
      flagDesmarcado := True ;
    end;
  end;

  if not LblnPeloMenosUmSelecionado then
  begin
    AMensagem := 'Nenhum período selecionado!' ;
    exit ;
  end ;

  if iOcorr > 0 then
  begin
    AMensagem := 'Não pode haver lacuna no período selecionado!' ;
    exit ;
  end;

  //////verifica se o fechamento anterior é o mesmo do fechamento customizado atual.
  qryDados := fCriaQuery;
  LqryTodosExercicios := fCriaQuery ;
  try
    qryDados.Close;
    qryDados.SQL.Clear;
    qryDados.SQL.Add(' SELECT *, DATEDIFF(CON_FECFIN, CON_FECINI) AS CON_DIFF_DATAS ');
    qryDados.SQL.Add('   FROM FECCON ');
    qryDados.SQL.Add('  WHERE CON_CODEMP = :CODEMP ');
    qryDados.SQL.Add('    AND ((CON_FECINI BETWEEN :DTAINI AND :DTAFIN) OR ');
    qryDados.SQL.Add('         (CON_FECFIN BETWEEN :DTAINI AND :DTAFIN)) ');
    qryDados.SQL.Add('    ORDER BY CON_FECINI ');
    qryDados.ParamByName('DTAINI').AsDate := dtaDtaIni;
    qryDados.ParamByName('DTAFIN').AsDate := dtaDtaFin;
    qryDados.ParamByName('CODEMP').AsString := strCodEmp;
    qryDados.Open;

    if not qryDados.IsEmpty then
    begin
      ///verifica somente se for diferente de anual
      if qryDados.FieldByName('CON_DIFF_DATAS').AsInteger < 360 then
      begin

        ////verifica se a forma de fechamento é a mesma forma do fechamento customizado.
        if ATipoFechamento = tfcMensal then
        begin
          if qryDados.FieldByName('CON_DIFF_DATAS').AsInteger > fDiferencaDiasPeriodo(YearOf(dtaDtaIni), ATipoFechamento, tcMaior) then
          begin
            AMensagem := 'Fechamento customizado permitido apenas para a forma Trimestral!' ;
            exit ;
          end;
        end
        else if ATipoFechamento = tfcTrimestral then
        begin
          if qryDados.FieldByName('CON_DIFF_DATAS').AsInteger < fDiferencaDiasPeriodo(YearOf(dtaDtaIni), ATipoFechamento, tcMenor) then
          begin
            AMensagem := 'Fechamento customizado permitido apenas para a forma Mensal!' ;
            exit ;
          end;
        end;

      end;
    end;

    //busca todos fechamentos para verificação anterior/posterior ao exercício
    LqryTodosExercicios.Close;
    LqryTodosExercicios.SQL.Clear;
    LqryTodosExercicios.SQL.Add(' SELECT CON_FECINI, CON_FECFIN ');
    LqryTodosExercicios.SQL.Add('   FROM FECCON ');
    LqryTodosExercicios.SQL.Add('  WHERE CON_CODEMP = :CODEMP ');
    LqryTodosExercicios.ParamByName('CODEMP').AsString := strCodEmp;
    LqryTodosExercicios.Open;

    //////verifica se o periodo inicial já está no banco de dados para a verificação.
    flagPeriodo := False ;
    for i := 0 to pred(chkGrpPeriodoFechamento.Properties.Items.Count) do
    begin

      if not fVerificaFechamentoAnteriorPosterior(LqryTodosExercicios, i, AMensagem) then
        Exit ;

      if chkGrpPeriodoFechamento.States[i] = cbsChecked then
      begin
        flagPeriodo := True ;
      end;

      ////deve ter fechamento, antes do periodo selecionado
      if (chkGrpPeriodoFechamento.States[i] = cbsUnChecked) and (not flagPeriodo) then
      begin
        if not qryDados.Locate('CON_FECINI', array_of_TRecFecCon[i].FecIni, [loCaseInsensitive] ) then
        begin
          AMensagem := 'Fechamento do '+fTrataMensagemCustomizadoFechamento(ATipoFechamento, i)+' não encontrado!' ;
          exit ;
        end
        else
        begin
          if qryDados.FieldByName('CON_FECFIN').AsDateTime <> array_of_TRecFecCon[i].FecFin then
          begin
            AMensagem := 'Fechamento do '+fTrataMensagemCustomizadoFechamento(ATipoFechamento, i)+' não encontrado!' ;
            exit ;
          end ;
        end ;
      end;

      ////não pode ter fechamento, depois do periodo selecionado
      if (chkGrpPeriodoFechamento.States[i] = cbsUnChecked) and (flagPeriodo) then
      begin
        if qryDados.Locate('CON_FECINI', array_of_TRecFecCon[i].FecIni, [loCaseInsensitive] ) then
        begin
          AMensagem := 'Fechamento do '+fTrataMensagemCustomizadoFechamento(ATipoFechamento, i)+' encontrado!'+#13+'Faça a exclusão no módulo Manutenção Lançamentos Contábeis -> Exclusão Lote' ;
          exit ;
        end;
      end;

    end;

  finally
    FreeAndNil(qryDados);
    FreeAndNil(LqryTodosExercicios);
  end;
  //////
  result := True ;
end;

function TfrmFechamentoContabil.fVerificaFechamentoAnteriorPosterior(
  AqryTodosExercicios: TUniQuery; AintIndex: Integer; var AstrMensagem: String): Boolean;
var
  LdtaAnterior: TDateTime;
  LdtaPosterior: TDateTime;
  LintIndex: Integer;
  LintUltimoIndex: Integer;
begin
  Result := True ;
  LintIndex := AintIndex ;
  LintUltimoIndex := pred(chkGrpPeriodoFechamento.Properties.Items.Count) ;

  //se anual
  if Length(array_of_TRecFecCon) = 1 then
  begin
    LintIndex := 0 ;
    LintUltimoIndex := 0 ;
  end ;

  ///verifica se há periodo processado imediamente anterior
  if LintIndex = 0 then
  begin
    AqryTodosExercicios.Filter := 'CON_FECINI < '+ QuotedStr(DateToStr(array_of_TRecFecCon[LintIndex].FecIni)) ;
    try
      AqryTodosExercicios.Filtered := True ;
      if not AqryTodosExercicios.IsEmpty then
      begin
        LdtaAnterior :=  IncDay(array_of_TRecFecCon[LintIndex].FecIni, -1) ;
        if not AqryTodosExercicios.Locate('CON_FECFIN', LdtaAnterior, [loCaseInsensitive]) then
        begin
          AstrMensagem := 'Fechamento anterior a '+DateToStr(array_of_TRecFecCon[LintIndex].FecIni)+' não encontrado!' ;
          Exit(False) ;
        end ;
      end ;
    finally
      AqryTodosExercicios.Filtered := False ;
    end ;
  end ;

  ///verifica se há periodo processado imediamente posterior
  if LintIndex = LintUltimoIndex then
  begin
    AqryTodosExercicios.Filter := 'CON_FECINI > '+ QuotedStr(DateToStr(array_of_TRecFecCon[LintIndex].FecFin)) ;
    try
      AqryTodosExercicios.Filtered := True ;
      if not AqryTodosExercicios.IsEmpty then
      begin
        LdtaPosterior :=  IncDay(array_of_TRecFecCon[LintIndex].FecFin, 1) ;
        if AqryTodosExercicios.Locate('CON_FECINI', LdtaPosterior, [loCaseInsensitive]) then
        begin
          AstrMensagem := 'Fechamento posterior a '+DateToStr(array_of_TRecFecCon[LintIndex].FecFin)+' encontrado!'+#13+'Faça a exclusão no módulo Manutenção Lançamentos Contábeis -> Exclusão Lote' ;
          Exit(False) ;
        end ;
      end ;
    finally
      AqryTodosExercicios.Filtered := False ;
    end ;
  end ;

end;

function TfrmFechamentoContabil.fVerificaFechamentoOutrasEmpresasFec(
  const AExercicio: integer): boolean;
var
  qryVer: TUniQuery ;
  strMensagem: string ;
  LintNumeroLinhas: integer ;
begin
  result := True ;
  qryVer := fCriaQuery;
  try
    qryVer.Close ;
    qryVer.SQL.Clear ;
    qryVer.SQL.Add(' SELECT DISTINCT CON_EMPLAN, CADEMP.EMP_NOMEMP ') ;
    qryVer.SQL.Add('  FROM LANCON INNER JOIN CADEMP ON CADEMP.EMP_CODEMP = LANCON.CON_EMPLAN ') ;
    qryVer.SQL.Add('  WHERE CON_EMPLAN <> :CODEMP ') ;
    qryVer.SQL.Add('        AND CON_EMPLAN IN (' + fGetInEmpresas(arrEmpSel) + ') ') ;
    qryVer.SQL.Add('        AND EXTRACT(YEAR FROM CON_DTALAN) = :EXERCI ') ;
    qryVer.SQL.Add('        AND CON_TIPLAN = "FEC" ') ;
    qryVer.ParamByName('EXERCI').AsInteger := AExercicio ;
    qryVer.ParamByName('CODEMP').AsString := edtEmpGrv.Text;
    qryVer.Open ;
    if not qryVer.IsEmpty then
    begin
      strMensagem := '' ;
      qryVer.First ;
      LintNumeroLinhas := 2 ;
      while not qryVer.Eof do
      begin
        strMensagem := strMensagem +  qryVer.FieldByName('CON_EMPLAN').AsString + ' - ' + qryVer.FieldByName('EMP_NOMEMP').AsString + #13#10 ;
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

function TfrmFechamentoContabil.fVerificaLancamentosAbertosLote(const AExercicio: integer): boolean;
var
  qryVerifica: TUniQuery ;
  objFormaFec : TFormaFechamentoContabil;
  dtaIni, dtaFin: TDateTime ;
  intCnt: integer ;
  LstrEmpresas: string ;
begin
  Result := True ;
  qryVerifica := fCriaQuery ;
  objFormaFec := TFormaFechamentoContabil.Create(fExercicio, TTipoFechamentoContabil(rdgFormaFechamento.ItemIndex));
  try
    dtaIni := Date ;
    dtaFin := Date ;
    for intCnt := 0 to Pred(objFormaFec.Iteracoes) do
    begin
      if chkGrpPeriodoFechamento.States[intCnt] <> cbsChecked then
        Continue ;

      if intCnt = 0 then
      begin
        dtaIni := objFormaFec.DataInicial(intCnt);
      end;
      dtaFin := objFormaFec.DataFinal(intCnt);
    end;

    LstrEmpresas := fGetInEmpresas(arrEmpSel) + ',' + QuotedStr(edtEmpGrv.Text)  ;

    qryVerifica.SQL.Text := 'SELECT COUNT(*) AS CONTADOR FROM LO2LAN WHERE LAN_DTALAN BETWEEN :DTAINI AND :DTAFIN AND COALESCE(LAN_CODLAN, "") = "" AND LAN_EMPLAN IN ('+ LstrEmpresas +') ' ;
    qryVerifica.ParamByName('DTAINI').AsDate := dtaIni ;
    qryVerifica.ParamByName('DTAFIN').AsDate := dtaFin ;
    qryVerifica.Open ;
    if qryVerifica.FieldByName('CONTADOR').AsInteger <> 0 then
    begin
      if (fMensagem('AVISO', 'Existem lotes contábeis salvos, que ainda não foram gravados, deseja continuar?', ['&Sim', '&Não']) = 2) then
      begin
        Exit;
      end;
    end;
  finally
    FreeAndNil(qryVerifica) ;
    FreeAndNil(objFormaFec) ;
  end;
  Result := False ;
end;

procedure TfrmFechamentoContabil.pApuracao(strDigito: string; pgbProgresso: TcxProgressBar; strTexto: string; blnApuracaoAposLucroOperacional: boolean = false);
var
  qryApuracao : TFDQuery;
  dados : TDadosImportacaoContabil;
  lstDados : TObjectList<TDadosImportacaoContabil>;
  intCount : integer;
  intRecordCount : integer;

  blCfg : boolean ;
  strCampoCCustoPlaIni : string ;
  strCampoCCustoLanConDeb : string ;
  strCampoCCustoLanConCred : string ;
begin
  if fEmptyStr(strDigito) then
  begin
    exit ;
  end;

  pSetaTextoProgresso(pgbProgresso, 'Apurando: ' + strTexto);

  blCfg := fTemCfgFconcc ;
  strCampoCCustoPlaIni := fCampoCCustoPlaIni(blCfg) ;
  strCampoCCustoLanConDeb := fCampoCCustoLanConDeb(blCfg) ;
  strCampoCCustoLanConCred := fCampoCCustoLanConCred(blCfg) ;
  qryApuracao := TFDQuery.Create(Self);
  qryApuracao.Connection := FGravacaoEmLote.getDataBase;
  lstDados := TObjectList<TDadosImportacaoContabil>.Create;
  try
    qryApuracao.Close;
    qryApuracao.SQL.Clear;
    qryApuracao.SQL.Add(' SELECT CONTA, CCUSTO, SUM(VALOR) AS VALOR ');
    qryApuracao.SQL.Add('   FROM ( ');
    // Saldo Inicial
    qryApuracao.SQL.Add('          SELECT INI_CODCON AS CONTA, ' + strCampoCCustoPlaIni + ' AS CCUSTO, ' + fCampoSaldoInicialPlaIni + ' AS VALOR ');
    qryApuracao.SQL.Add('            FROM PLAINI ');
    qryApuracao.SQL.Add('            INNER JOIN CADEMP ON INI_CODEMP = EMP_CODEMP ');
    qryApuracao.SQL.Add('       LEFT JOIN PLANCO ON NCO_CODCON = INI_CODCON AND NCO_TPLACO = EMP_TPLACO ');
    qryApuracao.SQL.Add('           WHERE INI_CODEMP IN (' + fGetInEmpresas(arrEmpSel) + ') AND INI_EXERCI = ":EXERCI" ');

    if not blnApuracaoAposLucroOperacional then
      qryApuracao.SQL.Add(' AND INI_CODCON LIKE :DIGITO ')
    else
      qryApuracao.SQL.Add(' AND IFNULL(NCO_APURAC,0) = 1 ');

    qryApuracao.SQL.Add('           UNION ALL ');
    // Apuração até antes do período (Crédito)
    qryApuracao.SQL.Add('          SELECT CON_CONCRE AS CONTA, ' + strCampoCCustoLanConCred + ' AS CCUSTO, -SUM(ABS(CON_VALLAN)) AS VALOR ');
    qryApuracao.SQL.Add('            FROM LANCON ');
    qryApuracao.SQL.Add('       INNER JOIN CADEMP ON CON_EMPLAN = EMP_CODEMP ');
    qryApuracao.SQL.Add('       LEFT  JOIN PLANCO ON NCO_CODCON = CON_CONCRE AND NCO_TPLACO = EMP_TPLACO ');
    qryApuracao.SQL.Add('           WHERE CON_EMPLAN IN (' + fGetInEmpresas(arrEmpSel) + ') AND CON_DTALAN < :DTAINI AND ' + fTrataFiltroCampoDataLancon + ' = :EXERCI ');

    if not blnApuracaoAposLucroOperacional then
      qryApuracao.SQL.Add(' AND CON_CONCRE LIKE :DIGITO ')
    else
      qryApuracao.SQL.Add(' AND IFNULL(NCO_APURAC,0) = 1 ');

    qryApuracao.SQL.Add('           GROUP BY CON_CONCRE, ' + strCampoCCustoLanConCred);
    qryApuracao.SQL.Add('           UNION ALL ');
    // Apuração até antes do período (Débito)
    qryApuracao.SQL.Add('          SELECT CON_CONDEB AS CONTA, ' + strCampoCCustoLanConDeb + ' AS CCUSTO, SUM(ABS(CON_VALLAN)) AS VALOR ');
    qryApuracao.SQL.Add('            FROM LANCON ');
    qryApuracao.SQL.Add('       INNER JOIN CADEMP ON CON_EMPLAN = EMP_CODEMP ');
    qryApuracao.SQL.Add('       LEFT JOIN PLANCO ON NCO_CODCON = CON_CONDEB AND NCO_TPLACO = EMP_TPLACO ');
    qryApuracao.SQL.Add('           WHERE CON_EMPLAN IN (' + fGetInEmpresas(arrEmpSel) + ') AND CON_DTALAN < :DTAINI AND ' + fTrataFiltroCampoDataLancon + ' = :EXERCI ');

    if not blnApuracaoAposLucroOperacional then
      qryApuracao.SQL.Add(' AND CON_CONDEB LIKE :DIGITO ')
    else
      qryApuracao.SQL.Add(' AND IFNULL(NCO_APURAC,0) = 1 ');

    qryApuracao.SQL.Add('           GROUP BY CON_CONDEB, ' + strCampoCCustoLanConDeb);
    qryApuracao.SQL.Add('           UNION ALL ');
    // Apuração do período (Crédito)
    qryApuracao.SQL.Add('          SELECT CON_CONCRE AS CONTA, ' + strCampoCCustoLanConCred + ' AS CCUSTO, -SUM(ABS(CON_VALLAN)) AS VALOR ');
    qryApuracao.SQL.Add('            FROM LANCON ');
    qryApuracao.SQL.Add('       INNER JOIN CADEMP ON CON_EMPLAN = EMP_CODEMP ');
    qryApuracao.SQL.Add('       LEFT JOIN PLANCO ON NCO_CODCON = CON_CONCRE AND NCO_TPLACO = EMP_TPLACO ');
    qryApuracao.SQL.Add('           WHERE CON_EMPLAN IN (' + fGetInEmpresas(arrEmpSel) + ') AND CON_DTALAN BETWEEN :DTAINI AND :DTAFIN ');

    if not blnApuracaoAposLucroOperacional then
      qryApuracao.SQL.Add(' AND CON_CONCRE LIKE :DIGITO ')
    else
      qryApuracao.SQL.Add(' AND IFNULL(NCO_APURAC,0) = 1 ');

    qryApuracao.SQL.Add('           GROUP BY CON_CONCRE, ' + strCampoCCustoLanConCred);
    qryApuracao.SQL.Add('           UNION ALL ');
    // Apuração do período (Débito)
    qryApuracao.SQL.Add('          SELECT CON_CONDEB, ' + strCampoCCustoLanConDeb + ' AS CCUSTO, SUM(ABS(CON_VALLAN)) DEBITO ');
    qryApuracao.SQL.Add('            FROM LANCON ');
    qryApuracao.SQL.Add('       INNER JOIN CADEMP ON CON_EMPLAN = EMP_CODEMP ');
    qryApuracao.SQL.Add('       LEFT JOIN PLANCO ON NCO_CODCON = CON_CONDEB AND NCO_TPLACO = EMP_TPLACO ');
    qryApuracao.SQL.Add('           WHERE CON_EMPLAN IN (' + fGetInEmpresas(arrEmpSel) + ') AND CON_DTALAN BETWEEN :DTAINI AND :DTAFIN ');

    if not blnApuracaoAposLucroOperacional then
      qryApuracao.SQL.Add(' AND CON_CONDEB LIKE :DIGITO ')
    else
      qryApuracao.SQL.Add(' AND IFNULL(NCO_APURAC,0) = 1 ');

    qryApuracao.SQL.Add('           GROUP BY CON_CONDEB, ' + strCampoCCustoLanConDeb);
    qryApuracao.SQL.Add('          ) AS TMP_APURACA ');
    qryApuracao.SQL.Add('      GROUP BY CONTA, CCUSTO ');
    qryApuracao.SQL.Add('      ORDER BY CONTA, CCUSTO ');
    qryApuracao.ParamByName('EXERCI').AsInteger := fExercicio;
    qryApuracao.ParamByName('DTAINI').AsDate := dtaDtaIni;
    qryApuracao.ParamByName('DTAFIN').AsDate := dtaDtaFin;
    if not blnApuracaoAposLucroOperacional then
      qryApuracao.ParamByName('DIGITO').AsString := strDigito+'%';
    qryApuracao.Open;

    intCount := 0;
    intRecordCount := qryApuracao.RecordCount;
    pgbProgresso.Properties.Max := intRecordCount;

    qryApuracao.First;
    while not qryApuracao.Eof do
    begin
      intCount := intCount + 1;

      pgbProgresso.Position := qryApuracao.RecNo;
      pSetaTextoProgresso(pgbProgresso, 'Apurando: ' + strTexto + ' - ' + IntToStr(intCount) + '/' + IntToStr(intRecordCount));

      if (qryApuracao.FieldByName('VALOR').AsFloat <> 0) then
      begin
        dados := TDadosImportacaoContabil.Create(VC_StrVersaoContabilidade, VS_strCodEmp);
        dados.strCodigoEmpresa := edtEmpGrv.Text;
        dados.dtaLancamento := dtaDtaFin;
        dados.strTipoLancamento := 'FEC';
        dados.intCodigoHistoricoPadrao := -1;
        dados.intAutomatico := 1;
        dados.strCodigoOperador := strLoginUsuarioLogado;
        if qryApuracao.FieldByName('VALOR').AsFloat > 0 then
        begin
          dados.strContaCredito := qryApuracao.FieldByName('CONTA').AsString;
          dados.strContaDebito := fCfgSis('CONRES');
          dados.strCCustoCredito := qryApuracao.FieldByName('CCUSTO').AsString;
        end
        else
        begin
          dados.strContaDebito := qryApuracao.FieldByName('CONTA').AsString;
          dados.strContaCredito := fCfgSis('CONRES');
          dados.strCCusto := qryApuracao.FieldByName('CCUSTO').AsString;
        end;

        dados.fltValorLancamento := Abs(qryApuracao.FieldByName('VALOR').AsFloat);
        dados.strHistorico := HISTORICO_APURACAO;
        dados.strCtpInc := fGerarIncDocLanConManual ;
        lstDados.Add(dados);
      end;

      qryApuracao.Next;

      if ((qryApuracao.Eof) or (intCount >= intTamanhoLote)) then
      begin
        intCount := 0;
        FGravacaoEmLote.pGravar(lstDados);
        lstDados.Clear;
      end;
    end;

    pgbProgresso.Position := 0;

    if lstDados.Count > 0 then
      FGravacaoEmLote.pGravar(lstDados);
  finally
    FreeAndNil(qryApuracao);
    FreeAndNil(lstDados);
  end;
end;

function TfrmFechamentoContabil.fBloqueiaPorPendenciaContabil: Boolean;
var
  LarrEmp: TArray<string>;
  LdtaFin: TDateTime;
  LintCnt: Integer;
  LcdsPendencias: TUniClientDataSet;
begin
  Result := False;

  // Pendencia ate o fim do ultimo periodo marcado bloqueia o fechamento (Req. 470760).
  LdtaFin := 0;
  for LintCnt := 0 to High(array_of_TRecFecCon) do
    if (array_of_TRecFecCon[LintCnt].Selecionado) and (array_of_TRecFecCon[LintCnt].FecFin > LdtaFin) then
      LdtaFin := array_of_TRecFecCon[LintCnt].FecFin;

  if LdtaFin = 0 then
    LdtaFin := EncodeDate(fExercicio, 12, 31);

  SetLength(LarrEmp, Length(arrEmpSel));
  for LintCnt := 0 to High(arrEmpSel) do
    LarrEmp[LintCnt] := arrEmpSel[LintCnt].strCodigo;

  if not TPendenciaContabil.fExiste(LarrEmp, LdtaFin) then
    Exit;

  Result := True;

  if fMensagem('ATENÇÃO!', 'Existem lançamentos com erros, que devem ser corrigidos e gerados para que o Fechamento Contábil seja realizado. ' +
                           'Deseja visualizar os lançamentos pendentes de correção?', ['&Sim', '&Não'], 1) = 2 then
    Exit;

  LcdsPendencias := TPendenciaContabil.fListar(LarrEmp, nil, 0, LdtaFin);
  try
    TfrmErrosContabil.pExibir(LcdsPendencias);
  finally
    FreeAndNil(LcdsPendencias);
  end;
end;

procedure TfrmFechamentoContabil.pCarregaArrayFecCon(
  const ATipoFechamento: TTipoFechamentoContabil);
var
  iMes : integer ;
  LDataInicial : TDateTime ;
begin
  SetLength(array_of_TRecFecCon, 0);
  if ATipoFechamento = tfcMensal then
  begin
    SetLength(array_of_TRecFecCon, 12);
    for iMes := 1 to 12 do
    begin
      LDataInicial := EncodeDate(FExercicio, iMes, 01);
      array_of_TRecFecCon[pred(iMes)].FecIni := LDataInicial ;
      array_of_TRecFecCon[pred(iMes)].FecFin := EncodeDate(FExercicio, iMes, DayOf(EndOfTheMonth(LDataInicial)));
      array_of_TRecFecCon[pred(iMes)].Selecionado := chkGrpPeriodoFechamento.States[pred(iMes)] = cbsChecked ;
    end;
  end
  else if ATipoFechamento = tfcTrimestral then
  begin
    SetLength(array_of_TRecFecCon, 4);
    array_of_TRecFecCon[0].FecIni := EncodeDate(fExercicio, 01, 01) ;
    array_of_TRecFecCon[0].FecFin := EncodeDate(fExercicio, 03, 31) ;
    array_of_TRecFecCon[0].Selecionado := chkGrpPeriodoFechamento.States[0] = cbsChecked ;

    array_of_TRecFecCon[1].FecIni := EncodeDate(fExercicio, 04, 01) ;
    array_of_TRecFecCon[1].FecFin := EncodeDate(fExercicio, 06, 30) ;
    array_of_TRecFecCon[1].Selecionado := chkGrpPeriodoFechamento.States[1] = cbsChecked ;

    array_of_TRecFecCon[2].FecIni := EncodeDate(fExercicio, 07, 01) ;
    array_of_TRecFecCon[2].FecFin := EncodeDate(fExercicio, 09, 30) ;
    array_of_TRecFecCon[2].Selecionado := chkGrpPeriodoFechamento.States[2] = cbsChecked ;

    array_of_TRecFecCon[3].FecIni := EncodeDate(fExercicio, 10, 01) ;
    array_of_TRecFecCon[3].FecFin := EncodeDate(fExercicio, 12, 31) ;
    array_of_TRecFecCon[3].Selecionado := chkGrpPeriodoFechamento.States[3] = cbsChecked ;
  end
  else if ATipoFechamento = tfcAnual then
  begin
    SetLength(array_of_TRecFecCon, 1);
    array_of_TRecFecCon[0].FecIni := EncodeDate(fExercicio, 01, 01) ;
    array_of_TRecFecCon[0].FecFin := EncodeDate(fExercicio, 12, 31) ;
    array_of_TRecFecCon[0].Selecionado := True ;
  end;
end;

procedure TfrmFechamentoContabil.pConfiguraFormaFechamento(const AstrCodEmp: String; const AintExercicio: Integer; const AblnBuscaPorChave: Boolean);
var
  LqryCnf: TUniQuery ;
  LintFormtr: Integer ;
  LstrEncerr: String ;
begin
  if not FblnTabelaEPREGTexiste then
    Exit ;

  LqryCnf := fCriaQuery() ;
  try
    LqryCnf.Close ;
    LqryCnf.SQL.Clear ;
    LqryCnf.SQL.Add(' SELECT TRI_FORMTR, TRI_ENCERR ') ;
    LqryCnf.SQL.Add(' FROM EPREGT ') ;
    LqryCnf.SQL.Add(' WHERE TRI_ANOEXE = :ANOEXE ') ;
    LqryCnf.SQL.Add('       AND TRI_CODEMP = :CODEMP ; ') ;
    LqryCnf.ParamByName('ANOEXE').AsInteger := AintExercicio ;
    LqryCnf.ParamByName('CODEMP').AsString := AstrCodEmp ;
    LqryCnf.Open ;

    if AblnBuscaPorChave then
      pLimpaOpcoesFormaFechamento ;

    if LqryCnf.IsEmpty then
    begin
      fMensagem('ATENÇÃO!', 'O Fechamento Contábil deverá ser realizado somente pela Empresa MATRIZ.' + #13+#10 + #13+#10 +
                            'Não há Parâmetros da "Forma de Tributação" para essa Empresa/Exercício.' + #13+#10 +
                            'Certifique-se que a Empresa é uma "Matriz", e efetue o preenchimento ' +
                            ' da "Forma  de  Tributação"  para  o  Exercício no  caminho ' + #13+#10 +
                            '"Principal > Manutenção de Cadastros >  Auxiliares >  Empresas" ' + #13+#10 +
                            ' na Aba "Contabilidade"', ['&OK'], 1, False, 1, 0, False, 0, False, False, False, 0, 0, 3);
      exit ;
    end
    else
    begin
      if AblnBuscaPorChave then
      begin
        LintFormtr := LqryCnf.FieldByName('TRI_FORMTR').AsInteger ;
        LstrEncerr :=  LqryCnf.FieldByName('TRI_ENCERR').AsString ;
        case LintFormtr of
          1, 2: rdgFormaFechamento.ItemIndex := 1 ;
          3   :
               begin
                 if LstrEncerr = 'A' then
                   rdgFormaFechamento.ItemIndex := 0
                 else
                   rdgFormaFechamento.ItemIndex := 2 ;
               end ;
          4   :
               begin
                 if LstrEncerr = 'A' then
                   rdgFormaFechamento.ItemIndex := 2
                 else if LstrEncerr = 'M' then
                   rdgFormaFechamento.ItemIndex := 0
                 else // T
                   rdgFormaFechamento.ItemIndex := 1 ;
               end ;
        end ;
        pCriaPeriodoCustomizadoFechamento(TTipoFechamentoContabil(rdgFormaFechamento.ItemIndex)) ;
      end ;
    end ;

  finally
    FreeAndNil(LqryCnf) ;
  end ;
end;

procedure TfrmFechamentoContabil.pCriaPeriodoCustomizadoFechamento(
  const ATipoFechamento: TTipoFechamentoContabil);
var
  auxItem : TcxCheckGroupItem ;
  iMes, i : integer ;
begin
  chkGrpPeriodoFechamento.Properties.Items.BeginUpdate ;
  try
    ///limpar
    chkGrpPeriodoFechamento.Properties.Items.Clear ;
    if ATipoFechamento in [tfcMensal, tfcAnual] then
    begin
      chkGrpPeriodoFechamento.Properties.Columns := 3 ;
      for iMes := 1 to 12 do
      begin
        auxItem := chkGrpPeriodoFechamento.Properties.Items.Add ;
        auxItem.Caption := fRetMes(iMes) ;
        auxItem.Enabled := ATipoFechamento <> tfcAnual ;
      end;
    end
    else if ATipoFechamento = tfcTrimestral then
    begin
      chkGrpPeriodoFechamento.Properties.Columns := 2 ;

      auxItem := chkGrpPeriodoFechamento.Properties.Items.Add ;
      auxItem.Caption := '1º Trimestre' ;

      auxItem := chkGrpPeriodoFechamento.Properties.Items.Add ;
      auxItem.Caption := '2º Trimestre' ;

      auxItem := chkGrpPeriodoFechamento.Properties.Items.Add ;
      auxItem.Caption := '3º Trimestre' ;

      auxItem := chkGrpPeriodoFechamento.Properties.Items.Add ;
      auxItem.Caption := '4º Trimestre' ;

    end;
    /////seleciona todos os itens
    for I := 0 to pred(chkGrpPeriodoFechamento.Properties.Items.Count) do
    begin
      if chkGrpPeriodoFechamento.Properties.Items.Items[I].Enabled then
        chkGrpPeriodoFechamento.States[I] := cbsUnchecked
      else
        chkGrpPeriodoFechamento.States[I] := cbsChecked  ;
    end;
    ///
  finally
    chkGrpPeriodoFechamento.Properties.Items.EndUpdate ;
  end;
end;

procedure TfrmFechamentoContabil.pLimpaOpcoesFormaFechamento;
begin
  rdgFormaFechamento.ItemIndex := -1 ;
  chkGrpPeriodoFechamento.Properties.Items.Clear ;
end;

procedure TfrmFechamentoContabil.pLucroPrejuizo(pgbProgresso: TcxProgressBar);
  var
    qryLucroPrejuizo : TFDQuery;
    dados : TDadosImportacaoContabil;
    lstDados : TObjectList<TDadosImportacaoContabil>;
    fltResultado : Double ;
begin

  pSetaTextoProgresso(pgbProgresso, 'Apurando: Lucro/Prejuizo');
  qryLucroPrejuizo := TFDQuery.Create(Self);
  qryLucroPrejuizo.Connection := FGravacaoEmLote.getDataBase;
  lstDados := TObjectList<TDadosImportacaoContabil>.Create;
  try
    qryLucroPrejuizo.Close;
    qryLucroPrejuizo.SQL.Clear;
    qryLucroPrejuizo.SQL.Add(' SELECT SUM(IF(IFNULL(CON_CONDEB,"") = :CODCON, CON_VALLAN, 0)) - ');
    qryLucroPrejuizo.SQL.Add('        SUM(IF(IFNULL(CON_CONCRE,"") = :CODCON, CON_VALLAN, 0)) VALOR ');
    qryLucroPrejuizo.SQL.Add('   FROM LANCON ');
    qryLucroPrejuizo.SQL.Add('  WHERE CON_DTALAN = :DTALAN ');
    qryLucroPrejuizo.SQL.Add('    AND CON_TIPLAN = "FEC" ');
    qryLucroPrejuizo.SQL.Add('    AND CON_EMPLAN = :CODEMP ');
    qryLucroPrejuizo.SQL.Add('    AND ((IFNULL(CON_CONCRE,"") = :CODCON) OR (IFNULL(CON_CONDEB,"") = :CODCON)) ');
    qryLucroPrejuizo.ParamByName('DTALAN').AsDate := dtaDtaFin;
    qryLucroPrejuizo.ParamByName('CODCON').AsString := fCfgSis('CONRES');
    qryLucroPrejuizo.ParamByName('CODEMP').AsString := edtEmpGrv.Text;
    qryLucroPrejuizo.Open;

    ///lança o resultado do exercicio
    fltResultado := qryLucroPrejuizo.FieldByName('VALOR').AsFloat ;
    if fltResultado <> 0.00 then
    begin
      dados := TDadosImportacaoContabil.Create(VC_StrVersaoContabilidade, VS_strCodEmp);
      if (fFormataFloat(fltResultado, 2) > 0) then
      begin
        dados.strContaDebito := fCfgSis('CONPRE');
        dados.strContaCredito := fCfgSis('CONRES');
      end
      else
      begin
        dados.strContaDebito := fCfgSis('CONRES');
        dados.strContaCredito := fCfgSis('CONLUC');
      end;
      dados.strCodigoEmpresa := edtEmpGrv.Text;
      dados.dtaLancamento := dtaDtaFin;
      dados.strTipoLancamento := 'FEC';
      dados.intCodigoHistoricoPadrao := -1;
      dados.intAutomatico := 1;
      dados.strCodigoOperador := strLoginUsuarioLogado;
      dados.fltValorLancamento := Abs(fltResultado);
      dados.strHistorico := HISTORICO_APURACAO;
      dados.strCtpInc := fGerarIncDocLanConManual ;
      lstDados.Add(dados);
      FGravacaoEmLote.pGravar(lstDados);
    end;

    ////lança a lucro/prejuizo do exercicio
    pDefinirLucroOuPrejuizo ;

  finally
    FreeAndNil(qryLucroPrejuizo);
    FreeAndNil(lstDados);
  end;
end;

procedure TfrmFechamentoContabil.pSetaTextoProgresso(pgbProgresso: TcxProgressBar; strTexto: String);
begin
  If Assigned(pgbProgresso) And (GetParentForm(pgbProgresso).FindComponent('lblGravando') <> Nil) Then
  Begin
    TLabel(GetParentForm(pgbProgresso).FindComponent('lblGravando')).Caption := strTexto;
    Application.ProcessMessages;
  End;
end;

procedure TfrmFechamentoContabil.pTravarDigitacaoTela(const ATravar: boolean);
begin
  mskExercicio.Enabled := ATravar;
  edtEmpGrv.Enabled := ATravar;
  if not FblnTabelaEPREGTexiste then
    rdgFormaFechamento.Enabled := ATravar;
  btnGerar.Enabled := ATravar;
  btnSair.Enabled := ATravar;
end;

procedure TfrmFechamentoContabil.rdgFormaFechamentoClick(Sender: TObject);
begin
  inherited;
  pCriaPeriodoCustomizadoFechamento(TTipoFechamentoContabil(TRadioGroup(Sender).ItemIndex)) ;
end;

procedure TfrmFechamentoContabil.pGravarFecCon;
  var
    qryFecCon : TFDQuery;
begin
  qryFecCon := TFDQuery.Create(Self);
  qryFecCon.Connection := FGravacaoEmLote.getDataBase;
  try
    qryFecCon.Close;
    qryFecCon.SQL.Clear;
    qryFecCon.SQL.Add('SELECT * FROM FECCON WHERE FALSE');
    qryFecCon.Open;
    qryFecCon.Insert;
    qryFecCon.FieldByName('CON_DTAFEC').AsDateTime := VS_Date;

    if fCampoExiste('FECCON', 'CON_HRAFEC') then
      qryFecCon.FieldByName('CON_HRAFEC').AsDateTime := fTime();

    qryFecCon.FieldByName('CON_FECINI').AsDateTime := dtaDtaIni;
    qryFecCon.FieldByName('CON_FECFIN').AsDateTime := dtaDtaFin;
    qryFecCon.FieldByName('CON_CODOPE').AsString := strLoginUsuarioLogado;
    qryFecCon.FieldByName('CON_CODEMP').AsString := edtEmpGrv.Text;
    qryFecCon.Post;
  finally
    FreeAndNil(qryFecCon);
  end;
end;

procedure TfrmFechamentoContabil.pDefinirLucroOuPrejuizo;
  var
    fltLucroOuPrejuizo : Double;
    dados : TDadosImportacaoContabil;
    lstDados : TObjectList<TDadosImportacaoContabil>;
begin
  if fCfgConTra = 'S' then
  begin
    if (MonthOf(dtaDtaFin) <> MonthsPerYear) then
    begin
      Exit;
    end;
  end;

  fltLucroOuPrejuizo := fGetTotalConta(fCfgSis('CONLUC'), fCfgSis('CONPRE'), fCfgSis('CONRES'));

  if fltLucroOuPrejuizo = 0.00 then
  begin
    exit ;
  end;

  lstDados := TObjectList<TDadosImportacaoContabil>.Create;
  try
    dados := TDadosImportacaoContabil.Create(VC_StrVersaoContabilidade, VS_strCodEmp);
    dados.fltValorLancamento := Abs(fltLucroOuPrejuizo);
    dados.strContaDebito := fCfgSis('CONLUC');
    dados.strContaCredito := fCfgSis('CONPRE');
    dados.strCodigoEmpresa := edtEmpGrv.Text;
    dados.dtaLancamento := dtaDtaFin;
    dados.strTipoLancamento := 'FEC';
    dados.intCodigoHistoricoPadrao := -1;
    dados.intAutomatico := 1;
    dados.strCodigoOperador := strLoginUsuarioLogado;
    dados.strHistorico := HISTORICO_APURACAO;
    dados.strCtpInc := fGerarIncDocLanConManual ;
    lstDados.Add(dados);
    FGravacaoEmLote.pGravar(lstDados);
  finally
    FreeAndNil(lstDados);
  end;
end;

function TfrmFechamentoContabil.fGetTotalConta(const AContaLucro, AContaPrejuizo, AContaResultado: String): Double;
  var
    qryApuracao : TFDQuery;
    LdtaDtaFin : TDate ;
begin

  LdtaDtaFin := dtaDtaFin ;

  qryApuracao := TFDQuery.Create(Self);
  qryApuracao.Connection := FGravacaoEmLote.getDataBase;
  try
    qryApuracao.Close;
    qryApuracao.SQL.Clear;
    qryApuracao.SQL.Add(' SELECT SUM(VALOR) AS RESULTADO, (SUM(CASE WHEN IDENTI IN ( 2, 4, 0 ) THEN VALOR ELSE 0.00 END)) AS PREJUI, (SUM(CASE WHEN IDENTI IN (3, 5, 1) THEN VALOR ELSE 0.00 END)) AS LUCRO_, (SUM(CASE WHEN IDENTI in (1,0) THEN VALOR ELSE 0.00 END)) AS SALDO_ANT ');
    qryApuracao.SQL.Add('   FROM ( ');
    // Saldo Inicial
    qryApuracao.SQL.Add('          SELECT ' + fCampoSaldoInicialPlaIni + ' AS VALOR, 1 AS IDENTI ');
    qryApuracao.SQL.Add('            FROM PLAINI ');
    qryApuracao.SQL.Add('           WHERE INI_CODEMP = :CODEMP AND INI_EXERCI = :EXERCI ');
    qryApuracao.SQL.Add('             AND INI_CODCON = :CONLUC ');

    qryApuracao.SQL.Add('           UNION ALL ');
    qryApuracao.SQL.Add('          SELECT ' + fCampoSaldoInicialPlaIni + ' AS VALOR, 0 AS IDENTI ');
    qryApuracao.SQL.Add('            FROM PLAINI ');
    qryApuracao.SQL.Add('           WHERE INI_CODEMP = :CODEMP AND INI_EXERCI = :EXERCI ');
    qryApuracao.SQL.Add('             AND INI_CODCON = :CONPRE ');

    qryApuracao.SQL.Add('           UNION ALL ');
    // (Débito saldo)
    qryApuracao.SQL.Add('          SELECT SUM(ABS(CON_VALLAN)) AS VALOR, 4 AS IDENTI ');
    qryApuracao.SQL.Add('            FROM LANCON ');
    qryApuracao.SQL.Add('           WHERE CON_EMPLAN = :CODEMP AND YEAR(CON_DTALAN) = :EXERCI AND MONTH(CON_DTALAN) < :MESEXE ');
    qryApuracao.SQL.Add('             AND CON_CONDEB = :CONPRE ');

    qryApuracao.SQL.Add('           UNION ALL ');
    ////Transferencia
    qryApuracao.SQL.Add('          SELECT -SUM(ABS(CON_VALLAN)) AS VALOR, 4 AS IDENTI ');
    qryApuracao.SQL.Add('            FROM LANCON ');
    qryApuracao.SQL.Add('           WHERE CON_EMPLAN = :CODEMP AND YEAR(CON_DTALAN) = :EXERCI AND MONTH(CON_DTALAN) < :MESEXE ');
    qryApuracao.SQL.Add('             AND CON_CONCRE = :CONPRE AND CON_CONDEB = :CONLUC ');

    qryApuracao.SQL.Add('           UNION ALL ');
    // (Crédito saldo)
    qryApuracao.SQL.Add('          SELECT -SUM(ABS(CON_VALLAN)) AS VALOR, 5 AS IDENTI ');
    qryApuracao.SQL.Add('            FROM LANCON ');
    qryApuracao.SQL.Add('           WHERE CON_EMPLAN = :CODEMP AND YEAR(CON_DTALAN) = :EXERCI AND MONTH(CON_DTALAN) < :MESEXE ');
    qryApuracao.SQL.Add('             AND CON_CONCRE = :CONLUC ');

    qryApuracao.SQL.Add('          UNION ALL ');
    ///transferencia
    qryApuracao.SQL.Add('          SELECT SUM(ABS(CON_VALLAN)) AS VALOR, 5 AS IDENTI ');
    qryApuracao.SQL.Add('            FROM LANCON ');
    qryApuracao.SQL.Add('           WHERE CON_EMPLAN = :CODEMP AND YEAR(CON_DTALAN) = :EXERCI AND MONTH(CON_DTALAN) < :MESEXE ');
    qryApuracao.SQL.Add('             AND CON_CONDEB = :CONLUC AND CON_CONCRE = :CONPRE ');

    qryApuracao.SQL.Add('          UNION ALL ');
    // (Débito Exercicio)
    qryApuracao.SQL.Add('          SELECT SUM(ABS(CON_VALLAN)) AS VALOR, 2 AS IDENTI ');
    qryApuracao.SQL.Add('            FROM LANCON ');
    qryApuracao.SQL.Add('           WHERE CON_EMPLAN = :CODEMP AND YEAR(CON_DTALAN) = :EXERCI AND MONTH(CON_DTALAN) = :MESEXE ');
    qryApuracao.SQL.Add('             AND CON_CONDEB = :CONPRE AND CON_CONCRE = :CONRES ');

    qryApuracao.SQL.Add('           UNION ALL ');
    // (Crédito Exercicio)
    qryApuracao.SQL.Add('          SELECT -SUM(ABS(CON_VALLAN)) AS VALOR, 3 AS IDENTI ');
    qryApuracao.SQL.Add('            FROM LANCON ');
    qryApuracao.SQL.Add('           WHERE CON_EMPLAN = :CODEMP AND YEAR(CON_DTALAN) = :EXERCI AND MONTH(CON_DTALAN) = :MESEXE ');
    qryApuracao.SQL.Add('             AND CON_CONCRE = :CONLUC AND CON_CONDEB = :CONRES ');

    qryApuracao.SQL.Add('          ) AS TMP_APURACA ');
    qryApuracao.ParamByName('MESEXE').AsInteger := MonthOf(LdtaDtaFin);
    qryApuracao.ParamByName('EXERCI').AsInteger := fExercicio;
    qryApuracao.ParamByName('CONLUC').AsString := AContaLucro;
    qryApuracao.ParamByName('CONPRE').AsString := AContaPrejuizo;
    qryApuracao.ParamByName('CONRES').AsString := AContaResultado;
    qryApuracao.ParamByName('CODEMP').AsString := edtEmpGrv.Text;
    qryApuracao.Open;

    result := 0.00 ;
    if abs(qryApuracao.FieldByName('PREJUI').AsFloat) < abs(qryApuracao.FieldByName('LUCRO_').AsFloat) then
    begin
      result := abs(qryApuracao.FieldByName('PREJUI').AsFloat)*-1 ;
    end
    else
    begin
      result := abs(qryApuracao.FieldByName('LUCRO_').AsFloat)*-1 ;
    end;

  finally
    qryApuracao.Close;
    FreeAndNil(qryApuracao);
  end;
end;

function TfrmFechamentoContabil.fJoinPlaDet: string;
begin
  Result := 'PLADET';
  if not FblnTabelaPLADETExiste then
    Result := '(SELECT CAST(NULL AS CHAR(1))DET_PLAINC, CAST(NULL AS CHAR(1))DET_EMPDET, CAST(NULL AS CHAR(1))DET_CREDEB, CAST(NULL AS DECIMAL(12,2))DET_SALINI) AS PLADET';
end;

function TfrmFechamentoContabil.fJoinLanDet: string;
begin
  Result := 'LANDET';
  if not FblnTabelaLANDETExiste then
    Result := '(SELECT CAST(NULL AS DATE)DET_DTAMOV, CAST(NULL AS CHAR(1))DET_CODCON, CAST(NULL AS CHAR(1))DET_CCUSTO, CAST(NULL AS CHAR(1))DET_CODEMP, CAST(NULL AS CHAR(1))DET_EMPDET, CAST(NULL AS CHAR(1))DET_CRDEFI, CAST(NULL AS DECIMAL(12,2))DET_SALFIN) AS LANDET';
end;

function TfrmFechamentoContabil.fJoinDprDet: string;
begin
  Result := 'DPRDET';
  if not FblnTabelaDPRDETExiste then
    Result := '(SELECT CAST(NULL AS CHAR(1))DET_CODCON, CAST(NULL AS CHAR(1))DET_EXERCI, CAST(NULL AS CHAR(1))DET_CODEMP, ' +
              'CAST(NULL AS CHAR(1))DET_TIP_FC, CAST(NULL AS CHAR(1))DET_CLIFOR, CAST(NULL AS CHAR(1))DET_EMPDET, CAST(NULL AS CHAR(1))DET_CREDEB, CAST(NULL AS DECIMAL(12,2))DET_SALINI) AS DPRDET';
end;

end.
