{*********************************************************}
{* UNIT DE FUNCOES PARA CONSULTAS COM MULTIPLA SELECAO   *}
{*                                                       *}
{* DATA......: 10/10/2007                                *}
{* AUTOR.....: LAERCIO ANTONINO GRATON                   *}
{*                                                       *}
{******************************************************LA*}

unit untFuncoesConsulta;

interface

Uses
  Uni, untFuncoesSimples, EditFocus, Classes, Controls, untTypesSistema,
  IdGlobal, StdCtrls, MaskEditFocus, Forms, SysUtils, StrUtils;

  {***************************************}
  {* PROCEDURES DA UNIT                  *}
  {************************************LA*}
  procedure pEdtCodSelectExit(    edtCodigo       : TCustomEdit;
                                  edtDescri       : TEditFocus;
                              Var arrLinha        : TConsultasArray;
                                  fncRetNome      : TfncRetNome;
                                  fncRetNomeConst : TfncRetNomeConst;
                                  strMsgErr       : String;
                                  intTamCamp      : integer = 0;
                                  blnNegar: Boolean = False;
                                  strCodigo: String  = 'Código';
                                  blnFeminino     : Boolean = False;
                                  blnSuprimirMensagem : Boolean = False;
                                  fncRetNomeParam : tfncRetNomeParam = nil;
                                  arrAux          : TConsultasArray = nil;
                                  strCodAux       : String = '';
                                  strAutIncrem    : String = '');

  procedure pCarrega(strText: String; edtDescri: TEditFocus; arrLinha: TConsultasArray);
  procedure pDesmarcaLista(edtCodigo: TCustomEdit; Var arrLinha: TConsultasArray; strTempTable: String = ''; intTamCamp: Integer = 0);
  procedure pSetaParam(strText: String; arrLinha: TConsultasArray; Var strLinha: String; strNomPar: String; qryRelatorio: TUniQuery); overload;

  procedure pSetaParamPeriodo(mskDtaIni, mskDtaFin: TMaskEditFocus; qryRelatorio: TUniQuery;
                              strParIni: String = 'DTAINI';
                              strParFin: String = 'DTAFIN');

  procedure pSetaParam(edtValor:TEditFocus; strNomPar: String; qryRelatorio: TUniQuery; blnLike: Boolean = False); overload;
  procedure pDropTable(strTempTable: String);

  procedure pSetaParamOR(objCodigo: TObject; arrLinha: TConsultasArray; strNomPar: String; qryRelatorio: TUniQuery);

  function fStrLocate(objCodigo: TObject; arrLinha: TConsultasArray; strNomCampo,
    strNomPar: String; blnSemAND: Boolean = False; blnNegar: Boolean = False;
    strCodigo: String = ''): String; Overload;

  function fStrLocate(strCodigo: String; arrLinha: TConsultasArray; strNomCampo,
    strNomPar: String; blnSemAND: Boolean = False; blnNegar: Boolean = False): String; Overload;

  function fStrLocateLinGru(objCodigo: TObject; arrLinha: TConsultasArray; strNomCampo,
    strNomPar: String; blnSemAND: Boolean = False; blnNegar: Boolean = False;
    strCodigo: String = ''; blnAndFinal: Boolean = False): String; OverLoad;

  function fStrLocateLinGru(arrLinha: TConsultasArray; strNomCampo: String;
            blnSemAND: Boolean = False; blnNegar: Boolean = False; blnAndFinal: Boolean = False): String; OverLoad;

  function fStrLocateEmpresa(objCodigo: TObject;
                             arrLinha: TConsultasArray; strNomCampo,
    strNomPar: String; blnSemAND: Boolean = False;
    strCodigo: String = ''): String; OverLoad;

  function fStrLocateEmpresa(arrLinha: TConsultasArray; strNomCampo: String; blnSemAND: Boolean = False): String; OverLoad;

  function fStrTitulo(strText: String; edtDescri: TEditFocus; arrLinha: TConsultasArray; strLinha, strTitulo: String;
                      blnTodas: Boolean = False; blnNegar: Boolean = False): String; overload;

  function fStrTitulo(strText: String; edtDescri: TEditFocus; arrLinha: TConsultasArray; strLinha, strTitulo, strVazio: String): String; overload;

  function fStrFiltroAtaRelEditor(objCodigo: TObject; arrLinha: TConsultasArray): String;

  function fStrTitulo(edtValor: TEditFocus; strTitulo: String): String; overload;
  Function fStrTituloPeriodo(mskDtaIni, mskDtaFin: TMaskEditFocus): String;
  function fStrTitulo(edtCodigo, edtDescri: TEditFocus; arrLinha: TConsultasArray; strLinha, strTitulo: String): String; overload;
  function fGetStrCodigos(edtCodigo: TEditFocus; arrLinha: TConsultasArray; blnQuoted: Boolean = False): String;

  Function fSQLParam(edtValor: TCustomEdit; strNomCam: String; strNomPar: String = ''; blnLike: Boolean = False): String; overload;
  Function fSQLParam(strCodigo, strNomCam: String; blnLike: Boolean = False): String; overload;

  Function fSQLParamPerido(mskDtaIni: TMaskEditFocus; strNomCam: String;
                           strParIni: String = 'DTAINI';
                           strParFin: String = 'DTAFIN'): String;

  {**************************************************************************}
  {* ACRESCENTOU FUNCAO PARA MULTISELECAO COM CLAUSULA OR                   *}
  {**01/03/2011-09:06*****************************************************DP*}
  function fStrSQLOr(objCodigo: TObject; arrLinha: TConsultasArray;strNomCampo,strNomPar: String;
                     blnSemAND: Boolean = False; blnNegar: Boolean = False ): String;


  Function fArrCodigosToLista(strCodigo: String; arrCodigos: TConsultasArray; blnQuoted: Boolean = True): String;
  Function fArrCodigosToText(arrCodigos: TConsultasArray): String;
  function fSQLIn(objCodigo: TObject; arrLinha: TConsultasArray; strNomCampo,
    strNomPar: String; blnSemAND: Boolean = False; blnNegar: Boolean = False;
    strCodigo: String = ''): String; OverLoad;
  function fSQLIn(arrLinha: TConsultasArray; strNomCampo: String; blnSemAND: Boolean = False; blnNegar: Boolean = False): String; OverLoad;

  function fGetSQLConsultaItensPrecoValidandoEstrutura(strAliasIteger: String = 'ITEGER'; strTabelaPreco: string = '1'; strPreFixo: string = 'ITE_'; blnEfetivacaoPreco: Boolean = False): string;

  Function fCommaTextToQuoted(strLista: String): String;
  function fCliForFaturamento(strTipoCliFor, strCodCLiFor: String): Boolean;
  procedure pAdicionaClausulaWhereQry(const qry: TUniQuery; Var strLinha: String; const Sender: TObject;
    const arrLinha: TConsultasArray; const strNomCampo, strNomPar, strConteudoCampo: String;
    const blnSemAND: Boolean = False; blnNegar: Boolean = False; const strCodigo: String = '');

implementation

uses Mask;

{********************************************************************************************************}
{* PROCEDURE ONEXIT PARA CONSULTAS - UTILIZAR ESSA FUNCAO NO EVENTO ONKEYPRESS DO COMPONENTE TEDITFOCUS *}
{*****************************************************************************************************LA*}
procedure pEdtCodSelectExit(    edtCodigo       : TCustomEdit;
                                edtDescri       : TEditFocus;
                            Var arrLinha        : TConsultasArray;
                                fncRetNome      : TfncRetNome;
                                fncRetNomeConst : TfncRetNomeConst;
                                strMsgErr       : String;
                                intTamCamp      : integer = 0;
                                blnNegar        : Boolean = False;
                                strCodigo       : String = 'Código';
                                blnFeminino     : Boolean = False;
                                blnSuprimirMensagem : Boolean = False;
                                fncRetNomeParam : tfncRetNomeParam = nil;
                                arrAux          : TConsultasArray = nil;
                                strCodAux       : String = '';
                                strAutIncrem    : String = '');
  Var
    intTamanho: Integer;
    strText  : String;
Begin


  If Assigned(edtDescri) Then
  Begin

    If edtCodigo.ClassNameIs('TEditFocus') Then
    Begin
      intTamanho := TEditFocus(edtCodigo).TamCampo;
      if intTamCamp > 0 then
        intTamanho := intTamCamp;
      strText    := TEditFocus(edtCodigo).Text;
    End

    Else
    Begin
      intTamanho := intTamCamp;
      strText    := TMaskEditFocus(edtCodigo).Text;
    End;

    If strText <> fStrZero('0',intTamanho) Then
      SetLength(arrLinha,0);

    If fEmptyStr(strText) Then
    Begin
      If Assigned(edtDescri) Then
      Begin
        If blnNegar Then
          If blnFeminino Then
            edtDescri.Text := 'NENHUMA'
          Else
            edtDescri.Text := 'NENHUM'
        Else
          If blnFeminino Then
            edtDescri.Text := 'TODAS'
          Else
            edtDescri.Text := 'TODOS';
      End;
    End

    Else
    Begin

      If Length(arrLinha) = 0 Then
      Begin
        SetLength(arrLinha,1);
        arrLinha[0].strCodigo := strText;

        if assigned(fncRetNomeParam) then
        begin
          if assigned(arrAux) then
            arrlinha[0].strDescri := fncRetNomeParam(strText,arrAux)
          else
            arrlinha[0].strDescri := fncRetNomeParam(iif(strAutIncrem<>'',strAutIncrem,strText));
        end
        else
        If Assigned(fncRetNomeConst) Then
          arrLinha[0].strDescri := fncRetNomeConst(strText)

        Else If Assigned(fncRetNome) Then
          arrLinha[0].strDescri := fncRetNome(strText);

      End;

      If Length(arrLinha) = 1 Then
      Begin
        If Assigned(edtDescri) Then
        begin
          If Assigned(fncRetNomeParam) Then
          begin
            if assigned(arrAux) then
              edtDescri.Text := fncRetNomeParam(strText, arrAux)
            else
              edtDescri.Text := fncRetNomeParam(strText);
          end
          else
          If Assigned(fncRetNomeConst) Then
            edtDescri.Text := fncRetNomeConst(strText)
          Else If Assigned(fncRetNome) Then
            edtDescri.Text := fncRetNome(strText);
        end;
      End;
    End;

    If Assigned(edtDescri) Then
    Begin
      If fEmptyStr(edtDescri.Text) And (Not fEmptyStr(strText))  and Not(blnSuprimirMensagem)Then
      Begin
        fMensagem('', strCodigo + ' ' + strMsgErr + ' não encontrado.', ['&O K']);
        edtCodigo.Clear;
        pSetFocus(edtCodigo);
      End;
    End;
  End
  Else
  Begin
    If edtCodigo.Text <> '+1' Then
      SetLength(arrLinha,0);

    If (Length(arrLinha) = 0) And (Not fEmptyStr(edtCodigo.Text)) Then
    Begin
      SetLength(arrLinha,1);
      arrLinha[0].strCodigo := edtCodigo.Text;
    End;

    If  (Not(blnSuprimirMensagem)) And
        (Length(arrLinha) = 1) And
       ((Assigned(fncRetNomeConst) And fEmptyStr(fncRetNomeConst(edtCodigo.Text))) Or
         (Assigned(fncRetNome)     And fEmptyStr(fncRetNome(edtCodigo.Text)))    ) And
       (Not fEmptyStr(edtCodigo.Text))                                             Then
    Begin
      fMensagem('AVISO', strCodigo + ' '+ strMsgErr + ' não encontrado.', ['&O K']);
      edtCodigo.Clear;
      pSetFocus(edtCodigo);
    End;

  End;
End;

{********************************************************************************************************}
{* PROCEDURE PARA CARREGAR A DESCRICAO DO DADO NO EDIT DE DESCRICAO                                     *}
{*****************************************************************************************************LA*}
procedure pCarrega(strText: String; edtDescri: TEditFocus; arrLinha: TConsultasArray);
Begin
  If Assigned(edtDescri) Then
  Begin

    If Not fEmptyStr(strText) Then
    Begin

      If Length(arrLinha) = 1 Then
        edtDescri.Text := arrLinha[0].strDescri
      Else
        edtDescri.Text := '+1';

    End
    Else
      edtDescri.Text := '';
  End;
End;

function fGetAS(strNomCam: String): String;
Begin
  If Pos('FORMAT(',strNomCam) > 0 Then
  Begin
    strNomCam := Copy(strNomCam,8,Pos(',',strNomCam)-8);
  End;


  If Pos('.',strNomCam) > 0 Then
  Begin
    Delete(strNomCam,1,Pos('.',strNomCam));
    Result := ' AS ' + strNomCam;
  End Else
    Result := '';
End;

function fGetNomeCampo(strNomCam: String): String;
Begin
  If Pos('FORMAT(',strNomCam) > 0 Then
  Begin
    strNomCam := Copy(strNomCam,8,Pos(',',strNomCam)-8);
  End;

  If Pos('.',strNomCam) > 0 Then
    Delete(strNomCam,1,Pos('.',strNomCam));

  Result := strNomCam;
End;

{********************************************************************************************************}
{* PROCEDURE PARA DESMASCAR OS REGISTROS MARCADOS NA MULTIPLA SELECAO                                   *}
{*****************************************************************************************************LA*}
procedure pDesmarcaLista(edtCodigo: TCustomEdit; Var arrLinha: TConsultasArray; strTempTable: String = ''; intTamCamp: Integer = 0);
  Var
    intTamanho: integer;
    strText   : string;
Begin
  If edtCodigo.ClassNameIs('TEditFocus') Then
  Begin
    strText := TEditFocus(edtCodigo).Text;
    intTamanho := TEditFocus(edtCodigo).TamCampo;
    if intTamCamp > 0 then
      intTamanho := intTamCamp;
  End Else
  Begin
    strText := TMaskEditFocus(edtCodigo).Text;
    intTamanho := IntTamCamp;
  End;

  If fEmptyStr(strText) Or
    ((strText <> fStrZero('0',intTamanho)) And (strText <> '+1')) Then
  Begin
    SetLength(arrLinha,0);
    If (Not fEmptyStr(strTempTable)) And fTabelaExiste(strTempTable) Then
      fExecutaSQL('UPDATE ' + strTempTable+ ' SET MARDES = "D"');
  End
End;

{********************************************************************************************************}
{* MONTA O STRING DA CONSULTA PARA O SELECT COM MULTIPLA SELECAO OU UM UNICO REGISTRO                   *)
{*****************************************************************************************************LA*}
function fStrLocate(objCodigo: TObject; arrLinha: TConsultasArray; strNomCampo,
  strNomPar: String; blnSemAND: Boolean = False; blnNegar: Boolean = False;
  strCodigo: String = ''): String;
Begin

{*****************************************}
{* COMENTEI ESSA LINHA E DESCOMENTERI O  *}
{* BLOCO ABAIXO PORQUE ESTAVA DANCO ERRO *}
{* QUANDO USAVA MULTI-SELEÇÃO            *}
{*03/11/2014***************************JU*}
//  Result := fSQLIn(objCodigo, arrLinha, strNomCampo, strNomPar, blnSemAND, blnNegar, strCodigo);


  {***********************************}
  {* VERIFICA O COMPONENTE PASSADO   *}
  {* E FAZ O TRATAMENTO DIFERENCIADO *}
  {* MASK OU EDIT                    *}
  {********************************JB*}
  If fEmptyStr(strCodigo) And Assigned(objCodigo) Then
  Begin
    If (objCodigo.ClassNameIs('TEditFocus')) Then
      strCodigo := TEditFocus(objCodigo).Text
    Else If (objCodigo.ClassNameIs('TMaskEditFocus')) Then
      strCodigo := TMaskEditFocus(objCodigo).Text
    Else If (objCodigo.ClassNameIs('TMaskEdit')) Then
      strCodigo := TMaskEdit(objCodigo).Text
    Else
      strCodigo := '';
  End;

  If Not fEmptyStr(strCodigo) Then
  Begin
    If blnNegar Then
    Begin
      If Length(arrLinha) > 1 Then
        Result := '(NOT LOCATE(' + strNomCampo + ',:' + strNomPar + ') > 0) AND COALESCE(' + strNomCampo + ', "") <> "" '
      Else
        Result := strNomCampo + ' <> :' + strNomPar + ' ';
    End
    Else
    Begin
      If Length(arrLinha) > 1 Then
        Result := 'LOCATE(' + strNomCampo + ',:' + strNomPar + ') > 0  AND COALESCE(' + strNomCampo + ', "") <> "" '
      Else
        Result := strNomCampo + ' = :' + strNomPar + ' ';
    End;

    If Not blnSemAND Then
      Result := '  AND ' + Result;
  End
  Else
    Result := '';



End;

function fStrLocate(strCodigo: String; arrLinha: TConsultasArray; strNomCampo,
    strNomPar: String; blnSemAND: Boolean = False; blnNegar: Boolean = False): String; Overload;
Begin
  If Not fEmptyStr(strCodigo) Then
  Begin
    If blnNegar Then
    Begin
      If Length(arrLinha) > 1 Then
        Result := '(NOT LOCATE(' + strNomCampo + ',:' + strNomPar + ') > 0) AND COALESCE(' + strNomCampo + ', "") <> "" '
      Else
        Result := strNomCampo + ' <> :' + strNomPar + ' ';
    End
    Else
    Begin
      If Length(arrLinha) > 1 Then
        Result := 'LOCATE(' + strNomCampo + ',:' + strNomPar + ') > 0  AND COALESCE(' + strNomCampo + ', "") <> "" '
      Else
        Result := strNomCampo + ' = :' + strNomPar + ' ';
    End;

    If Not blnSemAND Then
      Result := '  AND ' + Result;
  End
  Else
    Result := '';
End;

{********************************************************************************************************}
{* PROCEDURE PARA SETAR O PARAMETRO DA QUERY COM A MULTIPLA SELECAO OU UM UNICO REGISTRO *}
{*****************************************************************************************************LA*}
procedure pSetaParam(strText: String; arrLinha: TConsultasArray; Var strLinha: String; strNomPar: String; qryRelatorio: TUniQuery);
  Var
    intContador : integer;
Begin

  strLinha := '';
  For intContador := 0 To Length(arrLinha)-1 Do
  Begin
    If (Not fEmptyStr(strLinha)) Then
      strLinha := strLinha + '_';

    strLinha := strLinha + arrLinha[intContador].strCodigo;
  End;

  With qryRelatorio Do
  If (Not fEmptyStr(strText)) And (Params.FindParam(strNomPar) <> Nil) Then
  Begin

    If Length(arrLinha) > 1 Then
    Begin
      ParamByName(strNomPar).AsString := strLinha;
    End
    Else
      ParamByName(strNomPar).AsString := strText;
  End;
End;

{**********************************************************************}
{* MONTA STRING DA QUERY, DA MULTISELECAO, COM CLAUSULA OR            *}
{**01/03/2011-08:46*************************************************DP*}
function fStrSQLOr(objCodigo: TObject; arrLinha: TConsultasArray;
                   strNomCampo,strNomPar: String; blnSemAND: Boolean = False; blnNegar: Boolean = False ): String;
Var
  strCodigo   : String;
  intContador : Integer;
Begin
  {****************************************}
  {* TRATA DE ACORDO COM O TIPO DO OBJETO *}
  {*************************************DP*}
  If Assigned(objCodigo) And (objCodigo.ClassNameIs('TEditFocus')) Then
    strCodigo := TEditFocus(objCodigo).Text
  Else If  Assigned(objCodigo) And (objCodigo.ClassNameIs('TMaskEditFocus')) Then
    strCodigo := TMaskEditFocus(objCodigo).Text
  Else
    strCodigo := '';

  Result := '';

  If Not(fEmptyStr(strCodigo)) Then
  Begin
    If blnNegar Then
      Result := Result + ' NOT( '
    Else
      Result := Result + ' ( ';
    If Length(arrLinha) > 1 Then
    Begin
      For intContador:= 0 to Length(arrLinha)-1 Do
      Begin
        Result := Result + ' (' + strNomCampo + '= :' + strNomPar + IntToStr(intContador);
        If intContador = (Length(arrLinha) - 1) Then
          Result := Result + ')'
        Else
          Result := Result + ') OR ';
      End;
    End
    Else
      Result := Result + strNomCampo + '= :' + strNomPar;

    Result := Result + ' )';

    If Not blnSemAND Then
      Result := '  AND ' + Result;
  End;
End;

{************************************************************************}
{* SETA OS PARAMETROS COM CLAUSULA OR                                   *}
{*********************************************************************DP*}
procedure pSetaParamOR(objCodigo: TObject; arrLinha: TConsultasArray; strNomPar: String; qryRelatorio: TUniQuery);
Var
  strCodigo  : String;
  IntContador: Integer;
Begin
  {****************************************}
  {* TRATA DE ACORDO COM O TIPO DO OBJETO *}
  {*************************************DP*}
  If  Assigned(objCodigo) And (objCodigo.ClassNameIs('TEditFocus')) Then
    strCodigo := TEditFocus(objCodigo).Text
  Else If Assigned(objCodigo) And  (objCodigo.ClassNameIs('TMaskEditFocus')) Then
    strCodigo := TMaskEditFocus(objCodigo).Text
  Else
    strCodigo := '';

  If Not(fEmptyStr(strCodigo)) Then
  Begin
    If Length(arrLinha) > 1 Then
      For intContador:= 0 to Length(arrLinha)-1 Do
        qryRelatorio.ParamByName(strNomPar + IntToStr(intContador)).AsString := arrLinha[intContador].strCodigo
    Else
      qryRelatorio.ParamByName(strNomPar).AsString := strCodigo;
  End;
End;



{********************************************************************************************************}
{* MONTA O HEADER DO RELATORIO                                                                          *)
{*****************************************************************************************************LA*}
function fStrTitulo(strText: String; edtDescri: TEditFocus; arrLinha: TConsultasArray; strLinha, strTitulo: String; blnTodas: Boolean = False; blnNegar: Boolean = False): String;
Begin
  If Not fEmptyStr(strText) Then
  Begin
     If Assigned(edtDescri) Then
       Result := strTitulo + ': ' + IIF(Length(arrLinha) > 1, strLinha, strText + ' - ' + edtDescri.Text)
     Else
       Result := strTitulo + ': ' + IIF(Length(arrLinha) > 1, strLinha, strText)
  End
  Else
    if blnTodas Then
    Begin
      If blnNegar Then
        Result := strTitulo + ': NENHUMA'
      Else
        Result := strTitulo + ': TODAS'
    End Else
    Begin
      If blnNegar Then
        Result := strTitulo + ': NENHUM'
      Else
        Result := strTitulo + ': TODOS';
    End;
End;

function fStrTitulo(strText: String; edtDescri: TEditFocus; arrLinha: TConsultasArray; strLinha, strTitulo, strVazio: String): String;
Begin
  If Not fEmptyStr(strText) Then
  Begin
     If Assigned(edtDescri) Then
       Result := strTitulo + ': ' + IIF(Length(arrLinha) > 1, strLinha, strText + ' - ' + edtDescri.Text)
     Else
       Result := strTitulo + ': ' + IIF(Length(arrLinha) > 1, strLinha, strText)
  End
  Else
    Result := strTitulo + ': ' + strVazio;
End;

function fStrFiltroAtaRelEditor(objCodigo: TObject; arrLinha: TConsultasArray): String;
Var
  strCodigo: String;
  intContador : integer;
begin

  If (objCodigo.ClassNameIs('TEditFocus')) Then
    strCodigo := TEditFocus(objCodigo).Text
  Else If (objCodigo.ClassNameIs('TMaskEditFocus')) Then
    strCodigo := TMaskEditFocus(objCodigo).Text
  Else If (objCodigo.ClassNameIs('TMaskEdit')) Then
    strCodigo := TMaskEdit(objCodigo).Text
  Else
    strCodigo := '';

  If Not fEmptyStr(strCodigo) Then
  Begin
    If Length(arrLinha) > 1 Then
    Begin
      Result := '(IN)';
      For intContador := 0 To Length(arrLinha)-1 Do
      Begin
        Result := Result + IIf(Result <> '(IN)', ', ', '') +  QuotedStr(arrLinha[intContador].strCodigo);
      End;
    End
    Else
      Result := strCodigo;
  End
  Else
    Result := '';

end;

procedure pDropTable(strTempTable: String);
Begin
  If fTabelaExiste(strTempTable) Then
    fDropTable(strTempTable);
End;

function fGetStrCodigos(edtCodigo: TEditFocus; arrLinha: TConsultasArray; blnQuoted: Boolean = False): String;
  Var
    intIndex: Integer;
begin
  Result := '';
  If Length(arrLinha) = 0 Then
  Begin

    If edtCodigo.Text <> '' Then
     If blnQuoted Then
       Result := QuotedStr(edtCodigo.Text)
     Else
       Result := edtCodigo.Text;

  End Else
  Begin
    If blnQuoted Then
      Result := QuotedStr(arrLinha[0].strCodigo)
    Else
      Result := arrLinha[0].strCodigo;

    For intIndex := low(arrLinha) + 1 To High(arrLinha) do
      If blnQuoted Then
        Result := Result + ', ' + QuotedStr(arrLinha[intIndex].strCodigo)
      Else
        Result := Result + ', ' + arrLinha[intIndex].strCodigo;
  End;
end;

Function fStrTituloPeriodo(mskDtaIni, mskDtaFin: TMaskEditFocus): String;
Begin
  If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
     Result := 'REFERENTE AO PERÍODO DE ' + DateToStr(StrToDate(mskDtaIni.Text)) + ' A ' +DateToStr(StrToDate( mskDtaFin.Text))
  Else
    Result := 'PERÍODO: TODOS';
End;

function fStrTitulo(edtCodigo, edtDescri: TEditFocus; arrLinha: TConsultasArray; strLinha, strTitulo: String): String;
Begin
  If edtCodigo.PasswordChar = '*' Then
    Result := strTitulo+': '+fRetCodVendedor(edtCodigo.Text)+'-'+edtDescri.Text
  Else
    Result := fStrTitulo(edtCodigo.Text, edtDescri, arrLinha, strLinha, strTitulo);
end;

function fStrTitulo(edtValor: TEditFocus; strTitulo: String): String;
Begin
  If fEmptyStr(edtValor.Text) Then
    Result := strTitulo + ': TODOS'
  Else
    Result := strTitulo + ': ' + edtValor.Text;
End;

procedure pSetaParam(edtValor:TEditFocus; strNomPar: String; qryRelatorio: TUniQuery; blnLike: Boolean = False);
Begin
  With qryRelatorio Do
  If (Not fEmptyStr(edtValor.Text)) And (Params.FindParam(strNomPar) <> Nil) Then
    ParamByName(strNomPar).AsString := edtValor.Text + IIF(blnLike, '%', '');
End;

procedure pSetaParamPeriodo(mskDtaIni, mskDtaFin: TMaskEditFocus; qryRelatorio: TUniQuery;
                            strParIni: String = 'DTAINI';
                            strParFin: String = 'DTAFIN');
Begin
  With qryRelatorio Do
  If Not fEmptyDate(mskDtaIni.Text) Then
  Begin
    ParamByName(strParIni).AsDate := StrToDate(mskDtaIni.Text);
    ParamByName(strParFin).AsDate := StrToDate(mskDtaFin.Text);
  End;
End;

Function fSQLParam(edtValor: TCustomEdit; strNomCam: String; strNomPar: String = ''; blnLike: Boolean = False): String;
  Var
    strCodigo: String;
Begin
  If (edtValor.ClassNameIs('TEditFocus')) Then
    strCodigo := TEditFocus(edtValor).Text
  Else If (edtValor.ClassNameIs('TMaskEditFocus')) Then
    strCodigo := TMaskEditFocus(edtValor).Text
  Else
    strCodigo := '';

  If fEmptyStr(strNomPar) Then
    strNomPar := RightStr(strNomCam, 6);

  If fEmptyStr(strCodigo) Then
    Result := ''
  Else
    Result := ' AND ' + strNomCam + IIF(blnLike, ' LIKE ', ' = ') + ':' + strNomPar + ' ';
End;

Function fSQLParam(strCodigo, strNomCam: String; blnLike: Boolean = False): String;
Begin
  If fEmptyStr(strCodigo) Then
    Result := ''
  Else
    If blnLike Then
      Result := ' AND ' + strNomCam + ' LIKE "' + strCodigo + '%"'
    Else
      Result := ' AND ' + strNomCam + ' = "' + strCodigo + '" ';
End;

Function fSQLParamPerido(mskDtaIni: TMaskEditFocus; strNomCam: String;
                         strParIni: String = 'DTAINI';
                         strParFin: String = 'DTAFIN'): String;
Begin
  If fEmptyDate(mskDtaIni.Text) Then
    Result := ''
  Else
    Result := ' AND ' + strNomCam + ' BETWEEN :' + strParIni + ' AND :' + strParFin + ' ';
End;

function fStrLocateLinGru(objCodigo: TObject; arrLinha: TConsultasArray; strNomCampo,
  strNomPar: String; blnSemAND: Boolean = False; blnNegar: Boolean = False;
  strCodigo: String = ''; blnAndFinal: Boolean = False): String;
  Var
    intContador: Integer;
Begin
  Result := '';
  {***********************************}
  {* VERIFICA O COMPONENTE PASSADO   *}
  {* E FAZ O TRATAMENTO DIFERENCIADO *}
  {* MASK OU EDIT                    *}
  {********************************JB*}
  If (fEmptyStr(strCodigo)) Then
  Begin
    If Assigned(objCodigo) And (objCodigo.ClassNameIs('TEditFocus')) Then
      strCodigo := TEditFocus(objCodigo).Text
    Else If Assigned(objCodigo) And (objCodigo.ClassNameIs('TMaskEditFocus')) Then
      strCodigo := TMaskEditFocus(objCodigo).Text
    Else If Assigned(objCodigo) And (objCodigo.ClassNameIs('TMaskEdit')) Then
      strCodigo := TMaskEdit(objCodigo).Text
    Else
      strCodigo := '';
  End;

  If Not fEmptyStr(strCodigo) Then
  Begin

    If Length(arrLinha) > 1 Then
    Begin
      Result := '(';

      For intContador := Low(arrLinha) To High(arrLinha) Do
      Begin
        If RightStr(arrLinha[intContador].strCodigo, 3) = '000' Then
          Result := Result + ' (LEFT(' + strNomCampo + ', 3) = ' +  QuotedStr(LeftStr(arrLinha[intContador].strCodigo, 3)) + ') '
        Else
          Result := Result + ' (' + strNomCampo + ' = ' + QuotedStr(arrLinha[intContador].strCodigo) + ') ';

        If intContador <> High(arrLinha) Then
          Result := Result + ' OR ';
      End;

      Result := Result + ' ) ';

    End Else
    Begin

      If RightStr(strCodigo, 3) = '000' Then
        Result := Result + ' (LEFT(' + strNomCampo + ', 3) = LEFT(:' + strNomPar + ', 3)) '
      Else
        Result := Result + strNomCampo + ' = :' + strNomPar + ' ';

    End;

    If blnNegar Then
      Result := ' (NOT ( ' + Result + ' )) ';

    If (Not blnSemAND) And (Not fEmptyStr(Result)) Then
    Begin
      If blnAndFinal Then
        Result :=  Result + '  AND '
      Else
        Result := '  AND ' + Result;
    End;
  End
  Else
    Result := '';
End;

function fStrLocateLinGru(arrLinha: TConsultasArray; strNomCampo: String;
            blnSemAND: Boolean = False; blnNegar: Boolean = False; blnAndFinal: Boolean = False): String;
  Var
    intContador: Integer;
Begin
  Result := '';

  If Length(arrLinha) > 0 Then
  Begin

    Result := '(';

    For intContador := Low(arrLinha) To High(arrLinha) Do
    Begin
      If RightStr(arrLinha[intContador].strCodigo, 3) = '000' Then
        Result := Result + ' (LEFT(' + strNomCampo + ', 3) = ' +  QuotedStr(LeftStr(arrLinha[intContador].strCodigo, 3)) + ') '
      Else
        Result := Result + ' (' + strNomCampo + ' = ' + QuotedStr(arrLinha[intContador].strCodigo) + ') ';

      If intContador <> High(arrLinha) Then
        Result := Result + ' OR ';
    End;

    Result := Result + ' ) ';

    If blnNegar Then
      Result := ' (NOT ( ' + Result + ' )) ';

    If (Not blnSemAND) And (Not fEmptyStr(Result)) Then
    Begin
      If blnAndFinal Then
        Result :=  Result + '  AND '
      Else
        Result := '  AND ' + Result;
    End;
  End
  Else
    Result := '';
End;

function fStrLocateEmpresa(objCodigo: TObject; arrLinha: TConsultasArray; strNomCampo,
  strNomPar: String; blnSemAND: Boolean = False; strCodigo: String = ''): String; OverLoad;
Begin
  Result := fStrLocate(objCodigo, arrLinha, strNomCampo, strNomPar, blnSemAND, False, strCodigo);

  If (Not fEmptyStr(Result)) Then
    Result := Result + ' AND '

  Else If Not blnSemAND Then
    Result := Result + ' AND ';

  Result := Result + ' ' + strNomCampo +' IN (' + fStringSQLLocateToStringSQLIN(strEmpAcessoUsuarioLogado) + ') ';

End;

function fStrLocateEmpresa(arrLinha: TConsultasArray; strNomCampo: String; blnSemAND: Boolean = False): String; OverLoad;
  Var
    intContador: Integer;
Begin
  Result := '';

  If Length(arrLinha) > 0 Then
  Begin

    Result := '(';

    For intContador := Low(arrLinha) To High(arrLinha) Do
    Begin
      If RightStr(arrLinha[intContador].strCodigo, 3) = '000' Then
        Result := Result + ' (LEFT(' + strNomCampo + ', 3) = ' +  QuotedStr(LeftStr(arrLinha[intContador].strCodigo, 3)) + ') '
      Else
        Result := Result + ' (' + strNomCampo + ' = ' + QuotedStr(arrLinha[intContador].strCodigo) + ') ';

      If intContador <> High(arrLinha) Then
        Result := Result + ' OR ';
    End;

    Result := Result + ' ) ';


    If (Not blnSemAND) And (Not fEmptyStr(Result)) Then
    Begin
      Result := '  AND ' + Result;
    End;
  End
  Else
    Result := '';

End;

Function fArrCodigosToText(arrCodigos: TConsultasArray): String;
  Var
    intContador: Integer;
    sltLista: TStringList;
Begin
  sltLista := TStringList.Create;

  For intContador := Low(arrCodigos) To High(arrCodigos) Do
    With arrCodigos[intContador] Do
      sltLista.Add(strCodigo);

  Result := sltLista.Text;

  FreeAndNil(sltLista);
End;

Function fArrCodigosToLista(strCodigo: String; arrCodigos: TConsultasArray; blnQuoted: Boolean = True): String;
  Var
    intContador: Integer;
Begin
  Result := '';

  For intContador := Low(arrCodigos) To High(arrCodigos) Do
    With arrCodigos[intContador] Do
    Begin
      If blnQuoted Then
        Result := Result + QuotedStr(strCodigo)
      Else
        Result := Result + strCodigo;

      If intContador <> High(arrCodigos) Then
        Result := Result + ',';
    End;

  If fEmptyStr(Result) And (Not fEmptyStr(strCodigo)) Then
  Begin
    If blnQuoted Then
      Result := QuotedStr(strCodigo)
    Else
      Result := strCodigo;
  End;
End;

function fSQLIn(objCodigo: TObject; arrLinha: TConsultasArray; strNomCampo,
  strNomPar: String; blnSemAND: Boolean = False; blnNegar: Boolean = False;
  strCodigo: String = ''): String;
  Var
    stlInfos: TStringList;
    intContador: Integer;
Begin
  stlInfos := TStringList.Create;

  For intContador := Low(arrLinha) To High(arrLinha) Do
    stlInfos.Add(QuotedStr(arrLinha[intContador].strCodigo));

  If (fEmptyStr(strCodigo)) And Assigned(objCodigo) Then
  Begin
    If (objCodigo.ClassName = 'TEditFocus') Then
      strCodigo := TEditFocus(objCodigo).Text
    Else If (objCodigo.ClassName = 'TMaskEditFocus') Then
      strCodigo := TMaskEditFocus(objCodigo).Text
    Else If (objCodigo.ClassName = 'TMaskEdit') Then
      strCodigo := TMaskEdit(objCodigo).Text
    Else
      strCodigo := '';
  End;

  If (Not fEmptyStr(strCodigo)) Or (stlInfos.Count > 0) Then
  Begin

    If blnNegar Then
    Begin
      If Length(arrLinha) > 1 Then
        Result := ' (' + strNomCampo + ' NOT IN ( ' + fCommaText(stlInfos) + ')) '
      Else
        Result := strNomCampo + ' <> :' + strNomPar + ' ';
    End
    Else
    Begin
      If Length(arrLinha) > 1 Then
        Result := ' (' + strNomCampo + ' IN ( ' + fCommaText(stlInfos) + ')) '
      Else
        Result := strNomCampo + ' = :' + strNomPar + ' ';
    End;

    If Not blnSemAND Then
      Result := '  AND ' + Result;
  End
  Else
    Result := '';

  FreeAndNil(stlInfos);
End;

function fSQLIn(arrLinha: TConsultasArray; strNomCampo: String;
                blnSemAND: Boolean = False; blnNegar: Boolean = False): String;
  Var
    stlInfos: TStringList;
    intContador: Integer;
Begin
  stlInfos := TStringList.Create;

  For intContador := Low(arrLinha) To High(arrLinha) Do
    stlInfos.Add(QuotedStr(arrLinha[intContador].strCodigo));

  If (stlInfos.Count > 0) Then
  Begin

    If blnNegar Then
    Begin
      If Length(arrLinha) > 1 Then
        Result := ' (' + strNomCampo + ' NOT IN ( ' + fCommaText(stlInfos) + ')) '
      Else
        Result := strNomCampo + ' <> ' + stlInfos[0] + ' ';
    End
    Else
    Begin
      If Length(arrLinha) > 1 Then
        Result := ' (' + strNomCampo + ' IN ( ' + fCommaText(stlInfos) + ')) '
      Else
        Result := strNomCampo + ' = ' + stlInfos[0] + ' ';
    End;

    If Not blnSemAND Then
      Result := '  AND ' + Result;
  End
  Else
    Result := '';

  FreeAndNil(stlInfos);
End;

function fGetSQLConsultaItensPrecoValidandoEstrutura(strAliasIteger: String = 'ITEGER'; strTabelaPreco: string = '1'; strPreFixo: string = 'ITE_'; blnEfetivacaoPreco: Boolean = False): string;
Begin
   { Se o parametro usar estrutura estiver marcado e o parametro calcular o preço de venda somando as itens da estrutura então faz o sql
     carregar o preço de venda somando as itens da estrutura senão devolve apenas o campo preve* da ITEGER }
    If Pos(strTabelaPreco, '1234567')  = 0 Then
      strTabelaPreco := '1';
    If fCfgSis('CADEST', varBoolean) and (fCfgSis('SUGVLE', varInteger) = 2) Then
    begin
       Result := ' IFNULL( ' +
                ' ( ' +
                '   SELECT SQL_NO_CACHE ' +
                '     SUM(ROUND(DM.DMT_QTDITE * IT.ITE_PREVE' + strTabelaPreco + ', 2)) ' +
                '   FROM ' +
                '     DETMAT DM ' +
                '     INNER JOIN GERMAT GM ON DM.DMT_SEQGER = GM.AUTOINCREM ' +
                '     INNER JOIN ITEGER IT ON DM.DMT_ITESUB = IT.ITE_CODITE ' +
                '   WHERE ' +
                '     GM.GMT_CODITE = ' + strAliasIteGer + '.'+ strPreFixo +'CODITE AND ' +
                '     IT.ITE_CODEMP = ' + strAliasIteGer + '.'+ strPreFixo +'CODEMP ' +
                ' ), ' + strAliasIteGer + '.'+ strPreFixo +'PREVE' + strTabelaPreco + IIF(blnEfetivacaoPreco, '_NOV','') + ') ' ;
   End
   Else
     Result := strAliasIteGer + '.'+ strPreFixo +'PREVE' + strTabelaPreco + IIF(blnEfetivacaoPreco, '_NOV','') + ' ';
End;

Function fCommaTextToQuoted(strLista: String): String;
  Var
    stlLista: TStringList;
Begin
  stlLista := TStringList.Create;
  stlLista.CommaText := strLista;

  Result := fCommaText(stlLista, True);

  FreeAndNil(stlLista)
End;

function fCliForFaturamento(strTipoCliFor, strCodCLiFor: String): Boolean;
  var
    strSQL: string;
    qryMovFat: TUniQuery;
begin
  Result := True;

  if fEmptyStr(strCodCLiFor) then
  begin
    Result := False;
    Exit;
  end;

  try
    if (strTipoCliFor = 'C') or (strTipoCliFor = 'F') then
    begin
      strSQL := '';

      strSQL := strSQL + ' SELECT GER_NUMDOC FROM MOVGER ';
      strSQL := strSQL + ' WHERE GER_TIP_FC = :TIP_FC AND ';
      strSQL := strSQL + IIF( strTipoCliFor = 'C',  ' GER_CODCLI = :CODCLI ',  ' GER_CODFOR = :CODFOR ');
      strSQL := strSQL + ' UNION ALL ';
      strSQL := strSQL + ' SELECT GER_NUMDOC FROM NOTGER ';
      strSQL := strSQL + ' WHERE GER_TIP_FC = :TIP_FC AND  ';
      strSQL := strSQL + IIF( strTipoCliFor = 'C', ' GER_CODCLI = :CODCLI ', ' GER_CODFOR = :CODFOR ');
      strSQL := strSQL + ' LIMIT 1 ';

      try
        qryMovFat := fCriaQuery;
        qryMovFat.SQL.Text := strSql;
        qryMovFat.ParamByName('TIP_FC').AsString := strTipoCliFor;

        if strTipoCliFor = 'C' then
          qryMovFat.ParamByName('CODCLI').AsString := strCodCLiFor
        Else
          qryMovFat.ParamByName('CODFOR').AsString := strCodCLiFor;

        qryMovFat.Open;

        Result := (qryMovFat.RecordCount = 1);

        qryMovFat.Close;
      finally
        FreeAndNil(qryMovFat);
      end;

    end;
  except
    On E: Exception Do
    begin
      pMensagensErro(E.Message,'[untFuncoes.fCliForFaturamento]');
      Result := False;
    end;
  end;

end;

procedure pAdicionaClausulaWhereQry(const qry: TUniQuery; Var strLinha: String; const Sender: TObject;
  const arrLinha: TConsultasArray; const strNomCampo, strNomPar, strConteudoCampo: String;
  const blnSemAND: Boolean = False; blnNegar: Boolean = False; const strCodigo: String = '');
begin
  If Not fEmptyStr(strConteudoCampo) And Assigned(qry) Then
  Begin
    qry.SQL.Add(fStrLocate(Sender, arrLinha, strNomCampo, strNomPar, blnSemAND, blnNegar, strCodigo));
    pSetaParam(strConteudoCampo, arrLinha, strLinha, strNomPar, qry);
  End;
end;


End.
