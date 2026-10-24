{******************************************************}
{* ESSA UNIT CONTEM AS PESQUISAS AUXILIARES QUE SÃO   *}
{* REALIZADAS NOS CADASTROS.                          *}
{* PARAMETROS:                                        *}
{*                                                    *}
{* qryTabOri: A Tabela qual se deseja referenciar. Ex *}
{* frmModulo.qryCadCli -> é a tabela original do mo-  *}
{* dulo                                               *}
{*                                                    *}
{* qryTabela: A Tabela que será usada durante o ca-   *}
{* dastro. O padrão é ussar os Componentes TUniQuery    *}
{* que estão no modulo frmModuloCons                  *}
{*                                                    *}
{* strCod???: É a chave para a pesquisa               *}
{***************************************************MV*}
unit untPesqAux;

interface

uses Uni, Classes, SysUtils, StrUtils;

  {*******************************************}
  {* FUNÇÃO AUXILIAR PARA FORMATAR OS CAMPOS *}
  {****************************************MV*}
  procedure pAtribuiDisplayLabels(qryTabOri, qryTabDest: TUniQuery);

  procedure pPesquisaCadAti(qryTabOri, qryTabela: TUniQuery; strCodAti: String);
  procedure pPesquisaCadCid(qryTabOri, qryTabela: TUniQuery; strCodCid: String);
  procedure pPesquisaCadTri(qryTabOri, qryTabela: TUniQuery; strCodTri: String);
  procedure pPesquisaCadVen(qryTabOri, qryTabela: TUniQuery; strCodVen: String; blnBuscaPorSenha: Boolean = False);
  procedure pPesquisaCadPor(qryTabOri, qryTabela: TUniQuery; strCodPor: String);
  procedure pPesquisaCadCta(qryTabOri, qryTabela: TUniQuery; strCodCta: String; blnUsaCtf: Boolean = False; strCodFor: String = '');
  procedure pPesquisaCadFor(qryTabOri, qryTabela: TUniQuery; strCodFor: String; blnBuscaCnpj: Boolean = False);
  procedure pPesquisaCadMar(qryTabOri, qryTabela: TUniQuery; strCodMar: String);
  procedure pPesquisaAbfIcm(qryTabOri, qryTabela: TUniQuery; strCodAbf: String; strEstado: String = '');
  procedure pPesquisaLinGru(qryTabOri, qryTabela: TUniQuery; strCodGru: String);
  procedure pPesquisaCadUni(qryTabOri, qryTabela: TUniQuery; strCodUni: String);
  procedure pPesquisaCadEmp(qryTabOri, qryTabela: TUniQuery; strCodEmp: String);
  procedure pPesquisaCadBco(qryTabOri, qryTabela: TUniQuery; strCodBco: String);
  procedure pPesquisaCadIte(qryTabOri, qryTabela: TUniQuery; strCodIte: String;
                            strCodFor: String = '';
                            blnBuscaCodBar: Boolean = False; blnBuscaCodFab: Boolean = False;
                            blnFiltraAtivo: Boolean = True; blnFiltrarExiLis: Boolean = True;
                            blnFiltraDepProdAcab: Boolean = False; blnFiltraDepProdEmb: Boolean = False;
                            blnFiltraDepProdGra: Boolean = False;  blnFiltraDepMatPrim: Boolean = False;
                            blnVeioF11: Boolean = False);

  procedure pPesquisaDesSit(qryTabOri, qryTabela: TUniQuery; strCodIte: String);

  procedure pPesquisaCadIteSemSemelhante(qryTabOri, qryTabela: TUniQuery; strCodIte: String;
              blnBuscaCodBar: Boolean = False; blnBuscaCodFab: Boolean = False; strFabAut: String = ''; blnCodBarEmb: Boolean = False;
              blnFiltrarExiLis: Boolean = True; strCodFor: String = '');
  
  procedure pPesquisaCadTra(qryTabOri, qryTabela: TUniQuery; strCodTra: String);
  procedure pPesquisaCadTraCidFrete(qryTabOri, qryTabela: TUniQuery; strCodTra, strCodCid: String);
  procedure pPesquisaCadOpe(qryTabOri, qryTabela: TUniQuery; strCodOpe: String; blnBuscaPorSenha: Boolean = False; blnAtivos: Boolean = False);
  procedure pPesquisaCadOpeBar(qryTabOri, qryTabela: TUniQuery; strCodOpe: String);
  procedure pPesquisaCadGpo(qryTabOri, qryTabela: TUniQuery; strCodGpo: String);
  procedure pPesquisaCadCar(qryTabOri, qryTabela: TUniQuery; strCodCar: String);
  procedure pPesquisaCadDiv(qryTabOri, qryTabela: TUniQuery; strCodDiv: String);
  procedure pPesquisaCadZon(qryTabOri, qryTabela: TUniQuery; strCodZon: String);
  procedure pPesquisaCadCfo(qryTabOri, qryTabela: TUniQuery; strCodCfo: String);
  procedure pPesquisaCadEve(qryTabOri, qryTabela: TUniQuery; strCodEve: String);
  procedure pPesquisaCadCnd(qryTabOri, qryTabela: TUniQuery; strCodCnd: String; fltMarDoc: Double = 0; fltValDoc: Double = 0; blnPerCnd: Boolean = False);
  procedure pPesquisaCadFpg(qryTabOri, qryTabela: TUniQuery; strCodFpg: String);
  procedure pPesquisaCadMot(qryTabOri, qryTabela: TUniQuery; strCodMot: String);
  procedure pPesquisaCadReg(qryTabOri, qryTabela: TUniQuery; strCodReg: String);
  procedure pPesquisaCadEcf(qryTabOri, qryTabela: TUniQuery; strCodEcf: String);
  procedure pPesquisaCadSer(qryTabOri, qryTabela: TUniQuery; strCodSer: String);
  procedure pPesquisaCadSfz(qryTabOri, qryTabela: TUniQuery; strCodSfz: String);
  procedure pPesquisaCadCliCon(qryTabOri, qryTabela: TUniQuery; strCpf: String);
  procedure pPesquisaCadOco(qryTabOri, qryTabela: TUniQuery; strCodOco: String);
  procedure pPesquisaCadGOc(qryTabOri, qryTabela: TUniQuery; strCodGoc: String);
  procedure pPesquisaCadToc(qryTabOri, qryTabela: TUniQuery; strCodToc: String; strCodGoc: String = ''; blnAtivas: Boolean = True);
  procedure pPesquisaCadCoc(qryTabOri, qryTabela: TUniQuery; strCodCoc: String; strCodToc: String = '');
  procedure pPesquisaCadCor(qryTabOri, qryTabela: TUniQuery; strCodCor: String);
  procedure pPesquisaCadBan(qryTabOri, qryTabela: TUniQuery; strCodBan: String);
  procedure pPesquisaCadLse(qryTabOri, qryTabela: TUniQuery; strCodLse: String);
  procedure pPesquisaCadEqu(qryTabOri, qryTabela: TUniQuery; strCodEqu: String);

implementation

uses untfuncoesSimples, Data.DB, untConsultas;

procedure pAtribuiDisplayLabels(qryTabOri, qryTabDest: TUniQuery);
  Var
    intContador: Integer;
    strNomeCampo: String;
begin

  If (Not Assigned(qryTabOri)) Or (Not Assigned(qryTabDest)) Then
    Exit;

  For intContador := 0 To qryTabDest.FieldCount -1 Do
  Begin
    strNomeCampo := qryTabDest.Fields[intContador].FieldName;

    If (qryTabOri.FindField(strNomeCampo) <> Nil) Then
    Begin
      qryTabDest.FieldByName(strNomeCampo).Visible := qryTabOri.FieldByName(strNomeCampo).Visible;
      qryTabDest.FieldByName(strNomeCampo).DisplayLabel := qryTabOri.FieldByName(strNomeCampo).DisplayLabel;
    End;

  End;
end;

procedure pPesquisaCadAti(qryTabOri, qryTabela: TUniQuery; strCodAti: String);
  Var
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
  strSQL := strSQL + '  * ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADATI ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  ATI_CODATI = :CODATI ';

  With qryTabela Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODATI').AsString := strCodAti;
    Open;
  End;
  pAtribuiDisplayLabels(qryTabOri, qryTabela);
end;

procedure pPesquisaCadCid(qryTabOri, qryTabela: TUniQuery; strCodCid: String);
  Var
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
  strSQL := strSQL + '  * ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADCID ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  CID_CODCID = :CODCID ';

  With qryTabela Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODCID').AsString := strCodCid;
    Open;
  End;
  pAtribuiDisplayLabels(qryTabOri, qryTabela);
end;

procedure pPesquisaCadTri(qryTabOri, qryTabela: TUniQuery; strCodTri: String);
  Var
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
  strSQL := strSQL + '  * ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADTRI ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  TRI_CODTRI = :CODTRI ';

  With qryTabela Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODTRI').AsString := strCodTri;
    Open;
  End;
  pAtribuiDisplayLabels(qryTabOri, qryTabela);
end;

procedure pPesquisaCadVen(qryTabOri, qryTabela: TUniQuery; strCodVen: String;
  blnBuscaPorSenha: Boolean = False);
  Var
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
  strSQL := strSQL + '  * ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADVEN ';
  strSQL := strSQL + 'WHERE ';
  If blnBuscaPorSenha Then
  Begin
    strSQL := strSQL + '  VEN_SENHA_ = :FILTRO ';
    strCodVen := fCrypt(strCodVen);
  End
  Else
    strSQL := strSQL + '  VEN_CODVEN = :FILTRO ';

  With qryTabela Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('FILTRO').AsString := strCodVen;
    Open;
  End;
  pAtribuiDisplayLabels(qryTabOri, qryTabela);
end;

procedure pPesquisaCadPor(qryTabOri, qryTabela: TUniQuery; strCodPor: String);
  Var
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
  strSQL := strSQL + '  * ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADPOR ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  POR_CODPOR = :CODPOR ';

  With qryTabela Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODPOR').AsString := strCodPor;
    Open;
  End;

  If qryTabOri <> Nil Then
    pAtribuiDisplayLabels(qryTabOri, qryTabela);
end;

procedure pPesquisaCadCta(qryTabOri, qryTabela: TUniQuery; strCodCta: String; blnUsaCtf: Boolean = False; strCodFor: String = '');
  Var
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
  strSQL := strSQL + '  * ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADCTA ';

  If Not fEmptyStr(strCodCta) Then
    strSQL := strSQL + 'WHERE  CTA_CODCTA =  ' + QuotedStr(strCodCta);
  If blnUsaCtf Then
  Begin
    If Not fEmptyStr(strCodCta) Then
      strSQL := strSQL + ' AND CTA_CODCTA IN ( '
    else
      strSQL := strSQL + 'WHERE CTA_CODCTA IN ( ';

    strSQL := strSQL + ' SELECT CTF_CODCTA ';
    strSQL := strSQL + ' FROM CTAFOR ';
    strSQL := strSQL + ' WHERE ';
    strSQL := strSQL + '   CTF_CODFOR = ' + QuotedStr(strCodFor);

    strSQL := strSQL + ' )';
  End;

  With qryTabela Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    Open;
  End;

  pAtribuiDisplayLabels(qryTabOri, qryTabela);
end;


procedure pPesquisaCadCliCon(qryTabOri, qryTabela: TUniQuery; strCpf: String);
  Var
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
  strSQL := strSQL + '  * ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CLICON ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  CON_C_P_F_ = :C_P_F_ ';

  With qryTabela Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('C_P_F_').AsString := strCpf;
    Open;
  End;
  pAtribuiDisplayLabels(qryTabOri, qryTabela);
end;

procedure pPesquisaCadFor(qryTabOri, qryTabela: TUniQuery; strCodFor: String;
  blnBuscaCnpj: Boolean = False);
  Var
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
  strSQL := strSQL + '  * ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADFOR ';
  strSQL := strSQL + 'WHERE ';
  If (blnBuscaCnpj) Then
    strSQL := strSQL + '  FOR_C_G_C_ = :CODFOR '
  Else
    strSQL := strSQL + '  FOR_CODFOR = :CODFOR ';

  With qryTabela Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODFOR').AsString := strCodFor;
    Open;
  End;
  pAtribuiDisplayLabels(qryTabOri, qryTabela);
end;

procedure pPesquisaCadMar(qryTabOri, qryTabela: TUniQuery; strCodMar: String);
  Var
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
  strSQL := strSQL + '  * ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADMAR ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  MAR_CODMAR = :CODMAR ';

  With qryTabela Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODMAR').AsString := strCodMar;
    Open;
  End;
  pAtribuiDisplayLabels(qryTabOri, qryTabela);
end;

procedure pPesquisaAbfIcm(qryTabOri, qryTabela: TUniQuery; strCodAbf: String; strEstado: String = '');
  Var
    strSQL: String;
begin

  strSQL := '';
  strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
  strSQL := strSQL + '  * ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  ABFICM ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  ABF_CODABF = :CODABF ';

  If Not fEmptyStr(strEstado) Then
    strSQL := strSQL + '  AND ABF_ESTADO = :ESTADO ';

  With qryTabela Do
  Begin
    If (Not Active) Or
       (strCodAbf <> FieldByName('ABF_CODABF').AsString) Then
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODABF').AsString := strCodAbf;

      If Not fEmptyStr(strEstado) Then
        ParamByName('ESTADO').AsString := strEstado;

      Open;
    End;
  End;
  pAtribuiDisplayLabels(qryTabOri, qryTabela);
end;

procedure pPesquisaLinGru(qryTabOri, qryTabela: TUniQuery; strCodGru: String);
  Var
    strSQL: String;
begin
  strSQL := '';

  strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
  strSQL := strSQL + '  (SELECT L.GRU_DESGRU FROM CADGRU L WHERE L.GRU_CODGRU = CONCAT(LEFT(G.GRU_CODGRU, 3), "000")) AS DESLIN, ';
  strSQL := strSQL + '  G.*         ';
  strSQL := strSQL + 'FROM          ';
  strSQL := strSQL + '  CADGRU AS G ';
  strSQL := strSQL + 'WHERE         ';
  strSQL := strSQL + '  G.GRU_CODGRU = :CODGRU ';

  With qryTabela Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODGRU').AsString := strCodGru;
    Open;
  End;
  pAtribuiDisplayLabels(qryTabOri, qryTabela);
end;

procedure pPesquisaCadUni(qryTabOri, qryTabela: TUniQuery; strCodUni: String);
  Var
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
  strSQL := strSQL + '  * ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADUNI ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  UNI_CODUNI = :CODUNI ';

  With qryTabela Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODUNI').AsString := strCodUni;
    Open;
  End;
  pAtribuiDisplayLabels(qryTabOri, qryTabela);
end;

procedure pPesquisaCadEmp(qryTabOri, qryTabela: TUniQuery; strCodEmp: String);
  Var
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
  strSQL := strSQL + '  * ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADEMP ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  EMP_CODEMP = :CODEMP ';

  With qryTabela Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODEMP').AsString := strCodEmp;
    Open;
  End;
  If Assigned(qryTabOri) Then
    pAtribuiDisplayLabels(qryTabOri, qryTabela);
end;

procedure pPesquisaCadBco(qryTabOri, qryTabela: TUniQuery; strCodBco: String);
  Var
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
  strSQL := strSQL + '  * ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADBCO ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  BCO_CODBCO = :CODBCO ';

  With qryTabela Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODBCO').AsString := strCodBco;
    Open;
  End;
  pAtribuiDisplayLabels(qryTabOri, qryTabela);
end;

procedure pPesquisaCadIte(qryTabOri, qryTabela: TUniQuery; strCodIte: String; strCodFor: String = '';
  blnBuscaCodBar: Boolean = False; blnBuscaCodFab: Boolean = False; blnFiltraAtivo: Boolean = True;
  blnFiltrarExiLis: Boolean = True; blnFiltraDepProdAcab: Boolean = False; blnFiltraDepProdEmb: Boolean = False;
  blnFiltraDepProdGra: Boolean = False; blnFiltraDepMatPrim: Boolean = False; blnVeioF11: Boolean = False);
  Var
    strSQL: String;
  Begin

  strSQL := '';
  strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
  strSQL := strSQL + '  CADITE.*, ';
  strSQL := strSQL + '  IFNULL(BAR_CODBAR, "") AS BAR_CODBAR, ';
  strSQL := strSQL + '  IFNULL(BAR_DESCRI, "") AS BAR_DESCRI, ';
  strSQL := strSQL + '  IFNULL(BAR_EMBALA, 0)  AS BAR_EMBALA, ';
  strSQL := strSQL + '  IFNULL(BAR_PREVEN, 0)  AS BAR_PREVEN, ';
  strSQL := strSQL + '  IFNULL(BAR_TABPRE, "F") AS BAR_TABPRE, ';
  strSQL := strSQL + '  ITEGER.ITE_DTAULT, ';
  strSQL := strSQL + '  ITEGER.ITE_FORULT, ';
  strSQL := strSQL + '  ITEGER.ITE_PREULT, ';
  strSQL := strSQL + '  ITEGER.ITE_PREVE1, ';
  strSQL := strSQL + '  ITEGER.ITE_PREVE2, ';
  strSQL := strSQL + '  ITEGER.ITE_PREVE3, ';
  strSQL := strSQL + '  ITEGER.ITE_PREVE4, ';
  strSQL := strSQL + '  ITEGER.ITE_PREVE5, ';
  strSQL := strSQL + '  ITEGER.ITE_PREVE6, ';
  strSQL := strSQL + '  ITEGER.ITE_PREVE7, ';
  strSQL := strSQL + '  ITEGER.ITE_SALDOS, ';
  strSQL := strSQL + '  CADMAR.MAR_DESMAR, ';

  If (fCfgSis('EXIACA', varBoolean)) And (blnVeioF11) Then
    strSQL := strSQL + '  COALESCE(CADDEP.DEP_PROACA, "N") DEP_PROACA, ';

  If fCfgSis('TABPRF', varBoolean) Then
    strSQL := strSQL + '  IF(IFNULL(ITEFOR.ITE_CODFAB,"") = "", CADITE.ITE_CODFAB, ITEFOR.ITE_CODFAB) AS ITE_FABFOR '
  Else
    strSQL := strSQL + '  IF(IFNULL(ITEFOR.ITE_CODITF,"") = "", CADITE.ITE_CODFAB, ITEFOR.ITE_CODITF) AS ITE_FABFOR ';

  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADITE ';

  strSQL := strSQL + ' LEFT JOIN CADMAR ON CADMAR.MAR_CODMAR = CADITE.ITE_CODMAR ';

  If (fCfgSis('EXIACA', varBoolean)) And (blnVeioF11) Then
    strSQL := strSQL + 'LEFT JOIN CADDEP ON DEP_CODIGO = ITE_CODDEP ';

  strSQL := strSQL + ' LEFT JOIN ITEBAR ON CADITE.ITE_CODITE = BAR_CODITE AND ';

  If blnBuscaCodBar And (length(strCodIte) > fTamCodIte) Then
    strSQL := strSQL + '  BAR_CODBAR = :CODITE                         '
  Else
    strSQL := strSQL + '  FALSE                                        ';

  strSQL := strSQL + '  JOIN ITEGER ON ITEGER.ITE_CODITE = CADITE.ITE_CODITE AND ';
  strSQL := strSQL + '                 ITEGER.ITE_CODEMP = :CODEMP ';


  strSQL := strSQL + '  LEFT JOIN ITEFOR ON ';
  If Not fEmptyStr(strCodFor) Then
  Begin
    strSQL := strSQL + '     ITEFOR.ITE_CODITE = ITEGER.ITE_CODITE ';
    strSQL := strSQL + '                     AND ITEFOR.ITE_CODFOR = :CODFOR ';
    If fCfgSis('TABPRF', varBoolean) Then
    Begin
      strSQL := strSQL + '                  AND (SELECT COUNT(*) FROM TABPRE     ';
      strSQL := strSQL + '                       WHERE ITEFOR.ITE_CODTAB = TAB_CODTAB AND TAB_ATICMP = "S") > 0 ';
    End Else
    Begin
      strSQL := strSQL + '                  AND ITEFOR.AUTOINCREM = (SELECT MAX(FF.AUTOINCREM) FROM ITEFOR FF     ';
      strSQL := strSQL + '                       WHERE FF.ITE_CODITE = ITEGER.ITE_CODITE';
      strSQL := strSQL + '                       AND FF.ITE_CODFOR = :CODFOR )'
    End;
  End
  Else
    strSQL := strSQL + ' ITEFOR.AUTOINCREM IS NULL ';

  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  TRUE  ';

  If blnFiltraAtivo Then
    strSQL := strSQL + ' AND CADITE.ITE_ITEATI = "S" ';

  If blnFiltrarExiLis And (Not (fCfgSis('EXILIS', varBoolean))) Then
    strSQL := strSQL + '  AND ITEGER.ITE_IMPLIS = "S"  ';

  If blnBuscaCodBar Then
  Begin

    If length(strCodIte) > fTamCodIte Then
      strSQL := strSQL + '  AND BAR_CODBAR = :CODITE '
    Else
      strSQL := strSQL + '  AND CADITE.ITE_CODITE = :CODITE ';

  End

  Else If blnBuscaCodFab Then
  Begin
    strSQL := strSQL + '  AND (CADITE.ITE_CODFAB = :CODITE OR    ';

    If fCfgSis('TABPRF', varBoolean) Then
      strSQL := strSQL + '       (ITEFOR.ITE_CODFAB = :CODITE AND  '
    Else
      strSQL := strSQL + '       (ITEFOR.ITE_CODITF = :CODITE AND  ';

    strSQL := strSQL + '        ITEFOR.ITE_CODFOR = :CODFOR))    ';
  End

  Else
    strSQL := strSQL + '  AND CADITE.ITE_CODITE = :CODITE ';

  With qryTabela Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODITE').AsString := strCodIte;
    ParamByName('CODEMP').AsString := VS_strCodEmp;

    If (Params.FindParam('CODFOR') <> Nil) Then
      ParamByName('CODFOR').AsString := strCodFor;

    Open;
  End;
  pAtribuiDisplayLabels(qryTabOri, qryTabela);
end;

procedure pPesquisaDesSit(qryTabOri, qryTabela: TUniQuery; strCodIte: String);
  Var
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
  strSQL := strSQL + '  * ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  DESSIT ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  ITE_CODITE = :CODITE ';

  With qryTabela Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODITE').AsString := strCodIte;
    Open;
  End;

  If Assigned(qryTabOri) Then
    pAtribuiDisplayLabels(qryTabOri, qryTabela);
end;

procedure pPesquisaCadIteSemSemelhante(qryTabOri, qryTabela: TUniQuery; strCodIte: String;
  blnBuscaCodBar: Boolean = False; blnBuscaCodFab: Boolean = False; strFabAut: String = ''; blnCodBarEmb: Boolean = False;
  blnFiltrarExiLis: Boolean = True; strCodFor: String = '');
  Var
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
  strSQL := strSQL + '  CADITE.AUTOINCREM AS AUTITE, ';
  strSQL := strSQL + '  CADITE.*, ';
  strSQL := strSQL + '  IFNULL(BAR_CODBAR, "") AS BAR_CODBAR, ';
  strSQL := strSQL + '  IFNULL(BAR_EMBALA, 0)  AS BAR_EMBALA  ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADITE ';

  strSQL := strSQL + '  LEFT JOIN ITEBAR ON (BAR_CODITE=CADITE.ITE_CODITE) AND ';
  If blnBuscaCodBar Then
    strSQL := strSQL + '  BAR_CODBAR = :CODITE '
  Else
    strSQL := strSQL + '  FALSE                  ';

  strSQL := strSQL + '  JOIN ITEGER ON ITEGER.ITE_CODITE = CADITE.ITE_CODITE AND ';
  strSQL := strSQL + '                 ITEGER.ITE_CODEMP = :CODEMP ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  1=1 ';

  If blnFiltrarExiLis And (Not (fCfgSis('EXILIS', varBoolean))) Then
  Begin
    strSQL := strSQL + '  AND ITEGER.ITE_IMPLIS = "S" ';
  End;

  If blnBuscaCodBar Then
  Begin
    strSQL := strSQL + ' AND (BAR_CODBAR = :CODITE) '
  End
  Else If blnBuscaCodFab Then
  Begin
    If fEmptyStr(strFabAut) Then
    Begin
      strSQL := strSQL + ' AND (CADITE.ITE_CODFAB = :CODITE) ';

      If Not fEmptyStr(strCodFor) Then
        strSQL := strSQL + ' AND (CADITE.ITE_CODFOR = :CODFOR) ';
    End
    Else
      strSQL := strSQL + ' AND (CADITE.AUTOINCREM = :CODITE) ';
  End
  Else
    strSQL := strSQL + '  AND (CADITE.ITE_CODITE = :CODITE) ';

  strSQL := strSQL + ' GROUP BY CADITE.ITE_CODITE ';

  With qryTabela Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);

    If (Not blnBuscaCodBar) And blnBuscaCodFab And (Not fEmptyStr(strFabAut)) Then
    Begin
      ParamByName('CODITE').AsString := strFabAut;

      If Not fEmptyStr(strCodFor) Then
        ParamByName('CODFOR').AsString := strCodFor;
    End
    Else
      ParamByName('CODITE').AsString := strCodIte;

    ParamByName('CODEMP').AsString := VS_strCodEmp;
    Open;
  End;
  pAtribuiDisplayLabels(qryTabOri, qryTabela);
end;

procedure pPesquisaCadTra(qryTabOri, qryTabela: TUniQuery; strCodTra: String);
  Var
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
  strSQL := strSQL + '  * ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADTRA ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  TRA_CODTRA = :CODTRA ';

  With qryTabela Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODTRA').AsString := strCodTra;
    Open;
  End;
  pAtribuiDisplayLabels(qryTabOri, qryTabela);
end;

procedure pPesquisaCadTraCidFrete(qryTabOri, qryTabela: TUniQuery; strCodTra, strCodCid: String);
  Var
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
  strSQL := strSQL + '  T.* ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADTRA T ';
  strSQL := strSQL + '  INNER JOIN FRETRA F ON F.FRE_CODTRA = T.TRA_CODTRA ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  T.TRA_CODTRA = :CODTRA AND ';
  strSQL := strSQL + '  F.FRE_CODCID = :CODCID     ';

  With qryTabela Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODTRA').AsString := strCodTra;
    ParamByName('CODCID').AsString := strCodCid;
    Open;
  End;
  pAtribuiDisplayLabels(qryTabOri, qryTabela);
end;

procedure pPesquisaCadOpe(qryTabOri, qryTabela: TUniQuery; strCodOpe: String; blnBuscaPorSenha: Boolean = False; blnAtivos: Boolean = False);
  Var
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
  strSQL := strSQL + '  * ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADOPE ';
  strSQL := strSQL + 'WHERE ';
  If blnBuscaPorSenha Then
  Begin
    strCodOpe := fCrypt(strCodOpe);
    strSQL := strSQL + '  OPE_STATUS <> "I" AND ';
    strSQL := strSQL + '  BINARY OPE_SENOPE = :FILTRO '
  End
  Else
  Begin
    If blnAtivos Then
      strSQL := strSQL + '  OPE_STATUS <> "I" AND ';
    strSQL := strSQL + '  OPE_CODOPE = :FILTRO ';
  End;

  With qryTabela Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('FILTRO').AsString := strCodOpe;
    Open;
  End;

  If Assigned(qryTabOri) Then
    pAtribuiDisplayLabels(qryTabOri, qryTabela);
end;

procedure pPesquisaCadOpeBar(qryTabOri, qryTabela: TUniQuery; strCodOpe: String);
  Var
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  * ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADOPE ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  OPE_CODBAR = :CODBAR AND :CODBAR <> "" ';

  With qryTabela Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODBAR').AsString := strCodOpe;
    Open;
  End;

  If Assigned(qryTabOri) Then
    pAtribuiDisplayLabels(qryTabOri, qryTabela);
end;

procedure pPesquisaCadGpo(qryTabOri, qryTabela: TUniQuery; strCodGpo: String);
  Var
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
  strSQL := strSQL + '  * ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADGPO ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  GPO_CODGPO = :FILTRO ';

  With qryTabela Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('FILTRO').AsString := strCodGpo;
    Open;
  End;

  If Assigned(qryTabOri) Then
    pAtribuiDisplayLabels(qryTabOri, qryTabela);
end;

procedure pPesquisaCadCar(qryTabOri, qryTabela: TUniQuery; strCodCar: String);
  Var
    strSQL: String;
begin

  strSQL := '';
  strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
  strSQL := strSQL + '  * ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADCAR ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  CAR_CODCAR = :CODCAR ';

  With qryTabela Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODCAR').AsString := strCodCar;
    Open;
  End;
  pAtribuiDisplayLabels(qryTabOri, qryTabela);
end;

procedure pPesquisaCadDiv(qryTabOri, qryTabela: TUniQuery; strCodDiv: String);
  Var
    strSQL: String;
begin

  strSQL := '';
  strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
  strSQL := strSQL + '  * ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADDIV ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  DIV_CODDIV = :CODDIV ';

  With qryTabela Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODDIV').AsString := strCodDiv;
    Open;
  End;
  pAtribuiDisplayLabels(qryTabOri, qryTabela);
  
end;

procedure pPesquisaCadCfo(qryTabOri, qryTabela: TUniQuery; strCodCfo: String);
  Var
    strSQL: String;
begin

  strSQL := '';
  strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
  strSQL := strSQL + '  * ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADCFO ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  CFO_CODCFO = :CODCFO ';

  With qryTabela Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODCFO').AsString := strCodCfo;
    Open;
  End;
  pAtribuiDisplayLabels(qryTabOri, qryTabela);

end;

procedure pPesquisaCadEve(qryTabOri, qryTabela: TUniQuery; strCodEve: String);
  Var
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
  strSQL := strSQL + '  * ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADEVE ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  EVE_CODEVE = :CODEVE ';

  With qryTabela Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODEVE').AsString := strCodEve;
    Open;
  End;
  pAtribuiDisplayLabels(qryTabOri, qryTabela);
end;

procedure pPesquisaCadCnd(qryTabOri, qryTabela: TUniQuery; strCodCnd: String; fltMarDoc: Double = 0; fltValDoc: Double = 0;
  blnPerCnd: Boolean = False);
  Var
    strSQL: String;
    blnLibCnd: Boolean;
    blnListarSomenteCondicoesQueAtendamAsFaixas: Boolean;
begin
  blnLibCnd := True;

  strSQL := '';
  strSQL := strSQL + 'SELECT SQL_NO_CACHE ';

  blnListarSomenteCondicoesQueAtendamAsFaixas := False;

  If blnPerCnd Then
  Begin
    strSQL := strSQL + '  CADCND.*, ';

    If (fCfgSis('PFLCLI') = 'S') And
       (fCfgSis('CNDVEN') = 'F') Then
    Begin
      If (fCfgSis('LIBCND') = '1')            And
         ((fltMarDoc > 0) Or (fltValDoc > 0)) Then
      Begin
        blnListarSomenteCondicoesQueAtendamAsFaixas := True;
        blnLibCnd := True
      End
      Else
        blnLibCnd := False;
    End
    Else
      blnLibCnd := True;

    If blnLibCnd Then
      strSQL := strSQL + ' 0 AS SUB_PERCND '
    Else
      strSQL := strSQL + fRetornaSubQueryFaixasForaCondicao(fltMarDoc, fltValDoc) + ' AS SUB_PERCND ';
  End
  Else
  Begin
    If qryTabela.FindField('SUB_PERCND') <> Nil Then
      strSQL := strSQL + ' CADCND.*, 0 AS SUB_PERCND '
    Else
      strSQL := strSQL + ' CADCND.* ';
  End;

  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADCND ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  CND_CODIGO = :CODCND ';

  If ((fltMarDoc > 0) Or blnListarSomenteCondicoesQueAtendamAsFaixas) And blnLibCnd Then
  Begin
    strSQL := strSQL + '  AND ' + AnsiReplaceStr(FloatToStr(fltMarDoc), ',', '.');
    strSQL := strSQL + '  BETWEEN CND_MARMIN AND CND_MARMAX ';
  End;
  If ((fltValDoc > 0) Or blnListarSomenteCondicoesQueAtendamAsFaixas) And blnLibCnd Then
  Begin
    strSQL := strSQL + '  AND ' + AnsiReplaceStr(FloatToStr(fltValDoc), ',', '.');
    strSQL := strSQL + '  BETWEEN CND_FATMIN AND CND_FATMAX ';
  End;

  With qryTabela Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODCND').AsString := strCodCnd;
    Open;
  End;
  pAtribuiDisplayLabels(qryTabOri, qryTabela);
end;

procedure pPesquisaCadFpg(qryTabOri, qryTabela: TUniQuery; strCodFpg: String);
  Var
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
  strSQL := strSQL + '  * ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADFPG ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  FPG_CODIGO = :CODFPG ';

  With qryTabela Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODFPG').AsString := strCodFpg;
    Open;
  End;
  pAtribuiDisplayLabels(qryTabOri, qryTabela);
end;

procedure pPesquisaCadZon(qryTabOri, qryTabela: TUniQuery; strCodZon: String);
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
  strSQL := strSQL + '  * ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADZON ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  ZON_CODZON = :CODZON ';

  With qryTabela Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODZON').AsString := strCodZon;
    Open;
  End;
End;

procedure pPesquisaCadMot(qryTabOri, qryTabela: TUniQuery; strCodMot: String);
  Var
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
  strSQL := strSQL + '  * ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADMOT ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  MOT_CODMOT = :CODMOT ';

  With qryTabela Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODMOT').AsString := strCodMot;
    Open;
  End;
  pAtribuiDisplayLabels(qryTabOri, qryTabela);
end;

procedure pPesquisaCadReg(qryTabOri, qryTabela: TUniQuery; strCodReg: String);
  Var
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
  strSQL := strSQL + '  * ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADREG ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  REG_CODREG = :CODREG ';

  With qryTabela Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODREG').AsString := strCodReg;
    Open;
  End;
  pAtribuiDisplayLabels(qryTabOri, qryTabela);
end;

procedure pPesquisaCadEcf(qryTabOri, qryTabela: TUniQuery; strCodEcf: String);
  Var
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
  strSQL := strSQL + '  * ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADECF ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  ECF_CODECF = :CODECF ';

  With qryTabela Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODECF').AsString := strCodEcf;
    Open;
  End;
  pAtribuiDisplayLabels(qryTabOri, qryTabela);
end;

procedure pPesquisaCadSer(qryTabOri, qryTabela: TUniQuery; strCodSer: String);
  Var
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
  strSQL := strSQL + '  * ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADSER ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  SER_CODSER = :CODSER ';

  With qryTabela Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODSER').AsString := strCodSer;
    Open;
  End;
  pAtribuiDisplayLabels(qryTabOri, qryTabela);
end;

procedure pPesquisaCadSfz(qryTabOri, qryTabela: TUniQuery; strCodSfz: String);
  Var
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
  strSQL := strSQL + '  * ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADSFZ ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  SFZ_CODSFZ = :CODSFZ ';

  With qryTabela Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODSFZ').AsString := strCodSfz;
    Open;
  End;
  pAtribuiDisplayLabels(qryTabOri, qryTabela);
end;

procedure pPesquisaCadOco(qryTabOri, qryTabela: TUniQuery; strCodOco: String);
  Var
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
  strSQL := strSQL + '  * ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADOCO ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  OCO_CODOCO = :CODOCO ';

  With qryTabela Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODOCO').AsString := strCodOco;
    Open;
  End;

  If qryTabOri <> Nil Then
    pAtribuiDisplayLabels(qryTabOri, qryTabela);
end;

procedure pPesquisaCadGOc(qryTabOri, qryTabela: TUniQuery; strCodGoc: String);
  Var
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
  strSQL := strSQL + '  * ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADGOC ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  GOC_CODGOC = :CODGOC ';

  With qryTabela Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODGOC').AsString := strCodGoc;
    Open;
  End;
  pAtribuiDisplayLabels(qryTabOri, qryTabela);
end;

procedure pPesquisaCadToc(qryTabOri, qryTabela: TUniQuery; strCodToc: String; strCodGoc: String = ''; blnAtivas: Boolean = True);
  Var
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
  strSQL := strSQL + '  * ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADTOC ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  TOC_CODTOC = :CODTOC ';

  If blnAtivas Then
    strSQL := strSQL + '  AND TOC_ATIVO_ = "S" ';
    
  if not fEmptyStr(strCodGoc) then
    strSQL := strSQL + ' AND TOC_CODGOC = :CODGOC ';

  With qryTabela Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODTOC').AsString := strCodToc;
    if not fEmptyStr(strCodGoc) then
      ParamByName('CODGOC').AsString := strCodGoc;
    Open;
  End;
  pAtribuiDisplayLabels(qryTabOri, qryTabela);
end;

procedure pPesquisaCadCoc(qryTabOri, qryTabela: TUniQuery; strCodCoc: String; strCodToc: String = '');
  Var
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
  strSQL := strSQL + '  * ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADCOC ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  COC_CODCOC = :CODCOC ';

  if not fEmptyStr(strCodToc) then
    strSQL := strSQL + ' AND COC_CODTOC = :CODTOC ';

  With qryTabela Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODCOC').AsString := strCodCoc;
    if not fEmptyStr(strCodToc) then
      ParamByName('CODTOC').AsString := strCodToc;
    Open;
  End;
  pAtribuiDisplayLabels(qryTabOri, qryTabela);
end;

procedure pPesquisaCadCor(qryTabOri, qryTabela: TUniQuery; strCodCor: String);
  Var
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
  strSQL := strSQL + '  * ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADCOR ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  COR_CODCOR = :CODCOR ';

  With qryTabela Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODCOR').AsString := strCodCor;
    Open;
  End;
  pAtribuiDisplayLabels(qryTabOri, qryTabela);
end;

procedure pPesquisaCadBan(qryTabOri, qryTabela: TUniQuery; strCodBan: String);
  Var
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
  strSQL := strSQL + '  * ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADBAN ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  BAN_CODBAN = :CODBAN ';

  With qryTabela Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODBAN').AsString := strCodBan;
    Open;
  End;
  If Assigned(qryTabOri) Then
    pAtribuiDisplayLabels(qryTabOri, qryTabela);
end;

procedure pPesquisaCadLse(qryTabOri, qryTabela: TUniQuery; strCodLse: String);
  Var
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
  strSQL := strSQL + '  * ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADLSE ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  LSE_CODIGO = :CODLSE ';

  With qryTabela Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODLSE').AsString := strCodLse;
    Open;
  End;
  pAtribuiDisplayLabels(qryTabOri, qryTabela);
end;

procedure pPesquisaCadEqu(qryTabOri, qryTabela: TUniQuery; strCodEqu: String);
  Var
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
  strSQL := strSQL + '  *                 ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADEQU ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  EQU_CODIGO = :CODEQU ';

  With qryTabela Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODEQU').AsString := strCodEqu;
    Open;
  End;
  pAtribuiDisplayLabels(qryTabOri, qryTabela);
end;


end.

