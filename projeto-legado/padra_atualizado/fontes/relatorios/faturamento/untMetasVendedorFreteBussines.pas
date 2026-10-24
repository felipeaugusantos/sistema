unit untMetasVendedorFreteBussines;

interface

uses
  Classes, SysUtils, untRelFatMetasVendedorFreteIntf, untMetasVendedorFreteDao,
  frxClass, EditFocus, frxDBSet;

type
  TMetasVendedorFreteBussines = Class
  private
  public
    class function fGeraRelatorio(objMetasVendedorFrete: IMetasVendedorFrete; frxRelatorio: TfrxDBDataset): Boolean;
    class function fGetTotalMeta(strCodVen, strDtaIni, strDtaFim: String): Double;
  end;

implementation

uses untRelFatMetasVendedorFreteTypes, untFuncoesFactory, untIFuncoes,
  untTypesSistema;

{ TMetasVendedorFreteBussines }

class function TMetasVendedorFreteBussines.fGeraRelatorio(
  objMetasVendedorFrete: IMetasVendedorFrete; frxRelatorio: TfrxDBDataset): Boolean;
  Var
    objMetasVendedorFreteDao: TMetasVendedorFreteDao;
    strOpcRel,
    strTitulo,
    strPeriodo,
    strTipVen,
    strDiaFat: String;
begin
  Result := False;
  objMetasVendedorFreteDao := TMetasVendedorFreteDao.Create;

  If objMetasVendedorFreteDao.fGetDataSetRelatorio(objMetasVendedorFrete) Then
  Begin
    frxRelatorio.DataSet := objMetasVendedorFrete.cdsRelatorio;

    If objMetasVendedorFrete.torOpcao = orAnalitico Then
      strOpcRel := 'ANALÍTICO'
    Else
      strOpcRel := 'SINTÉTICO';

    strTitulo  := 'RELATÓRIO DE METAS POR VENDEDOR - FRETE - ' + strOpcRel;// + IIF(objMetasVendedorFrete.intGlobal = 0, '[*]', IIF(objMetasVendedorFrete.intGlobal = 1, '[**]', '[*/**]'));
    strPeriodo := 'REFERENTE AO PERÍODO DE ' + objMetasVendedorFrete.strMesIni + ' A ' + objMetasVendedorFrete.strMesFin;

    If SameText(objMetasVendedorFrete.strTipImp, 'J') Then
    Begin
      objMetasVendedorFrete.frxRel.DotMatrixReport           := False;
      objMetasVendedorFrete.frxRel.PrintOptions.PrintMode    := pmScale;
      objMetasVendedorFrete.frxRel.PrintOptions.PrintOnSheet := 9;
      TfrxMemoView(objMetasVendedorFrete.frxRel.FindObject('mmoZebra')).Highlight.Color := fCfgSis('CORZEB');
    End
    Else
    Begin
      strTitulo  := fRemoveAcento(strTitulo);
      strPeriodo := fRemoveAcento(strPeriodo);
    End;

    objMetasVendedorFrete.frxRel.Script.Variables['NOMREL']       := strTitulo;
    objMetasVendedorFrete.frxRel.Script.Variables['PERIODO']      := strPeriodo;
    objMetasVendedorFrete.frxRel.Script.Variables['VENDEDOR']     := fStrTitulo(TEditFocus(objMetasVendedorFrete.cmsCodVen.edtCodigo).Text,
                                                                                TEditFocus(objMetasVendedorFrete.cmsCodVen.edtDescri),
                                                                                objMetasVendedorFrete.cmsCodVen.arrSelecao,
                                                                                objMetasVendedorFrete.cmsCodVen.strSelecao,
                                                                                'VENDEDOR');

    objMetasVendedorFrete.frxRel.Script.Variables['DEPARTAMENTO'] := fStrTitulo(TEditFocus(objMetasVendedorFrete.cmsCodDep.edtCodigo).Text,
                                                                                TEditFocus(objMetasVendedorFrete.cmsCodDep.edtDescri),
                                                                                objMetasVendedorFrete.cmsCodDep.arrSelecao,
                                                                                objMetasVendedorFrete.cmsCodDep.strSelecao,
                                                                                'DEPARTAMENTO');


    objMetasVendedorFrete.frxRel.Script.Variables['EMPRESA']      := fStrTitulo(TEditFocus(objMetasVendedorFrete.cmsCodEmp.edtCodigo).Text,
                                                                                TEditFocus(objMetasVendedorFrete.cmsCodEmp.edtDescri),
                                                                                objMetasVendedorFrete.cmsCodEmp.arrSelecao,
                                                                                objMetasVendedorFrete.cmsCodEmp.strSelecao,
                                                                                IIF(objMetasVendedorFrete.teoEmpOri = eoFaturamento, 'EMPRESA(FATURAMENTO)', 'EMPRESA(ORIGEM)'));

    If objMetasVendedorFrete.ttvTipVen = tvInterno Then
      strTipVen := 'INTERNO'
    Else If objMetasVendedorFrete.ttvTipVen = tvExterno Then
      strTipVen := 'EXTERNO'
    Else If objMetasVendedorFrete.ttvTipVen = tvTodos Then
      strTipVen := 'TODOS';
      
    If objMetasVendedorFrete.intDiaFat > 0 Then
      strDiaFat := 'ÚLTIMO DIA FATURAMENTO: ' + IntToStr(objMetasVendedorFrete.intDiaFat)
    Else
      strDiaFat := '';

    objMetasVendedorFrete.frxRel.Script.Variables['TIPO']   := 'TIPO VENDEDOR: ' + strTipVen;
    objMetasVendedorFrete.frxRel.Script.Variables['DIAFAT'] := IIF(SameText(objMetasVendedorFrete.strTipImp, 'M'), fRemoveAcento(strDiaFat), strDiaFat);

    If objMetasVendedorFrete.tdrDestino = drVideo Then
      pPreviewReport(objMetasVendedorFrete.strNomFrm, 'Relatório de Metas por Vendedor - Frete', objMetasVendedorFrete.frxRel)
    Else If objMetasVendedorFrete.frxRel.PrepareReport Then
      pPrintReport(objMetasVendedorFrete.strNomFrm, 'Relatório de Metas por Vendedor - Frete', objMetasVendedorFrete.strNomImp, objMetasVendedorFrete.frxRel);

    Result := True;
  End;

  objMetasVendedorFrete.cmsCodEmp.Destroy;
  objMetasVendedorFrete.cmsCodVen.Destroy;
  objMetasVendedorFrete.cmsCodDep.Destroy;
  objMetasVendedorFreteDao.Free;
end;

class function TMetasVendedorFreteBussines.fGetTotalMeta(strCodVen, strDtaIni,
  strDtaFim: String): Double;
  Var
    objMetasVendedorFreteDao: TMetasVendedorFreteDao;
begin
  objMetasVendedorFreteDao := TMetasVendedorFreteDao.Create;
  Result := objMetasVendedorFreteDao.fGetTotalMeta(strCodVen, strDtaIni, strDtaFim);
  objMetasVendedorFreteDao.Free;
end;

end.
