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

uses Uni, Classes, SysUtils, StrUtils, Produto.TSQLProdutos;

  {*******************************************}
  {* FUNÇÃO AUXILIAR PARA FORMATAR OS CAMPOS *}
  {****************************************MV*}
  procedure pAtribuiDisplayLabels(qryTabOri, qryTabDest: TUniQuery);

  procedure pPesquisaCadAti(qryTabOri, qryTabela: TUniQuery; strCodAti: String);
  procedure pPesquisaCadCid(qryTabOri, qryTabela: TUniQuery; strCodCid: String);
  procedure pPesquisaCadTri(qryTabOri, qryTabela: TUniQuery; strCodTri: String);
  procedure pPesquisaCadVen(qryTabOri, qryTabela: TUniQuery; strCodVen: String; blnBuscaPorSenha: Boolean = False);
  procedure pPesquisaCadPor(qryTabOri, qryTabela: TUniQuery; strCodPor: String);
  procedure pPesquisaCadPrj(qryTabOri, qryTabela: TUniQuery; strCodPrj: String);
  procedure pPesquisaTipPrj(qryTabOri, qryTabela: TUniQuery; strCodTip: String);
  procedure pPesquisaCadCta(qryTabOri, qryTabela: TUniQuery; strCodCta: String; blnUsaCtf: Boolean = False; strCodFor: String = '');
  procedure pPesquisaCadCli(qryTabOri, qryTabela: TUniQuery; strCodCli: String; blnVerCnd: Boolean = True; blnVerCli: Boolean = False; strCodOpe: String = ''; strOpcDoc: string = '');
  procedure pPesquisaCadFor(qryTabOri, qryTabela: TUniQuery; strCodFor: String; blnBuscaCnpj: Boolean = False);
  procedure pPesquisaCadFun(qryTabOri, qryTabela: TUniQuery; strCodFun: String);
  procedure pPesquisaCadMar(qryTabOri, qryTabela: TUniQuery; strCodMar: String; blnAtivas: Boolean = True);
  procedure pPesquisaAbfIcm(qryTabOri, qryTabela: TUniQuery; strCodAbf: String; strEstado: String = '');
  procedure pPesquisaLinGru(qryTabOri, qryTabela: TUniQuery; strCodGru: String);
  procedure pPesquisaCadUni(qryTabOri, qryTabela: TUniQuery; strCodUni: String);
  procedure pPesquisaCadEmp(qryTabOri, qryTabela: TUniQuery; strCodEmp: String);
  procedure pPesquisaCadBco(qryTabOri, qryTabela: TUniQuery; strCodBco: String);
  procedure pPesquisaCadIte(qryTabOri,
                            qryTabela            : TUniQuery;
                            strCodIte            : String;
                            strCodFor            : String  = '';
                            blnBuscaCodBar       : Boolean = False;
                            blnBuscaCodFab       : Boolean = False;
                            blnFiltraAtivo       : Boolean = True;
                            blnFiltrarExiLis     : Boolean = True;
                            blnFiltraDepProdAcab : Boolean = False;
                            blnFiltraDepProdEmb  : Boolean = False;
                            blnFiltraDepProdGra  : Boolean = False;
                            blnFiltraDepMatPrim  : Boolean = False;
                            blnVeioF11           : Boolean = False;
                            blnProdutoDiluente   : Boolean = False;
                            blnTestarCFG_EXILIS  : Boolean = True;
                            blnPedCom            : Boolean = False);

  procedure pPesquisaCadFnc(ATabOri, ATabela: TUniQuery; ACodFuncao: String;
                          AAutoIncrem: String = '');

  procedure pPesquisaExataITE_PESQUI(qryTabOri, qryTabela: TUniQuery; strCodIte, strCodEmp: string);

  procedure pPesquisaCadSem(qryTabOri, qryTabela: TUniQuery; strCodIte, strCodFor: String; blnBuscaCodBar: Boolean = False; blnBuscaCodFab:
    Boolean = False; strFabAut: String = ''; blnCodBarEmb: Boolean = False; blnFiltrarExiLis: Boolean = True;
     blnLikeCodFab: Boolean = True; strCodEmp: String = ''; blnSomenteCodFabrica: Boolean = False);

  procedure pPesquisaDesSit(qryTabOri, qryTabela: TUniQuery; strCodIte: String);

  procedure pPesquisaCadIteSemSemelhante(qryTabOri, qryTabela: TUniQuery; strCodIte: String;
              blnBuscaCodBar: Boolean = False; blnBuscaCodFab: Boolean = False; strFabAut: String = ''; blnCodBarEmb: Boolean = False;
              blnFiltrarExiLis: Boolean = True; strCodFor: String = '');
  
  procedure pPesquisaCadTra(qryTabOri, qryTabela: TUniQuery; strCodTra: String; strAtiva: String = '');
  procedure pPesquisaCadTraCidFrete(qryTabOri, qryTabela: TUniQuery; strCodTra, strCodCid: String; strAtiva: String = '');
  procedure pPesquisaCadTraRegFrete(qryTabOri, qryTabela: TUniQuery; strCodTra, strCodReg: String; strAtiva: String = '');
  procedure pPesquisaCadOpe(qryTabOri, qryTabela: TUniQuery; strCodOpe: String; blnBuscaPorSenha: Boolean = False; blnAtivos: Boolean = False; blnVendedorEmpLog: Boolean = False);
  procedure pPesquisaCadVei(qryTabOri, qryTabela: TUniQuery; strCodVei: String);
  procedure pPesquisaCadAju(qryTabOri, qryTabela: TUniQuery; strCodAju: String);
  procedure pPesquisaLayCfs(qryTabOri, qryTabela: TUniQuery; strCodigo: String);
  procedure pPesquisaCadOpeBar(qryTabOri, qryTabela: TUniQuery; strCodOpe: String);
  procedure pPesquisaCadGpo(qryTabOri, qryTabela: TUniQuery; strCodGpo: String);
  procedure pPesquisaCadCar(qryTabOri, qryTabela: TUniQuery; strCodCar: String);
  procedure pPesquisaCadDiv(qryTabOri, qryTabela: TUniQuery; strCodDiv: String);
  procedure pPesquisaCadZon(qryTabOri, qryTabela: TUniQuery; strCodZon: String);
  procedure pPesquisaCadCfo(qryTabOri, qryTabela: TUniQuery; strCodCfo: String);
  procedure pPesquisaCadEve(qryTabOri, qryTabela: TUniQuery; strCodEve: String);
  procedure pPesquisaCadCnd(qryTabOri, qryTabela: TUniQuery; strCodCnd: String; fltMarDoc: Double = 0; fltValDoc: Double = 0; blnPerCnd: Boolean = False; strCodCli: String = ''; blnIgnMar: Boolean = False);
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
  procedure pPesquisaCadProspe(qryTabOri, qryTabela: TUniQuery; strCodPro: String);
  procedure pPesquisaCadLot(qryTabOri, qryTabela: TUniQuery; strAutInc: String);
  procedure pPesquisaCadTfu(qryTabOri, qryTabela: TUniQuery; strCodTfu: String);

implementation

uses untfuncoesSimples, Data.DB, untConsultas, untFuncoesGenerica, untFuncoesGenCompartilhada;

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

procedure pPesquisaCadPrj(qryTabOri, qryTabela: TUniQuery; strCodPrj: String);
  Var
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
  strSQL := strSQL + '  * ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADPRJ ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  PRJ_CODPRJ = :CODPRJ ';

  With qryTabela Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODPRJ').AsString := strCodPrj;
    Open;
  End;

  If qryTabOri <> Nil Then
    pAtribuiDisplayLabels(qryTabOri, qryTabela);
end;

procedure pPesquisaTipPrj(qryTabOri, qryTabela: TUniQuery; strCodTip: String);
  Var
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
  strSQL := strSQL + '  * ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  TIPPRJ ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  TIP_CODTIP = :CODTIP ';

  With qryTabela Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODTIP').AsString := strCodTip;
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

procedure pPesquisaCadCli(qryTabOri,
                          qryTabela: TUniQuery;
                          strCodCli: String;
                          blnVerCnd: Boolean = True;
                          blnVerCli: Boolean = False;
                          strCodOpe: String = '';
                          strOpcDoc: string = '');
  Var
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
  strSQL := strSQL + '  CADCLI.* ';
  If (blnVerCnd) Then
    strSQL := strSQL + ', CND_CODCND, CND_CNDPAG ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADCLI ';

  If (blnVerCnd) Then
  Begin
    strSQL := strSQL + '  LEFT JOIN CLICND ON CLI_CODCLI = CND_CODCLI AND CND_SUGEST = "S" AND ';

    If fCfgSis('USACND', varBoolean) Then
      strSQL := strSQL + ' CND_CODCND IS NOT NULL '
    Else
      strSQL := strSQL + ' IFNULL(CND_CNDPAG, "") <> "" ';
  End;

  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  CLI_CODCLI = :CODCLI ';

  If (blnVerCli) And (Not fVerificaAcessoSistema('VERCLI')) Then
  Begin
    strSQL := strSQL + '  AND (CLI_CODVEN IN (' + fGetVendedoresGerentesOrSUBGerentes + '"' + strLoginUsuarioLogado + '") ';

    If (fCfgSis('VEESFT', varBoolean)) And (Not fEmptyStr(fCfgSis('VENESP'))) Then
      strSQL := strSQL + '    OR CLI_CODVEN = ' + QuotedStr(fCfgSis('VENESP'));

    strSQL := strSQL + '    OR CLI_CODREP IN (' + fGetVendedoresGerentesOrSUBGerentes + '"' + strLoginUsuarioLogado + '") ';
    strSQL := strSQL + '    OR "'+ strLoginUsuarioLogado +'" IN('+fRetornaVendedoresDaCliVen(strCodCli)+'))';
  End;

  if (fCfgSis('VENOUT', varBoolean)) and (Pos(strOpcDoc, 'ER_ET_') > 0) then
  begin
    strSQL := strSQL + ' AND CLI_REMOUT = "S" ';
  end;

  if (fCfgSis('VENOUT', varBoolean)) and (Pos(strOpcDoc, 'EM_') > 0) then
  begin
    strSQL := strSQL + ' AND CLI_REMOUT = "N" ';
  end;

  if strCodOpe = '' Then
    strCodOpe := strLoginUsuarioLogado;

  strSQL := strSQL + fGetFiltroClienteEmpresaIdentificadora(strCodOpe);

  With qryTabela Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODCLI').AsString := strCodCli;
    Open;
  End;

  If Assigned(qryTabOri) Then
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

procedure pPesquisaCadFun(qryTabOri, qryTabela: TUniQuery; strCodFun: String);
  Var
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
  strSQL := strSQL + '  * ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADFUN ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  FUN_CODFUN = :CODFUN ';

  With qryTabela Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODFUN').AsString := strCodFun;
    Open;
  End;
  pAtribuiDisplayLabels(qryTabOri, qryTabela);
end;

procedure pPesquisaCadMar(qryTabOri, qryTabela: TUniQuery; strCodMar: String; blnAtivas: Boolean = True);
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
  If blnAtivas Then
    strSQL := strSQL + ' AND CADMAR.MAR_ATIVA_ = "S" ';

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

procedure pPesquisaCadFnc(ATabOri, ATabela: TUniQuery; ACodFuncao: String;
                          AAutoIncrem: String = '');
  Var
    LSQL: String;
begin
  LSQL := '';
  LSQL := LSQL + 'SELECT SQL_NO_CACHE ';
  LSQL := LSQL + '  * ';
  LSQL := LSQL + 'FROM ';
  LSQL := LSQL + '  CADFNC ';
  LSQL := LSQL + 'WHERE ';
  LSQL := LSQL + '  FNC_CODFNC = :CODFNC ';

  If Not AAutoIncrem.IsEmpty Then
    LSQL := LSQL + ' AND AUTOINCREM = "' + AAutoIncrem + '"';

  ATabela.Close;
  ATabela.SQL.Text := LSQL;
  ATabela.ParamByName('CODFNC').AsString := ACodFuncao;
  ATabela.Open;

  If Assigned(ATabOri) Then
    pAtribuiDisplayLabels(ATabOri, ATabela);
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

procedure pPesquisaCadIte(qryTabOri,
                          qryTabela            : TUniQuery;
                          strCodIte            : String;
                          strCodFor            : String  = '';
                          blnBuscaCodBar       : Boolean = False;
                          blnBuscaCodFab       : Boolean = False;
                          blnFiltraAtivo       : Boolean = True;
                          blnFiltrarExiLis     : Boolean = True;
                          blnFiltraDepProdAcab : Boolean = False;
                          blnFiltraDepProdEmb  : Boolean = False;
                          blnFiltraDepProdGra  : Boolean = False;
                          blnFiltraDepMatPrim  : Boolean = False;
                          blnVeioF11           : Boolean = False;
                          blnProdutoDiluente   : Boolean = False;
                          blnTestarCFG_EXILIS  : Boolean = True;
                          blnPedCom            : Boolean = False);

  Function fBuscaPeloCodigoDeBarras : Boolean;
  Begin
    If Not blnBuscaCodBar Then
    Begin
      Result := False;
      Exit;
    End;

    If (fCfgSis('ITEBAR', varString) = 'S') Then
      Result := True
    Else
      Result := Length(strCodIte) > fTamCodIte;
  End;

Var
  strSQL: String;
  objSQLProdutos: TSQLProdutos;
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
  strSQL := strSQL + '  IFNULL(ITEGER.ITE_SALEXT, 0) AS ITE_SALEXT, ';

  strSQL := strSQL + '  ITEGER.ITE_CICMDE, ';
  strSQL := strSQL + '  ITEGER.ITE_CDPIOP, ';
  strSQL := strSQL + '  ITEGER.ITE_DIDIOP, ';
  strSQL := strSQL + '  CADITE.ITE_CODFAB, ';

  If fCfgSIs('IMPDIG') = '1' Then
    strSQL := strSQL + '  CADITE.ITE_IMPDIR, '
  Else
    strSQL := strSQL + '  ITEGER.ITE_IMPDIR, ';

  strSQL := strSQL + '  CADMAR.MAR_DESMAR, ';
  strSQL := strSQL + '  CADITE.ITE_CILVAS, ';

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

  If fBuscaPeloCodigoDeBarras Then
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

      If blnBuscaCodFab Then
        strSQL := strSQL + '       AND FF.ITE_CODITF = :CODITE ';

      strSQL := strSQL + '                       AND FF.ITE_CODFOR = :CODFOR )'
    End;
  End
  Else
    strSQL := strSQL + ' ITEFOR.AUTOINCREM IS NULL ';

  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  TRUE  ';

  If blnFiltraAtivo Then
    strSQL := strSQL + ' AND CADITE.ITE_ITEATI = "S" ';

  If blnPedCom Then
  Begin
    If blnFiltrarExiLis And ((Not blnTestarCFG_EXILIS) Or (Not (fCfgSis('EXILCC', varBoolean)))) Then
      strSQL := strSQL + '  AND ITEGER.ITE_IMPLIS = "S"  ';
  End
  Else
  Begin
    If blnFiltrarExiLis And ((Not blnTestarCFG_EXILIS) Or (Not (fCfgSis('EXILIS', varBoolean)))) Then
      strSQL := strSQL + '  AND ITEGER.ITE_IMPLIS = "S"  ';
  End;

  If fBuscaPeloCodigoDeBarras Then
  Begin
    strSQL := strSQL + '  AND BAR_CODBAR = :CODITE '
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

  If blnFiltraDepProdAcab Then //Filtra o departamento de produtos acabados (modulo industrial)
  Begin
//    strSQL := strSQL + '  AND CADITE.ITE_CODDEP = ' + QuotedStr(fCfgSis('PROACA')) + ' ';
    strSQL := strSQL + '  AND CADITE.ITE_CODDEP IN (' + fRetTipoDepartamentoVarios('PROACA') + ') ';
  End;

  If blnFiltraDepProdEmb Then //Filtra o departamento de produtos embalagens (modulo industrial)
  Begin
//    strSQL := strSQL + '  AND CADITE.ITE_CODDEP = ' + QuotedStr(fCfgSis('PROEMB')) + ' ';
    strSQL := strSQL + '  AND CADITE.ITE_CODDEP IN (' + fRetTipoDepartamentoVarios('PROEMB') + ') ';
  End;

  If blnFiltraDepProdGra Then //Filtra o departamento de produtos granel (modulo industrial)
  Begin
//    strSQL := strSQL + '  AND CADITE.ITE_CODDEP = ' + QuotedStr(fCfgSis('PROGRA')) + ' ';
    strSQL := strSQL + '  AND CADITE.ITE_CODDEP IN (' + fRetTipoDepartamentoVarios('PROGRA') + ') ';
  End;

  If blnFiltraDepMatPrim Then //Filtra o departamento de matéria prima (modulo industrial)
  Begin
//    strSQL := strSQL + '  AND CADITE.ITE_CODDEP = ' + QuotedStr(fCfgSis('PROMAP')) + ' ';
    strSQL := strSQL + '  AND CADITE.ITE_CODDEP IN (' + fRetTipoDepartamentoVarios('PROMAP') + ') ';
  End;

  If blnProdutoDiluente Then
  Begin
    objSQLProdutos:=TSQLProdutos.Create;
    Try
      strSQL := strSQL + objSQLProdutos.fRetornaFiltroSQLComponenteFormulacaoB;
    Finally
      FreeAndNil(objSQLProdutos);
    End;
  End;


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

procedure pPesquisaExataITE_PESQUI(qryTabOri, qryTabela: TUniQuery; strCodIte, strCodEmp: string);
var
  LSQL: string;
  LAux: string;
begin
  LSQL := '';
  LSQL := LSQL + ' SELECT SQL_NO_CACHE                     ';
  LSQL := LSQL + '   CADITE.AUTOINCREM AS AUTITE,          ';
  LSQL := LSQL + '   CAST("" AS CHAR(1)) AS AUTSEM,        ';
  LSQL := LSQL + '   CAST("" AS CHAR(1)) AS BARSEM,        ';
  LSQL := LSQL + '   CADITE.*,                             ';
  LSQL := LSQL + '   ITEGER.ITE_LOCFIS,                    ';
  LSQL := LSQL + '   IFNULL(BAR_CODBAR, "") AS BAR_CODBAR, ';
  LSQL := LSQL + '   IFNULL(BAR_DESCRI, "") AS BAR_DESCRI, ';
  LSQL := LSQL + '   IFNULL(BAR_EMBALA, 0)  AS BAR_EMBALA, ';
  LSQL := LSQL + '   IFNULL(BAR_PREVEN, 0)  AS BAR_PREVEN, ';
  LSQL := LSQL + '   IFNULL(BAR_TABPRE, "") AS BAR_TABPRE, ';
  LSQL := LSQL + '   IFNULL(MAR_DESMAR, "") AS MAR_DESMAR, ';
  LSQL := LSQL + '   CADITE.ITE_CODFAB AS ITE_CODFAB,      ';
  LSQL := LSQL + '   CADUNI.UNI_SIGUNI                     ';
  LSQL := LSQL + ' FROM ';
  LSQL := LSQL + '   CADITE ';
  LSQL := LSQL + '   LEFT JOIN ITEBAR ON (BAR_CODITE = CADITE.ITE_CODITE) AND FALSE ';
  LSQL := LSQL + '   JOIN ITEGER ON ITEGER.ITE_CODITE = CADITE.ITE_CODITE AND ITEGER.ITE_CODEMP = :CODEMP ';
  LSQL := LSQL + '   LEFT JOIN CADUNI ON (CADUNI.UNI_CODUNI = CADITE.ITE_CODUNI) ';
  LSQL := LSQL + '   LEFT JOIN CADMAR ON MAR_CODMAR = CADITE.ITE_CODMAR ';
  LSQL := LSQL + '   LEFT JOIN ITEFOR ON ITEFOR.ITE_CODITE = ITEGER.ITE_CODITE ';

  If fCfgSis('TABPRF', varBoolean) Then
  Begin
    LSQL := LSQL + '     AND (SELECT COUNT(*) ';
    LSQL := LSQL + '            FROM TABPRE   ';
    LSQL := LSQL + '           WHERE ITEFOR.ITE_CODTAB = TAB_CODTAB ';
    LSQL := LSQL + '             AND TAB_ATICMP = "S") > 0 ';
  End;

  If Pos('%', strCodIte) = 0 Then
  Begin
    LAux := strCodIte;
    LAux := AnsiReplaceStr(LAux, '%', '_');
    LAux := AnsiReplaceStr(LAux, '*', '_');
    LAux := AnsiReplaceStr(LAux, '-', '_');
    LAux := AnsiReplaceStr(LAux, '+', '_');
    LAux := AnsiReplaceStr(LAux, '/', '_');
    LAux := AnsiReplaceStr(LAux, '\', '_');
    LAux := AnsiReplaceStr(LAux, '.', '_');
    LAux := AnsiReplaceStr(LAux, '(', '_');
    LAux := AnsiReplaceStr(LAux, ')', '_');
    LAux := AnsiReplaceStr(LAux, '>', '_');
    LAux := AnsiReplaceStr(LAux, '<', '_');
    LAux := AnsiReplaceStr(LAux, '"', '_');
    LAux := AnsiReplaceStr(LAux, '~', '_');
    LAux := '| _' + Trim(LAux) + '_ |';

    LSQL := LSQL + ' WHERE TRUE ';
    LSQL := LSQL + '   AND CADITE.ITE_ITEATI = "S" ';

    If Not fCfgSis('EXILIS', varBoolean) Then
      LSQL := LSQL + '   AND ITEGER.ITE_IMPLIS = "S" ';

    LSQL := LSQL + '   AND MATCH (ITE_PESQUI) AGAINST (' + QuotedStr('+' + LAux + '*') + ' IN BOOLEAN MODE)';
    LSQL := LSQL + ' GROUP BY ';
    LSQL := LSQL + '   CADITE.ITE_CODITE ';
    LSQL := LSQL + ' HAVING TRUE ';
    LSQL := LSQL + '    AND ITE_PESQUI LIKE ' + QuotedStr('%' + LAux + '%');
    LSQL := LSQL + '    AND ITE_PESQUI LIKE ' + QuotedStr('%' + strCodIte + '%');
  End
  Else
  Begin
    LSQL := LSQL + ' WHERE TRUE ';
    LSQL := LSQL + '   AND CADITE.ITE_ITEATI = "S" ';

    If Not fCfgSis('EXILIS', varBoolean) Then
      LSQL := LSQL + '   AND ITEGER.ITE_IMPLIS = "S" ';

    LSQL := LSQL + '   AND ITE_PESQUI LIKE ' + QuotedStr('%' + strCodIte + '%');
    LSQL := LSQL + ' GROUP BY ';
    LSQL := LSQL + '   CADITE.ITE_CODITE ';
  End;

  With qryTabela Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(LSQL);
    If Not fEmptyStr(strCodEmp) Then
      ParamByName('CODEMP').AsString := strCodEmp
    Else
      ParamByName('CODEMP').AsString := VS_strCodEmp;
    Open;
  End;

  pAtribuiDisplayLabels(qryTabOri, qryTabela);
end;

procedure pPesquisaCadSem(qryTabOri,
                          qryTabela        : TUniQuery;
                          strCodIte,
                          strCodFor        : String;
                          blnBuscaCodBar   : Boolean = False;
                          blnBuscaCodFab   : Boolean = False;
                          strFabAut        : String  = '';
                          blnCodBarEmb     : Boolean = False;
                          blnFiltrarExiLis : Boolean = True;
                          blnLikeCodFab    : Boolean = True;
                          strCodEmp        : String  = '';
                          blnSomenteCodFabrica: Boolean = False);
  Var
    strSQL    : String;
    strIteSer : String;
    strUnion  : String;

  function fGetSelectCadSem(blnNoCache : Boolean = True; intOpcao : Integer = 0): String;
  begin
    Result := '';

    If blnNoCache Then
      Result := Result + 'SELECT SQL_NO_CACHE '
    Else
      Result := Result + 'SELECT ';

    Result := Result + '  CADITE.AUTOINCREM AS AUTITE, ';
    If fCfgSis('UTISEM', varBoolean) Then
    begin
      Result := Result + '  CADSEM.AUTOINCREM AS AUTSEM, ';
      Result := Result + '  CADSEM.SEM_CODBAR AS BARSEM, ';
    end
    else
    begin
      Result := Result + '  CAST("" AS CHAR(1)) AS AUTSEM, ';
      Result := Result + '  CAST("" AS CHAR(1)) AS BARSEM, ';
    end;
    Result := Result + '  CADITE.*,                    ';
    Result := Result + '  ITEGER.ITE_LOCFIS,           ';
    Result := Result + '  IFNULL(BAR_CODBAR, "") AS BAR_CODBAR, ';
    Result := Result + '  IFNULL(BAR_DESCRI, "") AS BAR_DESCRI, ';
    Result := Result + '  IFNULL(BAR_EMBALA, 0)  AS BAR_EMBALA, ';
    Result := Result + '  IFNULL(BAR_PREVEN, 0)  AS BAR_PREVEN, ';
    Result := Result + '  IFNULL(BAR_TABPRE, "") AS BAR_TABPRE, ';
    Result := Result + '  IFNULL(MAR_DESMAR, "") AS MAR_DESMAR ';
    If blnBuscaCodFab Then
    Begin
      Case intOpcao Of

        1: Result := Result + ', CADITE.ITE_CODFAB  AS CODFAB ';

        2: Result := Result + ', CADITE.ITE_CODFAB AS CODFAB ';

        3: Result := Result + ', CADITE.ITE_CODFAB AS CODFAB ';

        4: Begin

             If fCfgSis('TABPRF', varBoolean) Then
               Result := Result + ', ITEFOR.ITE_CODFAB AS CODFAB '
             Else
               Result := Result + ', ITEFOR.ITE_CODITF AS CODFAB ';
           End;

        5: Result := Result + ', CADITE.ITE_CODFAB AS CODFAB ';

      End;
    End
    Else
     Result := Result + ', CADITE.ITE_CODFAB AS ITE_CODFAB ';

    Result := Result + ', CADUNI.UNI_SIGUNI ';
  End;


  function fGetFromCadSem: String;
  begin
    Result := '';

    If blnBuscaCodBar Then
    Begin
      Result := Result + ' FROM ITEBAR ';
      Result := Result + ' JOIN CADITE ON CADITE.ITE_CODITE = ITEBAR.BAR_CODITE ';
    End
    Else
    Begin
      Result := Result + ' FROM CADITE ';
      Result := Result + ' LEFT JOIN ITEBAR ON (BAR_CODITE = CADITE.ITE_CODITE) AND FALSE ';
    End;

    Result := Result + '  JOIN ITEGER ON ITEGER.ITE_CODITE = CADITE.ITE_CODITE ';
    Result := Result + '             AND ITEGER.ITE_CODEMP = :CODEMP ';

    If fCfgSis('UTISEM', varBoolean) Then
      Result := Result + '  LEFT JOIN CADSEM ON (SEM_CODITE = CADITE.ITE_CODITE) ';

    Result := Result + '  LEFT JOIN ITEFOR ON ITEFOR.ITE_CODITE = ITEGER.ITE_CODITE ';
    If fCfgSis('TABPRF', varBoolean) Then
    Begin
      Result := Result + '                  AND (SELECT COUNT(*) ';
      Result := Result + '                         FROM TABPRE   ';
      Result := Result + '                        WHERE ITEFOR.ITE_CODTAB = TAB_CODTAB ';
      Result := Result + '                          AND TAB_ATICMP = "S") > 0 ';
    End;

    Result := Result + '  LEFT JOIN CADUNI ON (CADUNI.UNI_CODUNI = CADITE.ITE_CODUNI) ';
    Result := Result + '  LEFT JOIN CADMAR ON MAR_CODMAR = CADITE.ITE_CODMAR ';
  end;

  function fGetWhereCadSem_CodBar(intOpcao : Integer): String;
  begin

    Result := '';
    Result := Result + 'WHERE TRUE ';

    If blnFiltrarExiLis And (Not (fCfgSis('EXILIS', varBoolean))) And (Not fEhItemServico(strIteSer)) Then
      Result := Result + '  AND ITEGER.ITE_IMPLIS = "S" ';

    Case intOpcao Of
      1: Result := Result + ' AND BAR_CODBAR = :CODITE';
      2:
      begin
        If fCfgSis('UTISEM', varBoolean) Then
          Result := Result + ' AND SEM_CODBAR = :CODITE'
        Else
          Result := Result + ' AND FALSE';
      end;
    End;

  end;

  function fGetWhereCadSem: String;
  begin
    Result := '';
    Result := Result + 'WHERE TRUE ';

    If blnFiltrarExiLis And (Not (fCfgSis('EXILIS', varBoolean))) And (Not fEhItemServico(strIteSer)) Then
      Result := Result + '  AND ITEGER.ITE_IMPLIS = "S" ';

    If blnBuscaCodBar Then
    begin
      If fCfgSis('UTISEM', varBoolean) Then
        Result := Result + ' AND (BAR_CODBAR = :CODITE OR SEM_CODBAR = :CODITE) '
      else
        Result := Result + ' AND BAR_CODBAR = :CODITE '
    end
    Else If blnBuscaCodFab Then
    Begin
      If fEmptyStr(strFabAut) Then
      Begin
        Result := Result + '  AND (CADITE.ITE_CODFAB LIKE :CODITE    ';

        If Not blnSomenteCodFabrica Then
        Begin
          Result := Result + '       OR CADITE.ITE_CODITE LIKE :CODITE    ';
          If fCfgSis('UTISEM', varBoolean) Then
            Result := Result + '       OR SEM_CODSEM        LIKE :CODITE    ';
        End;

        If fCfgSis('TABPRF', varBoolean) Then
          Result := Result + '      OR (ITEFOR.ITE_CODFAB LIKE :CODITE     '
        Else
          Result := Result + '      OR (ITEFOR.ITE_CODITF LIKE :CODITE     ';

        If not fEmptyStr(strCodFor) Then
          Result := Result + '      AND ITEFOR.ITE_CODFOR = :CODFOR ))   '
        Else
          Result := Result + ' )) ';

      End
      Else
        Result := Result + '  AND (CADITE.AUTOINCREM LIKE :CODITE) ';
    End
    Else
      Result := Result + '  AND CADITE.ITE_CODITE = :CODITE ';
  end;

  function fGetWhereCadSem_(intOpcao : Integer): String;
  begin

    Result := '';
    Result := Result + 'WHERE TRUE';

    If blnFiltrarExiLis And (Not (fCfgSis('EXILIS', varBoolean))) And (Not fEhItemServico(strIteSer)) Then
      Result := Result + ' AND ITEGER.ITE_IMPLIS = "S" ';

    Case intOpcao Of

      1: Result := Result + ' AND CADITE.ITE_CODFAB LIKE :CODITE';

      2: Result := Result + ' AND CADITE.ITE_CODITE LIKE :CODITE';

      3: begin
           If fCfgSis('UTISEM', varBoolean) Then
             Result := Result + ' AND SEM_CODSEM LIKE :CODITE'
           Else
             Result := Result + ' AND FALSE';
         end;

      4: Begin

           If fCfgSis('TABPRF', varBoolean) Then
             Result := Result + ' AND ITEFOR.ITE_CODFAB LIKE :CODITE'
           Else
             Result := Result + ' AND ITEFOR.ITE_CODITF LIKE :CODITE';

           If Not fEmptyStr(strCodFor) Then
             Result := Result + ' AND ITEFOR.ITE_CODFOR = :CODFOR';

         End;

      5: Result := Result + ' AND CADITE.ITE_FABRIC LIKE :FABRIC';

    End;

  end;

  function fGetGroupByCadSem: String;
  begin
    Result := ' GROUP BY CADITE.ITE_CODITE ';
  end;

  const
    strCONFIGURACAO_PARTIAL_KEY_UTILIZA_LIKE = '1';
begin

  If blnBuscaCodBar Then
    strIteSer := fRetCodIte(strCodIte)
  Else
    strIteSer := strCodIte;

  If (blnBuscaCodFab) And Not(blnBuscaCodBar) And fEmptyStr(strFabAut) Then
  Begin
    If fCfgSis('ITPFAB', VarBoolean) And (fCfgSis('ITPMOD') = '2') Then
    Begin
      pPesquisaExataITE_PESQUI(qryTabOri, qryTabela, strCodIte, strCodEmp);
      Exit;
    End;

    strSQL := 'SELECT SQL_NO_CACHE * FROM ( ';

    strUnion := '';
    strUnion := strUnion + fGetSelectCadSem(False, 1);
    strUnion := strUnion + fGetFromCadSem;
    strUnion := strUnion + fGetWhereCadSem_(1);

    strSQL := strSQL + strUnion;

    If Not blnSomenteCodFabrica Then
    Begin
      strSQL := strSQL + ' UNION ';

      strUnion := '';
      strUnion := strUnion + fGetSelectCadSem(False, 2);
      strUnion := strUnion + fGetFromCadSem;
      strUnion := strUnion + fGetWhereCadSem_(2);

      strSQL := strSQL + strUnion;
      strSQL := strSQL + ' UNION ';

      strUnion := '';
      strUnion := strUnion + fGetSelectCadSem(False, 3);
      strUnion := strUnion + fGetFromCadSem;
      strUnion := strUnion + fGetWhereCadSem_(3);

      strSQL := strSQL + strUnion;
      strSQL := strSQL + ' UNION ';

      strUnion := '';
      strUnion := strUnion + fGetSelectCadSem(False, 5);
      strUnion := strUnion + fGetFromCadSem;
      strUnion := strUnion + fGetWhereCadSem_(5);

      strSQL := strSQL + strUnion;

    End;

    strSQL := strSQL + ' UNION ';

    strUnion := '';
    strUnion := strUnion + fGetSelectCadSem(False, 4);
    strUnion := strUnion + fGetFromCadSem;
    strUnion := strUnion + fGetWhereCadSem_(4);

    strSQL := strSQL + strUnion;

    strSQL := strSQL + ' ) AS TEMP ';
    strSQL := strSQL + ' GROUP BY TEMP.ITE_CODITE ';

  End
  Else
  Begin

    If (blnBuscaCodBar) Then
    Begin

      strSQL := '';

      strSQL := strSQL + fGetSelectCadSem;
      strSQL := strSQL + fGetFromCadSem;
      strSQL := strSQL + fGetWhereCadSem_CodBar(1);
      strSQL := strSQL + fGetGroupByCadSem;

      strSQL := strSQL + ' UNION ALL ';

      strSQL := strSQL + fGetSelectCadSem;
      strSQL := strSQL + fGetFromCadSem;
      strSQL := strSQL + fGetWhereCadSem_CodBar(2);
      strSQL := strSQL + fGetGroupByCadSem;

    End
    Else
    Begin
      strSQL := '';
      strSQL := strSQL + fGetSelectCadSem;
      strSQL := strSQL + fGetFromCadSem;
      strSQL := strSQL + fGetWhereCadSem;
      strSQL := strSQL + fGetGroupByCadSem;
    End;

  End;

  With qryTabela Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);

    If (Not blnBuscaCodBar) And blnBuscaCodFab And (Not fEmptyStr(strFabAut)) Then
      ParamByName('CODITE').AsString := ReplaceStr( strFabAut + IIF(blnLikeCodFab, '%', ''), '*', '%')
    Else
    begin
      if blnBuscaCodFab and blnLikeCodFab then
        blnLikeCodFab := fCfgSis('FABTIP') = strCONFIGURACAO_PARTIAL_KEY_UTILIZA_LIKE;

      ParamByName('CODITE').AsString := ReplaceStr( strCodIte + IIF(blnBuscaCodFab, IIF(blnLikeCodFab, '%', ''), ''), '*', '%');

    end;

    {Req.: 172590}
    If FindParam('FABRIC') <> Nil Then
      TUniParam(FindParam('FABRIC')).AsString := '%' + strCodIte + '%';

    If (Params.FindParam('CODFOR') <> Nil) Then
      ParamByName('CODFOR').AsString := strCodFor;

    If (Not fEmptyStr(strCodEmp)) Then
      ParamByName('CODEMP').AsString := strCodEmp
    Else
      ParamByName('CODEMP').AsString := VS_strCodEmp;
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

procedure pPesquisaCadTra(qryTabOri, qryTabela: TUniQuery; strCodTra: String; strAtiva: String = '');
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

  if not fEmptyStr(strAtiva) then
    strSQL := strSQL + '  AND TRA_ATIVA_ = :ATIVA';

  With qryTabela Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);

    ParamByName('CODTRA').AsString := strCodTra;

    if not fEmptyStr(strAtiva) then
      ParamByName('ATIVA').AsString := strAtiva;

    Open;
  End;

  pAtribuiDisplayLabels(qryTabOri, qryTabela);
end;

procedure pPesquisaCadVei(qryTabOri, qryTabela: TUniQuery; strCodVei: String);
  Var
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
  strSQL := strSQL + '  * ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADVEI ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  VEI_PLAVEI = :PLAVEI ';

  With qryTabela Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);

    ParamByName('PLAVEI').AsString := strCodVei;

    Open;
  End;

  pAtribuiDisplayLabels(qryTabOri, qryTabela);
end;

procedure pPesquisaLayCfs(qryTabOri, qryTabela: TUniQuery; strCodigo: String);
  Var
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
  strSQL := strSQL + '  * ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  LAYCFS ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  LAY_CODLAY = :CODIGO ';

  With qryTabela Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);

    ParamByName('CODIGO').AsString := strCodigo;

    Open;
  End;

  pAtribuiDisplayLabels(qryTabOri, qryTabela);
end;

procedure pPesquisaCadAju(qryTabOri, qryTabela: TUniQuery; strCodAju: String);
  Var
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
  strSQL := strSQL + '  * ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADAJU ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  AJU_CODAJU = :CODAJU ';

  With qryTabela Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);

    ParamByName('CODAJU').AsString := strCodAju;

    Open;
  End;

  pAtribuiDisplayLabels(qryTabOri, qryTabela);
end;

procedure pPesquisaCadTraCidFrete(qryTabOri, qryTabela: TUniQuery; strCodTra, strCodCid: String; strAtiva: String = '');
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

  if not fEmptyStr(strAtiva) then
    strSQL := strSQL + '  AND T.TRA_ATIVA_ = :ATIVA';

  With qryTabela Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);

    ParamByName('CODTRA').AsString := strCodTra;
    ParamByName('CODCID').AsString := strCodCid;

    if Trim(strAtiva) <> '' then
      ParamByName('ATIVA').AsString := strAtiva;

    Open;
  End;

  pAtribuiDisplayLabels(qryTabOri, qryTabela);
end;

procedure pPesquisaCadTraRegFrete(qryTabOri, qryTabela: TUniQuery; strCodTra, strCodReg: String; strAtiva: String = '');
Var
  strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
  strSQL := strSQL + '  T.* ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADTRA T ';
  strSQL := strSQL + '  INNER JOIN TRAREG R ON R.TRE_CODTRA = T.TRA_CODTRA ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  T.TRA_CODTRA = :CODTRA AND ';
  strSQL := strSQL + '  R.TRE_CODREG = :CODREG     ';

  if not fEmptyStr(strAtiva) then
    strSQL := strSQL + '  AND T.TRA_ATIVA_ = :ATIVA';

  With qryTabela Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);

    ParamByName('CODTRA').AsString := strCodTra;
    ParamByName('CODREG').AsString := strCodReg;

    if Trim(strAtiva) <> '' then
      ParamByName('ATIVA').AsString := strAtiva;

    Open;
  End;

  pAtribuiDisplayLabels(qryTabOri, qryTabela);
end;

procedure pPesquisaCadOpe(qryTabOri, qryTabela: TUniQuery; strCodOpe: String; blnBuscaPorSenha: Boolean = False; blnAtivos: Boolean = False; blnVendedorEmpLog: Boolean = False);
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
    {* CARACTERE FORA DE STR_CHAR_SENHA E CRIPTOGRAFADO PELO fCrypt COMO 'A' - NAO DEVE ENCONTRAR OPERADOR *}
    If Not fSenhaPermitida(strCodOpe) Then
      strSQL := strSQL + '  1 = 0 AND ';

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

  if blnVendedorEmpLog then
  begin
    strSQL := strSQL + ' AND LOCATE('+QuotedStr(VS_strCodEmp)+', OPE_EMPACE) > 0 ';
  end;

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
  blnPerCnd: Boolean = False; strCodCli: String = ''; blnIgnMar: Boolean = False);
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
      strSQL := strSQL + fRetornaSubQueryFaixasForaCondicao(fltMarDoc, fltValDoc, blnIgnMar) + ' AS SUB_PERCND ';
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

  If ((fltMarDoc > 0) Or blnListarSomenteCondicoesQueAtendamAsFaixas) And blnLibCnd And (Not blnIgnMar) Then
  Begin
    strSQL := strSQL + '  AND ' + AnsiReplaceStr(FloatToStr(fltMarDoc), ',', '.');
    strSQL := strSQL + '  BETWEEN CND_MARMIN AND CND_MARMAX ';
  End;
  If ((fltValDoc > 0) Or blnListarSomenteCondicoesQueAtendamAsFaixas) And blnLibCnd Then
  Begin
    strSQL := strSQL + '  AND ' + AnsiReplaceStr(FloatToStr(fltValDoc), ',', '.');
    strSQL := strSQL + '  BETWEEN CND_FATMIN AND CND_FATMAX ';
  End;

  If (Not fEmptyStr(strCodCli)) And (Not fMostraCreditoComPortador(strCodCli)) Then
  Begin
    strSQL := strSQL + '  AND IFNULL(CND_CODFPG, "000") <> "013" ';
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
  strSQL := strSQL + '  OCO_CODOCO = :CODOCO AND ';
  strSQL := strSQL + '  OCO_SITUAC = "A" ';

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

procedure pPesquisaCadProspe(qryTabOri, qryTabela: TUniQuery; strCodPro: String);
Var
  strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
  strSQL := strSQL + '  *                 ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  PROSPE ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  PRO_CODPRO = :CODPRO ';

  qryTabela.Close;
  qryTabela.SQL.Clear;
  qryTabela.SQL.Add(strSQL);
  qryTabela.ParamByName('CODPRO').AsString := strCodPro;
  qryTabela.Open;

  pAtribuiDisplayLabels(qryTabOri, qryTabela);
End;

procedure pPesquisaCadLot(qryTabOri, qryTabela: TUniQuery; strAutInc: String);
  Var
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
  strSQL := strSQL + '  * ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADLOT ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  AUTOINCREM = :AUTINC';

  With qryTabela Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('AUTINC').AsString := strAutInc;
    Open;
  End;
  pAtribuiDisplayLabels(qryTabOri, qryTabela);
end;

procedure pPesquisaCadTfu(qryTabOri, qryTabela: TUniQuery; strCodTfu: String);
  Var
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
  strSQL := strSQL + '  * ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADTFU ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  TFU_CODTFU = :CODTFU ';

  With qryTabela Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODTFU').AsString := strCodTfu;
    Open;
  End;
  pAtribuiDisplayLabels(qryTabOri, qryTabela);
end;

end.

