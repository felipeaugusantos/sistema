unit untImpressaoSeparacao;

interface

uses
  untZClient, untTypesSistema;

  function fImpressaoSeparacaoPorSetor: Boolean;
  function fImprimeSeparacaoFaturamento(strNumDoc, strEspDoc, strCodEmp, strCodCli: String; strCodigoLocSep: String = ''; blnExpFatAut: Boolean = False): Boolean;
  function fGetSQLSeparacao(const strNumDoc, strEspDoc, strCodEmp, strCodCli, strWhere : String; tpeTipEtq: TTipoEtiqueta) : String;

implementation

uses untFuncoesSimples, untFuncFatImp, untFuncFatTypes, untLeDocumento,
  System.SysUtils;

function fImpressaoSeparacaoPorSetor: Boolean;
begin
  Result := fCfgSis('EXPSET', varBoolean) And
            fCfgSis('SEPSET', varBoolean) And
            (Pos(VS_strTipExp, '2_3_4_') > 0);
end;

function fImprimeSeparacaoFaturamento(strNumDoc, strEspDoc, strCodEmp, strCodCli: String; strCodigoLocSep: String = ''; blnExpFatAut: Boolean = False): Boolean;
  Var
    objFatImp : TFatVendaImp;
    documento : TDadosImpressaoVenda;
begin

  objFatImp := TFatVendaImp.Create;
  Try
    documento.strCodCli := strCodCli;
    documento.strNumDoc := strNumDoc;
    documento.strEspDoc := strEspDoc;
    documento.strEmpDoc := strCodEmp;
    documento.strCodLsePorSetor := strCodigoLocSep;
    documento.blnExpedi := True;
    documento.blnExpFatAut := blnExpFatAut;
    documento.blnEnt_CD := (Pos(documento.strEspDoc, 'OR_PD_') > 0) And
                           (fPedidoEntregaCD(documento.strNumDoc,
                                             documento.strEspDoc,
                                             documento.strEmpDoc,
                                             documento.strCodCli));

    objFatImp.Add(documento);
    Result := objFatImp.fImprimeSeparacao(objFatImp[0],
                                          '',
                                          '',
                                          False,
                                          -1,
                                          TFatVendaImp.fItensDocumento(documento.strNumDoc,
                                                                       documento.strEspDoc,
                                                                       documento.strEmpDoc,
                                                                       documento.strCodCli));
  Finally
    If Assigned(objFatImp) Then
      objFatImp.Destroy;
  End;
end;

function fGetSQLSeparacao(const strNumDoc, strEspDoc, strCodEmp, strCodCli, strWhere : String; tpeTipEtq: TTipoEtiqueta) : String;
  Var
    objLeDoc: TLeDocumento;
begin
  objLeDoc := fEspecieToClassDocumento(strNumDoc, strEspDoc, strCodEmp, 'C', True,
                                       False, False, tpeTipEtq).Create(Nil);
  Try
    objLeDoc.recDocume.blnDocSep   := True;
    objLeDoc.recDocume.strNumDoc   := strNumDoc;
    objLeDoc.recDocume.strEspDoc   := strEspDoc;
    objLeDoc.recDocume.strCodEmp   := strCodEmp;
    objLeDoc.recDocume.strCodCli   := strCodCli;
    objLeDoc.recDocume.strTipFC    := 'C';
    objLeDoc.recDocume.blnDocSep   := True;
    objLeDoc.recDocume.strWhereSep := strWhere;
    Result := objLeDoc.fSQLItems;
  Finally
    FreeAndNil(objLeDoc);
  End;
end;

end.
