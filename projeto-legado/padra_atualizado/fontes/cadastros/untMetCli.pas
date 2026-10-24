{*******************************************}
{* CLASSE PARA METAS DE CLIENTES           *}
{* DATA: 23/11/2007                        *}
{* AUTOR: RICARDO DE LIMA                  *}
{****************************************RL*}

unit untMetCli;

interface

uses StrUtils, SysUtils, Uni, Db, Classes, Forms, Variants, UniClientDataSet, Provider;

Type TMetCli = Class(TComponent)

  Private

    FAutInc: String;
    FCodCli: String;
    FMarca: String;
    FValFat: Double;
    FValCre: Double;
    FGrupo: String;
    FFornec: String;
    FTipMet: String;
    FLitrag: Double;
    FDepart: String;

    strNumDup: String;

  Public

    qryMetCli: TUniQuery;
    dtsMetCli: TDataSource;

    function fMostraCredito(strCodCli, strCodMar, strCodGru, strCodFor, strTipMet, strCodDep: String; dtaDtaIni,
      dtaDtaFin: TDateTime; fltValMet: Double): TUniQuery;
    function fGeraCadRec: Boolean;
    function fAtualizaMetCli(strNumCtr: String = ''): Boolean;
    function fStrFatorLit: String;

    procedure pCarregaMetCli(strCodCli: String; blnGeradas: Boolean = False);
    procedure pGravaMetCli(strCodCli, strCodMar: String; dtaDtaIni,
      dtaDtaFin: TDatetime; fltValMet, fltValDes, fltLitrag: Double; strCodEmp,
      strAutInc, strCodGru, strCodFor, strTipMet, strCodDep: String);
    procedure pDeletaMetCli(strAutInc: String);
    procedure pAtuDados(qryDados: TUniQuery);
    procedure pLimpaDados;

    property strAutInc: String    Read FAutInc Write FAutInc;
    property strCodCli: String    Read FCodCli Write FCodCli;
    property strMarca : String    Read FMarca  Write FMarca;
    property fltValFat: Double    Read FValFat Write FValFat;
    property fltValCre: Double    Read FValCre Write FValCre;
    property strGrupo:  String    Read FGrupo  Write FGrupo;
    property strFornec: String    Read FFornec Write FFornec;
    property strTipMet: String    Read FTipMet Write FTipMet;
    property fltLitrag: Double    Read FLitrag Write FLitrag;
    property strDepart: String    Read FDepart  Write FDepart;

    Constructor Create(Owner: TComponent); Reintroduce;
    Destructor Destroy; Override;

  End;

implementation

uses untFuncoesSimples, untConstantes, untCadRec;
{ TMetCli }

constructor TMetCli.Create(Owner: TComponent);
begin
  inherited;
  Try
    qryMetCli := fCriaQuery;
    dtsMetCli := TDataSource.Create(qryMetCli);
  Except
    On E: Exception Do
      Raise Exception.Create(E.Message);
  End;
end;

destructor TMetCli.Destroy;
begin
  FreeAndNil(dtsMetCli);
  FreeAndNil(qryMetCli);
  inherited;
end;

{*******************************************}
{* GRAVA METCLI                            *}
{****************************************RL*}
procedure TMetCli.pGravaMetCli(strCodCli, strCodMar: String; dtaDtaIni,
  dtaDtaFin: TDatetime; fltValMet, fltValDes, fltLitrag: Double; strCodEmp,
  strAutInc, strCodGru, strCodFor, strTipMet, strCodDep: String);
begin
  Try
    With qryMetCli Do
    Begin
      If Not Active Then
        pCarregaMetCli(strCodCli);

      If not Locate('AUTOINCREM', strAutInc, []) Then
      Begin
        Insert;
        FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('METCLI', strCodEmp);
      End
      Else
        Edit;

      FieldByName('MCL_CODCLI').AsString   := strCodCli;

      If Not fEmptyStr(strCodMar) Then
        FieldByName('MCL_CODMAR').AsString  := strCodMar
      Else
        FieldByName('MCL_CODMAR').Value  := NULL;

      If Not fEmptyStr(strCodGru) Then
        FieldByName('MCL_CODGRU').AsString  := strCodGru
      Else
        FieldByName('MCL_CODGRU').Value  := NULL;

      If Not fEmptyStr(strCodFor) Then
        FieldByName('MCL_CODFOR').AsString  := strCodFor
      Else
        FieldByName('MCL_CODFOR').Value  := NULL;

      If Not fEmptyStr(strCodDep) Then
        FieldByName('MCL_CODDEP').AsString  := strCodDep
      Else
        FieldByName('MCL_CODDEP').Value  := NULL;

      FieldByName('MCL_DTAINI').AsDateTime := dtaDtaIni;
      FieldByName('MCL_DTAFIN').AsDateTime := dtaDtaFin;
      FieldByName('MCL_TIPMET').AsString   := strTipMet;
      FieldByName('MCL_VALMET').AsFloat    := fltValMet;
      FieldByName('MCL_VALDES').AsFloat    := fltValDes;
      FieldByName('MCL_CODEMP').AsString   := strCodEmp;
      FieldByName('MCL_LITRAG').AsFloat    := fltLitrag;
      Post;
    End;
  Except
    On E: Exception Do
    Begin
      qryMetCli.Cancel;
      Raise Exception.Create('Erro ao gravar meta! [fGravaMetCli]' + #13 + E.Message);
    End;
  End;
end;

{*******************************************}
{* CARREGA AS METAS DO CLIENTE INFORMADO   *}
{****************************************RV*}
procedure TMetCli.pCarregaMetCli(strCodCli: String; blnGeradas: Boolean = False);
  Var
    strSQL: String;
begin
  Try
    strSQL := '';
    strSQL := strSQL + 'SELECT  ';
    strSQL := strSQL + '  MCL_CODCLI, ';
    strSQL := strSQL + '  MCL_CODMAR, ';
    strSQL := strSQL + '  MCL_CODGRU, ';
    strSQL := strSQL + '  MCL_CODFOR, ';
    strSQL := strSQL + '  MCL_CODDEP, ';
    strSQL := strSQL + '  MCL_DTAINI, ';
    strSQL := strSQL + '  MCL_DTAFIN, ';
    strSQL := strSQL + '  MCL_TIPMET, ';
    strSQL := strSQL + '  MCL_VALMET, ';
    strSQL := strSQL + '  MCL_VALDES, ';
    strSQL := strSQL + '  MCL_DTABAI, ';
    strSQL := strSQL + '  MCL_VALFAT, ';
    strSQL := strSQL + '  MCL_VALCRE, ';
    strSQL := strSQL + '  MCL_NUMCTR, ';
    strSQL := strSQL + '  MCL_CODEMP, ';
    strSQL := strSQL + '  MCL_LITRAG, ';
    strSQL := strSQL + '  AUTOINCREM ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  METCLI ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  MCL_CODCLI = :CODCLI ';

    If Not blnGeradas Then
      strSQL := strSQL + ' AND MCL_DTABAI IS NULL'
    Else
      strSQL := strSQL + ' AND MCL_DTABAI IS NOT NULL';

    qryMetCli.Close;
    qryMetCli.SQL.Clear;

    qryMetCli.SQL.Add(strSQL);
    qryMetCli.ParamByName('CODCLI').AsString := strCodCli;

    qryMetCli.Open;
  Except
    On E: Exception Do
      Raise Exception.Create(E.Message);
  End;
end;

{*******************************************}
{* EXCLUI METAS                            *}
{****************************************RL*}
procedure TMetCli.pDeletaMetCli(strAutInc: String);
  Var qryTmp: TUniQuery;
      strSQL: String;
begin
  qryTmp := fCriaQuery;

  strSQL := '';
  strSQL := strSQL + 'DELETE FROM ';
  strSQL := strSQL + '  METCLI ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  AUTOINCREM IN (' + strAutInc + ')';
  Try
    With qryTmp Do
    Begin
      Try
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ExecSQL;
      Except
        On E: Exception Do
          Raise Exception.Create('Erro ao deletar meta. ' + E.Message);
      End;
    End;
  Finally
    FreeAndNil(qryTmp);
  End;
end;

{*******************************************}
{* MOSTRA CRÉDITOS A GERAR E OS JÁ GERADOS *}
{****************************************RV*}
function TMetCli.fMostraCredito(strCodCli, strCodMar, strCodGru, strCodFor, strTipMet, strCodDep: String; dtaDtaIni,
  dtaDtaFin: TDateTime; fltValMet: Double): TUniQuery;
  Var
    qryTmp  : TUniQuery;
    strSQL  : String;

   function fRetSQLMovDet(strTipFat: String): String;
   Begin
     Result :=  '    SELECT ' +
                '       DET_CODCLI, ' +
                '       ITE_CODMAR, ' +
                '       ITE_CODFOR, ' +
                '       ITE_CODDEP, ' +
                '       ITE_CODGRU, ';

     If (strTipFat = 'V') Then
        Result := Result + ' (IF((DET_ESPDOC = "BR") OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + '), 0.00, IF(LEFT(DET_CLAFIS,1) < 5, -(DET_TOTITE - DET_DESESP - DET_DESCFF), DET_TOTITE - DET_DESESP - DET_DESCFF))) AS TOTITE '
     Else
        Result := Result + ' (IF(LEFT(DET_CLAFIS,1) < 5, -(DET_QTDITE), DET_QTDITE) * ' + fStrFatorLit + ') AS LITITE ';

     Result := Result +
                 '     FROM '     +
                 '       MOVDET ' +
                 '          LEFT JOIN CADITE ON ITE_CODITE = DET_CODITE ' +
                 '          LEFT JOIN CADUNI ON DET_UNIDAD = UNI_CODUNI ' +
                 '     WHERE '    +
                 '       DET_CODEMP = :CODEMP  AND ' +
                 '       DET_CODCLI = :CODCLI  AND ' +
                 '       DET_TIP_FC = "C"      AND ' +
                 '       DET_PROEMB <> "S"     AND ' +
                 cnsFiltroFFDVTR +
                 '        DET_DTAENT BETWEEN :DTAINI AND :DTAFIN AND ' +
                 '        ((LOCATE(DET_CLAFIS, :CLAFIS) > 0) OR (LOCATE(DET_CLAFIS, :CLADEV) > 0) ' + IIF(fCfgSis('ENTBRF', varBoolean), ' OR (DET_ESPDOC = "BR") OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + ')) ', ')');

     Result := fRetornaSQLSeparandoItensPorDatEntItensPorDatFat(Result);
   End;

   function fRetWhereMetCliMovDet: String;
   begin
     Result := ' WHERE '+
               '   DET_CODCLI = MCL_CODCLI AND ' +
               '   ITE_CODMAR = IF(IFNULL(MCL_CODMAR, "") = "", ITE_CODMAR, MCL_CODMAR) AND ' +
               '   ITE_CODFOR = IF(IFNULL(MCL_CODFOR, "") = "", ITE_CODFOR, MCL_CODFOR) AND ' +
               '   IF(IFNULL(MCL_CODDEP, "") = "", TRUE, ITE_CODDEP = MCL_CODDEP) AND '+
               '   IF(IFNULL(MCL_CODGRU, "") = "", TRUE, IF(RIGHT(MCL_CODGRU,3) = "000", LEFT(MCL_CODGRU,3) = LEFT(ITE_CODGRU,3), MCL_CODGRU = ITE_CODGRU)) ';
   end;

begin
  qryTmp := fCriaQuery;

  strSQL := '';
  strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
  strSQL := strSQL + '  METCLI.AUTOINCREM                   AS "AUTINC", ';
  strSQL := strSQL + '  MCL_CODCLI                          AS "CODCLI", ';
  strSQL := strSQL + '  MCL_CODMAR                          AS "CODMAR", ';
  strSQL := strSQL + '  MCL_CODGRU                          AS "CODGRU", ';
  strSQL := strSQL + '  MCL_CODFOR                          AS "CODFOR", ';
  strSQL := strSQL + '  MCL_CODDEP                          AS "CODDEP", ';
  strSQL := strSQL + '  IF(MCL_CODMAR = "", "", CONCAT(MAR_CODMAR, "-", MAR_DESMAR)) AS "MARCA", ';
  strSQL := strSQL + '  IF(MCL_CODGRU = "", "", CONCAT(GRU_CODGRU, "-", GRU_DESGRU)) AS "GRUPO", ';
  strSQL := strSQL + '  IF(MCL_CODFOR = "", "", CONCAT(FOR_CODFOR, "-", FOR_NOMFOR)) AS "FORNEC", ';
  strSQL := strSQL + '  IF(MCL_CODDEP = "", "", CONCAT(DEP_CODIGO, "-", DEP_DESCRI)) AS "DEPART", ';
  strSQL := strSQL + '  MCL_DTAINI                          AS "DTAINI", ';
  strSQL := strSQL + '  MCL_DTAFIN                          AS "DTAFIN", ';
  strSQL := strSQL + '  MCL_TIPMET                          AS "TIPMET", ';
  strSQL := strSQL + '  MCL_VALMET                          AS "META", ';

  strSQL := strSQL + '  (SELECT SUM(VW_FAT.TOTITE) FROM ( '+fRetSQLMovDet('V')+' ) AS VW_FAT '+fRetWhereMetCliMovDet+') AS "FATURA", ';
  strSQL := strSQL + '  (SELECT SUM(VW_LIT.LITITE) FROM ( '+fRetSQLMovDet('L')+' ) AS VW_LIT '+fRetWhereMetCliMovDet+') AS "LITRAGEM", ';

  strSQL := strSQL + '  MCL_VALDES AS "DESCON" ';

  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  METCLI ';
  strSQL := strSQL + '    LEFT JOIN CADMAR ON MAR_CODMAR = MCL_CODMAR ';
  strSQL := strSQL + '    LEFT JOIN CADGRU ON GRU_CODGRU = MCL_CODGRU ';
  strSQL := strSQL + '    LEFT JOIN CADFOR ON FOR_CODFOR = MCL_CODFOR ';
  strSQL := strSQL + '    LEFT JOIN CADDEP ON DEP_CODIGO = MCL_CODDEP ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  (MCL_DTABAI IS NULL)      AND ';
  strSQL := strSQL + '  (MCL_CODEMP = :CODEMP)    AND ';

  If (strCodMar <> '') Then
    strSQL := strSQL + '  (MCL_CODMAR = :CODMAR)  AND ';

  If (strCodGru <> '') Then
    strSQL := strSQL + '  (MCL_CODGRU = :CODGRU)  AND ';

  If (strCodFor <> '') Then
    strSQL := strSQL + '  (MCL_CODFOR = :CODFOR)  AND ';

  If (strCodDep <> '') Then
    strSQL := strSQL + '  (MCL_CODDEP = :CODDEP)  AND ';

  If fEmptyStr(strCodMar+strCodGru+strCodFor+strCodDep) Then
    strSQL := strSQL + ' ((MCL_CODMAR IS NULL) AND (MCL_CODGRU IS NULL) AND (MCL_CODFOR IS NULL) AND (MCL_CODDEP IS NULL)) AND ';

  strSQL := strSQL + '  (MCL_TIPMET = :TIPMET)    AND ';
  strSQL := strSQL + '  (MCL_VALMET = :VALMET)    AND ';
  strSQL := strSQL + '  (MCL_CODCLI = :CODCLI)    AND ';
  strSQL := strSQL + '  ((MCL_DTAINI BETWEEN :DTAINI AND :DTAFIN) OR ';
  strSQL := strSQL + '   (MCL_DTAFIN BETWEEN :DTAINI AND :DTAFIN)) ';

  With qryTmp Do
  Begin
    Try
      Close;
      SQL.Clear;
      SQL.Add(strSQL);

      If SameText(fCfgSis('LITGAL'), 'L') Then
        ParamByName('LITGAL').AsFloat := 1
      Else
        ParamByName('LITGAL').AsFloat := FLT_LITRO_GALAO;

      ParamByName('CODCLI').AsString   := strCodCli;
      ParamByName('CODEMP').AsString   := VS_strCodEmp;
      ParamByName('DTAINI').AsDateTime := dtaDtaIni;
      ParamByName('DTAFIN').AsDateTime := dtaDtaFin;
      ParamByName('CLAFIS').AsString   := VS_strClaVen;
      ParamByName('CLADEV').AsString   := VS_strClaDev;

      If (strCodMar <> '') Then
        ParamByName('CODMAR').AsString   := strCodMar;

      If (strCodGru <> '') Then
        ParamByName('CODGRU').AsString   := strCodGru;

      If (strCodFor <> '') Then
        ParamByName('CODFOR').AsString   := strCodFor;

      If (strCodDep <> '') Then
        ParamByName('CODDEP').AsString   := strCodDep;

      ParamByName('TIPMET').AsString   := strTipMet;
      ParamByName('VALMET').AsFloat    := fltValMet;

      Open;

      pLimpaDados;
      pAtuDados(qryTmp);

      Result := qryTmp;
    Except
      On E: Exception Do
      Begin
        FreeAndNil(qryTmp);
        Raise Exception.Create(E.Message + #13 + '[fMostraCredito]' );
      End;
    End;
  End;
end;

function TMetCli.fStrFatorLit: String;
begin
  Result := ' UNI_PESLIT / :LITGAL ';
end;

{*******************************************}
{* ATUALIZA VARIÁVEIS                      *}
{****************************************RL*}
procedure TMetCli.pAtuDados(qryDados: TUniQuery);
begin
  With qryDados Do
  Begin
    Try
      FAutInc := FieldByName('AUTINC').AsString;
      FCodCli := FieldByName('CODCLI').AsString;
      FMarca  := FieldByName('MARCA').AsString;
      FValFat := FieldByName('FATURA').AsFloat;
      FGrupo  := FieldByName('GRUPO').AsString;
      FFornec := FieldByName('FORNEC').AsString;
      FLitrag := FieldByName('LITRAGEM').AsFloat;
      FDepart := FieldByName('DEPART').AsString;

      If (FieldByName('TIPMET').AsString = 'V') Then
      Begin
        If (FieldByName('FATURA').AsFloat >= FieldByName('META').AsFloat) Then
          FValCre := (FieldByName('FATURA').AsFloat * (FieldByName('DESCON').AsFloat / 100)) * (- 1)
        Else
          FValCre := 0;
      End
      Else If (FieldByName('TIPMET').AsString = 'L') Then
      Begin
        If (FieldByName('LITRAGEM').AsFloat >= FieldByName('META').AsFloat) Then
          FValCre := (FieldByName('FATURA').AsFloat * (FieldByName('DESCON').AsFloat / 100)) * (- 1)
        Else
          FValCre := 0;
      End;
    Except
      On E: Exception Do
        Raise Exception.Create(E.Message);
    End;
  End;
end;

{*******************************************}
{* LIMPA / INICIALIZA VARIÁVEIS            *}
{****************************************RL*}
procedure TMetCli.pLimpaDados;
begin
  FAutInc := '';
  FCodCli := '';
  FMarca  := '';
  FValFat := 0;
  FValCre := 0;
  FGrupo  := '';
  FFornec := '';
  FTipMet := '';
  FLitrag := 0;
  FDepart := '';
end;

function TMetCli.fGeraCadRec: Boolean;
begin
  Try
    strNumDup := fAtualizaProCod('METCLI', 'CTR_NUMDUP', 'CADREC', 1, Nil,
      function (const AValue: String) : String
      begin
        Result := fStrZero(AValue, fTamDocCadRec);
      end
    );

    Result := fGravaCadRec('untMetCli',
                    'INCLUSÃO',
                    strNumDup,
                    'A',
                    0,
                    'MC',
                    strCodCli,
                    VS_strCodEmp,
                    strLoginUsuarioLogado,
                    strLoginUsuarioLogado,
                    '',
                    VS_Date,
                    VS_Date,
                    fltValCre,
                    fltValCre,
                    0,
                    '',
                    'META DE CLIENTE - MARCA: ' + strMarca,
                    '',
                    '',
                    '',
                    '',
                    '',
                    0,
                    0,
                    'N',
                    '',
                    '',
                    '',
                    '',
                    False,
                    '',
                    0,
                    0);
  Except
    On E: Exception Do
    Begin
      Result := False;
			pMensagensErro(E.Message,'[TMetCli.fGeraCadRec]');
    End;
  End;
end;

{*********************************************}
{* ATUALIZA CAMPOS APÓS A GERAÇÃO DE CRÉDITO *}
{******************************************RL*}
function TMetCli.fAtualizaMetCli(strNumCtr: String = ''): Boolean;
begin
  Result := True;
  With qryMetCli Do
  Begin
    Try
      If Not Active Then
        pCarregaMetCli(strCodCli);
      {************************************************}
      {* QUANDO O PARÂMETRO strNumCtr ESTÁ VAZIO,     *}
      {* SIGNIFICA QUE O USUÁRIO ESTÁ FAZENDO A       *}
      {* GERAÇÃO DO CRÉDITO NO CADREC, CASO CONTRÁRIO *}
      {* ELE ESTÁ APAGANDO O CRÉDITO GERADO NO CADREC *}
      {*********************************************RL*}
      If fEmptyStr(strNumCtr) Then
      Begin
        Locate('AUTOINCREM', strAutInc, []);
        Edit;
        FieldByName('MCL_DTABAI').AsDateTime := VS_Date;
        FieldByName('MCL_VALFAT').AsFloat    := fltValFat;
        FieldByName('MCL_VALCRE').AsFloat    := fltValCre;
        FieldByName('MCL_NUMCTR').AsString   := strNumDup + 'A' + 'MC' + VS_strCodEmp;
        FieldByName('MCL_LITRAG').AsFloat    := fltLitrag;
        Post;
      End
      Else
      Begin
        Locate('MCL_NUMCTR', strNumCtr, []);
        Edit;
        FieldByName('MCL_DTABAI').Value    := Null;
        FieldByName('MCL_VALFAT').AsFloat  := 0;
        FieldByName('MCL_VALCRE').AsFloat  := 0;
        FieldByName('MCL_NUMCTR').AsString := '';
        FieldByName('MCL_LITRAG').AsFloat  := 0;
        Post;
      End;
    Except
      On E: Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message,'[TMetCli.fAtualizaMetCli]');
      End;
    End;
  End;
end;

end.


