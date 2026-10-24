unit untIcmsSTParteVenda;

interface

uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'}, Shared.Core,
{$ELSE}
  untFuncoesSimples, UniClientDataSet,
{$ENDIF}
  Classes, SysUtils, DB, Uni,
  untTConfiguracao,
  untFuncoesGenerica,
  untParCalculaPrecoCusto,
  Shared.Functions.DataSet,
  Faturamento.Connections.Functions;

function fGetIcmsSTParteVenda(strCodAbf, strTipAbf, strCodSit, strEstCli: String; fltPreComLiq, fltIpiEnt, fltIcmsSai: Double; strEstEmp: String; var blnST: Boolean; strMarMkp: String = ''): Double; overload;
function fGetIcmsSTParteVenda(strCodAbf, strTipAbf, strCodSit, strEstCli: String; fltPreComLiq, fltIpiEnt, fltIcmsSai: Double; fltIva: Double; strEstEmp: String; var blnST: Boolean; strMarMkp: String = ''): Double; overload;

Type
  TrecDadosFormacaoCusto = record
    fltPreCom : Double;
    fltDesf01 : Double;
    fltDesf02 : Double;
    fltDesf03 : Double;
    fltDesf04 : Double;
    fltDesf05 : Double;
    fltDesf06 : Double;
    fltDesf07 : Double;
    fltIcmEnt : Double;
    fltIpiEnt : Double;
    fltFreEnt : Double;
    fltValFre : Double;
    fltAcrFin : Double;
    fltSubsti : Double;
    fltSubFed : Double;
    fltDesAdb : Double;
    fltTCIFCu : Double;
    fltTSCust : Double;
    fltDePiCo : Double;
    fltDeICMS : Double;
    fltFatReg : Double;
  End;

function fRetPrecoCusto(Const blnUtilizarConversorDeMoeda: Boolean; recDadosFormacaoCusto: TrecDadosFormacaoCusto): Double;

Type
  TfncGetAlqDifIcms = function(strCodIte, strEmpIte, strCodAbf, strCodFis: String; fltAlqIcm: Double): Double of object;

type
  TIcmsSTParteVenda = class(TComponent)
  private
    intDecUni,
    intSequen : Integer;
    cdsItens : TUniClientDataSet;
    cdsIcms : TUniClientDataSet;
    strEstEmp : String;
    fncGetAlqDifIcms: TfncGetAlqDifIcms;
    function fCriaCdsItens(cmpSelf: TComponent = Nil): TUniClientDataSet;
    function fCriaCdsIcms(cmpSelf: TComponent = Nil): TUniClientDataSet;
    procedure pCarregaDadosItem(strCodIte, strCodEmp: String; out objDadosItem: IMyCampoTabela);
    function fUsaPrecoDinamico: Boolean;
  public
    constructor Create(AOwner: TComponent; fncGetAlqDifIcms: TfncGetAlqDifIcms = Nil); reintroduce;
    destructor Destroy; override;
    procedure pAdd(strCodIte, strCodEmp, strTipAbf, strEstDes, strCodSit: String; var fltIcStPv: Double; var blnCalcST: Boolean; fltDesF07: Double = 0; fltComLiqCampanha: Double = 0);
    function fGetDataSet: TDataSet;
    function fPegaPrecoVenda(strCodIte, strCodEmp, strCodCli, strTabPre, strEstDes: String; fltIcmSai: Double; fltDesF07: Double; var fltPreCus: Double): Double;
    function fGetIcmSai(strCodIte, strCodEmp: String): Double;
  end;

implementation

{ TIcmsSTParteVenda }

uses untConstantes, untConstantesNFe;

constructor TIcmsSTParteVenda.Create(AOwner: TComponent; fncGetAlqDifIcms: TfncGetAlqDifIcms = Nil);
begin
  Inherited Create(AOwner);
  cdsItens := fCriaCdsItens(Self);
  cdsIcms := fCriaCdsIcms(Self);
  intSequen := 0;
  strEstEmp := fCadEmp('ESTADO');
  intDecUni := fCfgSis('DECUNI');
  Self.fncGetAlqDifIcms := fncGetAlqDifIcms;
end;

destructor TIcmsSTParteVenda.Destroy;
begin
  Self.fncGetAlqDifIcms := Nil;
  FreeAndNil(cdsItens);
  FreeAndNil(cdsIcms);
  inherited;
end;

procedure TIcmsSTParteVenda.pAdd(strCodIte, strCodEmp, strTipAbf,
  strEstDes, strCodSit: String; var fltIcStPv: Double; var blnCalcST: Boolean; fltDesF07: Double = 0;
  fltComLiqCampanha: Double = 0);
  Var
    blnST : Boolean;
    fltPrCoLq : Double;
    fltIcmSai : Double;
    objDadosItem: IMyCampoTabela;
    blnPermiteRecalcular: Boolean;
    blnPermiteAdicionar: Boolean;
begin
  fltIcStPv := 0;
  blnCalcST := False;

  If fEmptyStr(strCodIte) Then
    Exit;

  If (Not fUsaPrecoDinamico) Then
    Exit;

  fltIcmSai := fGetIcmSai(strCodIte, strCodEmp);

  If (fltComLiqCampanha = 0) Then
  Begin
    blnPermiteRecalcular := (Not cdsItens.FindKey([strCodIte, strCodEmp, strTipAbf, strEstDes, strCodSit, fltIcmSai, fltDesF07]));
    blnPermiteAdicionar  := True;
  End
  ELse
  Begin
    blnPermiteRecalcular := True;
    blnPermiteAdicionar  := (Not cdsItens.FindKey([strCodIte, strCodEmp, strTipAbf, strEstDes, strCodSit, fltIcmSai, fltDesF07]));
  End;

  If blnPermiteRecalcular Then
  Begin
    Try
      pCarregaDadosItem(strCodIte, strCodEmp, objDadosItem);

      If (Not fEmptyStr(objDadosItem.FieldByName('ITE_CODITE'))) Then
      Begin
        If blnPermiteAdicionar Then
          intSequen := intSequen + 1;

        If (fltComLiqCampanha = 0) Then
        Begin
          fltPrCoLq := fCalculaPrecoCompraLiquido(objDadosItem.FieldByName('ITE_PRECOM'),
                                                  objDadosItem.FieldByName('ITE_DESF01'),
                                                  objDadosItem.FieldByName('ITE_DESF02'),
                                                  objDadosItem.FieldByName('ITE_DESF03'),
                                                  objDadosItem.FieldByName('ITE_DESF04'),
                                                  objDadosItem.FieldByName('ITE_DESF05'),
                                                  objDadosItem.FieldByName('ITE_DESF06'),
                                                  intDecUni,
                                                  objDadosItem.FieldByName('ITE_PREDOL').AsBoolean,
                                                  fltDesF07);
        End
        Else
          fltPrCoLq := fltComLiqCampanha;

        If blnPermiteAdicionar Then
        Begin
          cdsItens.Append;
          cdsItens.FieldByName('ITE_SEQUEN').AsInteger := intSequen;
        End
        Else
          cdsItens.Edit;

        cdsItens.FieldByName('ITE_CODITE').AsString := strCodIte;
        cdsItens.FieldByName('ITE_CODEMP').AsString := strCodEmp;
        cdsItens.FieldByName('ITE_TIPABF').AsString := strTipAbf;
        cdsItens.FieldByName('ITE_ESTDES').AsString := strEstDes;
        cdsItens.FieldByName('ITE_ICMSAI').AsFloat := fltIcmSai;

        If (fCfgSis('MARMKP') = '4') And (Pos(strCodSit, CST_SUBSTITUICAO) > 0) And (Not fEmptyStr(objDadosItem.FieldByName('ITE_CODABF'))) And (Not fEmptyStr(strEstDes)) And (Not fEmptyStr(strTipAbf)) And
           (strEstDes = strEstEmp) Then
          cdsItens.FieldByName('ITE_VALIVA').AsFloat := fRetornaPercIVA(objDadosItem.FieldByName('ITE_CODABF'), strEstDes, '_SAI_CCO')
        Else
          cdsItens.FieldByName('ITE_VALIVA').AsFloat := fRetornaPercIVA(objDadosItem.FieldByName('ITE_CODABF'), strEstDes, strTipAbf);

        cdsItens.FieldByName('ITE_ICSTPV').AsFloat := fGetIcmsSTParteVenda(objDadosItem.FieldByName('ITE_CODABF'), strTipAbf, strCodSit,
                                                                           strEstDes, fltPrCoLq,
                                                                           objDadosItem.FieldByName('ITE_IPIENT'),
                                                                           fltIcmSai, cdsItens.FieldByName('ITE_VALIVA').AsFloat,
                                                                           strEstEmp,
                                                                           blnST);
        cdsItens.FieldByName('ITE_CALCST').AsBoolean := blnST;
        cdsItens.FieldByName('ITE_CODSIT').AsString := strCodSit;
        cdsItens.FieldByName('ITE_DESF07').AsFloat := fltDesF07;
        cdsItens.Post;
      End;
    Finally

    End;
  End;

  fltIcStPv := cdsItens.FieldByName('ITE_ICSTPV').AsFloat;
  blnCalcST := cdsItens.FieldByName('ITE_CALCST').AsBoolean;
end;

function TIcmsSTParteVenda.fCriaCdsIcms(cmpSelf: TComponent = Nil): TUniClientDataSet;
begin
  Result := TUniClientDataSet.Create(cmpSelf);
  With Result, FieldDefs Do
  Begin
    With AddFieldDef Do Begin Name := 'ITE_CODITE'; DataType := ftString; Size := fTamCodIte; Required := False; End;
    With AddFieldDef Do Begin Name := 'ITE_CODEMP'; DataType := ftString; Size := 03; Required := False; End;
    With AddFieldDef Do Begin Name := 'ITE_ICMSAI'; DataType := ftFloat;  Required := False; End;
    IndexFieldNames := 'ITE_CODITE;ITE_CODEMP';
    CreateDataSet;
    Open;
    LogChanges := False;
  End;
end;

function TIcmsSTParteVenda.fCriaCdsItens(cmpSelf: TComponent = Nil): TUniClientDataSet;
Begin
  Result := TUniClientDataSet.Create(cmpSelf);
  With Result, FieldDefs Do
  Begin
    With AddFieldDef Do Begin Name := 'ITE_CODITE'; DataType := ftString; Size := fTamCodIte; Required := False; End;
    With AddFieldDef Do Begin Name := 'ITE_CODEMP'; DataType := ftString; Size := 03; Required := False; End;
    With AddFieldDef Do Begin Name := 'ITE_TIPABF'; DataType := ftString; Size := 30; Required := False; End;
    With AddFieldDef Do Begin Name := 'ITE_ESTDES'; DataType := ftString; Size := 02; Required := False; End;
    With AddFieldDef Do Begin Name := 'ITE_CODSIT'; DataType := ftString; Size := 03; Required := False; End;
    With AddFieldDef Do Begin Name := 'ITE_ICMSAI'; DataType := ftFloat;  Required := False; End;
    With AddFieldDef Do Begin Name := 'ITE_ICSTPV'; DataType := ftFloat;  Required := False; End;
    With AddFieldDef Do Begin Name := 'ITE_CALCST'; DataType := ftBoolean;  Required := False; End;
    With AddFieldDef Do Begin Name := 'ITE_VALIVA'; DataType := ftFloat;  Required := False; End;
    With AddFieldDef Do Begin Name := 'ITE_SEQUEN'; DataType := ftInteger;  Required := False; End;
    With AddFieldDef Do Begin Name := 'ITE_PRECUS'; DataType := ftFloat;  Required := False; End;
    With AddFieldDef Do Begin Name := 'ITE_DESF07'; DataType := ftFloat;  Required := False; End;
    IndexFieldNames := 'ITE_CODITE;ITE_CODEMP;ITE_TIPABF;ITE_ESTDES;ITE_CODSIT;ITE_ICMSAI;ITE_DESF07';
    CreateDataSet;
    Open;
    LogChanges := False;
  End;
End;

function TIcmsSTParteVenda.fGetDataSet: TDataSet;
begin
  Result := cdsItens;
end;

function TIcmsSTParteVenda.fGetIcmSai(strCodIte, strCodEmp: String): Double;
begin
  If (cdsIcms.FindKey([strCodIte, strCodEmp])) Then
    Result := cdsIcms.FieldByName('ITE_ICMSAI').AsFloat
  Else
  Begin
    Result := fCampoTabela('ITE_ICMSAI', 'ITEGER', ['ITE_CODITE', 'ITE_CODEMP'], [strCodIte, strCodEmp], False);

    cdsIcms.Insert;
    cdsIcms.FieldByName('ITE_CODITE').AsString := strCodIte;
    cdsIcms.FieldByName('ITE_CODEMP').AsString := strCodEmp;
    cdsIcms.FieldByName('ITE_ICMSAI').AsFloat := Result;
    cdsIcms.Post;
  End;
end;

function TIcmsSTParteVenda.fPegaPrecoVenda(strCodIte, strCodEmp, strCodCli,
  strTabPre, strEstDes: String; fltIcmSai: Double; fltDesF07: Double; var fltPreCus: Double): Double;
  Var
    fltImcSTPV : Double;
    blnCalcST : Boolean;
    strTipAbf : String;
    strCodSit : String;
    fltIcmDif : Double;
    fltPreCusCalc: Double;
    objDadosItem: IMyCampoTabela;
    blnUtilizarConversorDeMoedas : Boolean;
    recDadosFormacaoCusto : TrecDadosFormacaoCusto;

    dtaUltDataCompra: TDateTime;
    strUltDocumento: String;
    fltUltPrecoCompra: Double;
    strUltFornecedor: String;
    fltCreIcm : Double;
    fltCre_ST : Double;
    qryConsul : TUniQuery;
begin
  Try
    FillChar(recDadosFormacaoCusto, SizeOf(recDadosFormacaoCusto), #0);

    strTipAbf := fGetTipoAbfCliente(strCodCli);

    pCarregaDadosItem(strCodIte, strCodEmp, objDadosItem);

    If Not fEmptyStr(strTipAbf) Then
      strCodSit := fCampoTabela('ABF_CODSIT'  + strTipAbf, 'ABFICM', ['ABF_CODABF', 'ABF_ESTADO'], [objDadosItem.FieldByName('ITE_CODABF'), strEstDes], False)
    Else
      strCodSit := '';

    fltIcmDif := 0;
    If (Assigned(fncGetAlqDifIcms)) Then
      fltIcmDif := fncGetAlqDifIcms(strCodIte, strCodEmp, objDadosItem.FieldByName('ITE_CODABF'), strCodSit, fltIcmSai);

    Self.pAdd(strCodIte,
              strCodEmp,
              strTipAbf,
              strEstDes,
              strCodSit,
              fltImcSTPV,
              blnCalcST,
              fltDesF07);

    If (fFormataFloat(fltDesF07, 2) > 0) Then
    Begin
      blnUtilizarConversorDeMoedas := (objDadosItem.FieldByName('ITE_PREDOL').AsBoolean);

      recDadosFormacaoCusto.fltPreCom := objDadosItem.FieldByName('ITE_PRECOM');
      recDadosFormacaoCusto.fltDesf01 := objDadosItem.FieldByName('ITE_DESF01');
      recDadosFormacaoCusto.fltDesf02 := objDadosItem.FieldByName('ITE_DESF02');
      recDadosFormacaoCusto.fltDesf03 := objDadosItem.FieldByName('ITE_DESF03');
      recDadosFormacaoCusto.fltDesf04 := objDadosItem.FieldByName('ITE_DESF04');
      recDadosFormacaoCusto.fltDesf05 := objDadosItem.FieldByName('ITE_DESF05');
      recDadosFormacaoCusto.fltDesf06 := objDadosItem.FieldByName('ITE_DESF06');
      recDadosFormacaoCusto.fltDesf07 := fltDesF07;
      recDadosFormacaoCusto.fltIcmEnt := objDadosItem.FieldByName('ITE_ICMENT');
      recDadosFormacaoCusto.fltIpiEnt := objDadosItem.FieldByName('ITE_IPIENT');
      recDadosFormacaoCusto.fltFreEnt := objDadosItem.FieldByName('ITE_FREENT');
      recDadosFormacaoCusto.fltValFre := objDadosItem.FieldByName('ITE_VALFRE');
      recDadosFormacaoCusto.fltAcrFin := objDadosItem.FieldByName('ITE_ACRFIN');
      recDadosFormacaoCusto.fltSubsti := objDadosItem.FieldByName('ITE_SUBSTI');
      recDadosFormacaoCusto.fltSubFed := objDadosItem.FieldByName('ITE_SUBFED');
      recDadosFormacaoCusto.fltDesAdb := objDadosItem.FieldByName('ITE_DESADB');
      recDadosFormacaoCusto.fltTCIFCu := objDadosItem.FieldByName('ITE_TCIFCU');
      recDadosFormacaoCusto.fltTSCust := objDadosItem.FieldByName('ITE_TSCUST');
      recDadosFormacaoCusto.fltDePiCo := objDadosItem.FieldByName('ITE_DEPICO');
      recDadosFormacaoCusto.fltDeICMS := objDadosItem.FieldByName('ITE_DEICMS');
      recDadosFormacaoCusto.fltFatReg := objDadosItem.FieldByName('ITE_FATREG');

      fltPreCusCalc := fRetPrecoCusto(blnUtilizarConversorDeMoedas, recDadosFormacaoCusto);
      fltPreCus := fltPreCusCalc;
    End
    Else
    Begin
      fltPreCusCalc := objDadosItem.FieldByName('ITE_PRECUS');

      If (fCfgSis('MCAT17') = 'M') Then
      Begin
        If fGetInformacoesUltimaCompra(strCodIte, dtaUltDataCompra, strUltDocumento, fltUltPrecoCompra, strUltFornecedor) Then
        Begin
          qryConsul := fCriaQuery(Self);

          qryConsul.Close;
          qryConsul.SQL.Clear;
          qryConsul.SQL.Add(' SELECT IFNULL(DET_VAERET, 0.00) + IFNULL(DET_VLGNRE, 0.00) AS DET_VALRET,');
          qryConsul.SQL.Add('        IFNULL(DE.N16_PICMS, 0.00) AS DET_ALQICM, DET_QTDITE, DET_DTAENT, ');
          qryConsul.SQL.Add('        ROUND(IFNULL( DE.N17_VICMS,0),2) AS DET_VALICM ');
          qryConsul.SQL.Add('   FROM MOVDET D ');
          qryConsul.SQL.Add('   LEFT  JOIN MOVTRI T  ON T.DET_SEQGER  = D.AUTOINCREM ');
          qryConsul.SQL.Add('   LEFT  JOIN GERELE GE ON GE.GER_DOCENT = D.DET_NUMDOC ');
          qryConsul.SQL.Add('                       AND GE.GER_ESPENT = D.DET_ESPDOC ');
          qryConsul.SQL.Add('                       AND GE.GER_EMPENT = D.DET_CODEMP ');
          qryConsul.SQL.Add('                       AND GE.GER_CODFOR = D.DET_CODFOR ');
          qryConsul.SQL.Add('                       AND IFNULL(GE.B07_SERIE, "") = IFNULL(D.DET_SERIE_, "") ');
          qryConsul.SQL.Add('   LEFT JOIN DETELE DE ON DE.DET_SEQGER = GE.AUTOINCREM ');
          qryConsul.SQL.Add('                      AND DE.DET_CODITE = D.DET_CODITE ');
          qryConsul.SQL.Add('  WHERE D.DET_NUMDOC = :NUMDOC ');
          qryConsul.SQL.Add('    AND D.DET_ESPDOC = :ESPDOC ');
          qryConsul.SQL.Add('    AND D.DET_CODEMP = :CODEMP ');
          qryConsul.SQL.Add('    AND D.DET_CODFOR = :CODFOR ');
          qryConsul.SQL.Add('    AND D.DET_CODITE = :CODITE ');
          qryConsul.SQL.Add('    AND LOCATE(D.DET_CODFIS, :CODFIS) > 0 ');

          qryConsul.ParamByName('NUMDOC').AsString := Copy(strUltDocumento, 01, 12);
          qryConsul.ParamByName('ESPDOC').AsString := Copy(strUltDocumento, 13, 02);
          qryConsul.ParamByName('CODEMP').AsString := Copy(strUltDocumento, 15, 03);
          qryConsul.ParamByName('CODFOR').AsString := strUltFornecedor;
          qryConsul.ParamByName('CODFIS').AsString := CST_SUBSTITUICAO;
          qryConsul.ParamByName('CODITE').AsString := strCodIte;
          qryConsul.Open;

          If (Not qryConsul.IsEmpty) And (qryConsul.FieldByName('DET_QTDITE').AsFloat <> 0) And
             ((qryConsul.FieldByName('DET_VALRET').AsFloat > 0) Or (qryConsul.FieldByName('DET_ALQICM').AsFloat > 0)) Then
          Begin
            fltCre_ST := (qryConsul.FieldByName('DET_VALRET').AsFloat  / qryConsul.FieldByName('DET_QTDITE').AsFloat);
            fltCreIcm := (qryConsul.FieldByName('DET_VALICM').AsFloat  / qryConsul.FieldByName('DET_QTDITE').AsFloat);
            fltPreCusCalc  := fFormataFloat(fltPreCusCalc - fltCre_ST - fltCreIcm, 2);
          End;

          qryConsul.Close;

          FreeAndNil(qryConsul);
        End;
      end;

    End;

    Result := fCalculaPrecoVenda(1,
                                 fltPreCusCalc + objDadosItem.FieldByName('ITE_OUTVAL').AsFloat,
                                 objDadosItem.FieldByName('ITE_PREVE' + strTabPre),
                                 objDadosItem.FieldByName('ITE_MARBR' + strTabPre),
                                 fltIcmSai + fltIcmDif,
                                 objDadosItem.FieldByName('ITE_IMPFED'),
                                 objDadosItem.FieldByName('ITE_DESOPE').AsFloat + fCampoTabela('CLI_DESOPE', 'CADCLI', ['CLI_CODCLI'], [strCodCli], False),
                                 objDadosItem.FieldByName('ITE_COMTB' + strTabPre),
                                 '',
                                 '',
                                 -1,
                                 fltImcSTPV,
                                 blnCalcST);
  Finally

  End;
end;

function TIcmsSTParteVenda.fUsaPrecoDinamico: Boolean;
  const
    MARKUP_RITEC : String = '4';
begin
  Result := True;

  If (fCfgSis('CLPVDI', varBoolean)) Then
    Exit;

  If (fCfgSis('MARMKP', varString) = MARKUP_RITEC) Then
    Exit;

  Result := False;
end;

procedure TIcmsSTParteVenda.pCarregaDadosItem(strCodIte, strCodEmp: String; out objDadosItem: IMyCampoTabela);
Var
  qryItem: TUniQuery;
begin
  qryItem := fCriaQuery();
  With qryItem Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(' SELECT ');
    SQL.Add('   I.ITE_CODITE, ');

    If fCfgSis('TIPABF') = '1' Then
      SQL.Add(' I.ITE_CODABF AS ITE_CODABF, ')
    Else
      SQL.Add(' G.ITE_CODABF AS ITE_CODABF, ');

    SQL.Add('   ITE_PRECOM, ');
    SQL.Add('   ITE_DESF01, ');
    SQL.Add('   ITE_DESF02, ');
    SQL.Add('   ITE_DESF03, ');
    SQL.Add('   ITE_DESF04, ');
    SQL.Add('   ITE_DESF05, ');
    SQL.Add('   ITE_DESF06, ');
    SQL.Add('   ITE_ICMENT, ');
    SQL.Add('   ITE_PREDOL, ');
    SQL.Add('   ITE_IPIENT, ');
    SQL.Add('   ITE_FREENT, ');
    SQL.Add('   ITE_VALFRE, ');
    SQL.Add('   ITE_ACRFIN, ');
    SQL.Add('   ITE_SUBSTI, ');
    SQL.Add('   ITE_SUBFED, ');
    SQL.Add('   ITE_DESADB, ');
    SQL.Add('   ITE_PRECUS, ');
    SQL.Add('   ITE_ICMSAI, ');
    SQL.Add('   ITE_IMPFED, ');
    SQL.Add('   ITE_DESOPE, ');
    SQL.Add('   ITE_OUTVAL, ');
    SQL.Add('   ITE_MARBR1, ');
    SQL.Add('   ITE_MARBR2, ');
    SQL.Add('   ITE_MARBR3, ');
    SQL.Add('   ITE_MARBR4, ');
    SQL.Add('   ITE_MARBR5, ');
    SQL.Add('   ITE_MARBR6, ');
    SQL.Add('   ITE_MARBR7, ');
    SQL.Add('   ITE_COMTB1, ');
    SQL.Add('   ITE_COMTB2, ');
    SQL.Add('   ITE_COMTB3, ');
    SQL.Add('   ITE_COMTB4, ');
    SQL.Add('   ITE_COMTB5, ');
    SQL.Add('   ITE_COMTB6, ');
    SQL.Add('   ITE_COMTB7, ');
    SQL.Add('   ITE_PREVE1, ');
    SQL.Add('   ITE_PREVE2, ');
    SQL.Add('   ITE_PREVE3, ');
    SQL.Add('   ITE_PREVE4, ');
    SQL.Add('   ITE_PREVE5, ');
    SQL.Add('   ITE_PREVE6, ');
    SQL.Add('   ITE_PREVE7, ');
    SQL.Add('   G.ITE_TCIFCU, ');
    SQL.Add('   G.ITE_TSCUST, ');
    SQL.Add('   G.ITE_DEPICO, ');
    SQL.Add('   G.ITE_DEICMS, ');
    SQL.Add('   G.ITE_FATREG ');
    SQL.Add('   FROM CADITE I ');
    SQL.Add('   JOIN ITEGER G ON G.ITE_CODITE = I.ITE_CODITE ');
    SQL.Add('                AND G.ITE_CODEMP = :CODEMP ');
    SQL.Add('  WHERE I.ITE_CODITE = :CODITE ');

    ParamByName('CODITE').AsString := strCodIte;
    ParamByName('CODEMP').AsString := strCodEmp;

    objDadosItem := ExecutarQueryEmCache(qryItem);
  End;
  FreeAndNil(qryItem);
end;

function fGetIcmsSTParteVenda(strCodAbf, strTipAbf, strCodSit, strEstCli: String; fltPreComLiq, fltIpiEnt, fltIcmsSai: Double; fltIva: Double; strEstEmp: String; var blnST: Boolean; strMarMkp: String = ''): Double; overload;
  Var
    fltBasCalST : Double;
begin
  blnST := False;
  Result := 0.0;

  If fEmptyStr(strMarMkp) Then
    strMarMkp := fCfgSis('MARMKP');

  If (strMarMkp = '4') And (Pos(strCodSit, CST_SUBSTITUICAO) > 0) And (Not fEmptyStr(strCodAbf)) And (Not fEmptyStr(strEstCli)) And (Not fEmptyStr(strTipAbf)) And
     (strEstCli = strEstEmp) Then
  Begin
    blnST := True;
    fltBasCalST := (fltPreComLiq + (fltPreComLiq * ( fltIpiEnt / 100 ))) * fltIva;
    Result := (fltBasCalST * (fltIcmsSai / 100));
  End;
end;

function fGetIcmsSTParteVenda(strCodAbf, strTipAbf, strCodSit, strEstCli: String; fltPreComLiq, fltIpiEnt, fltIcmsSai: Double; strEstEmp: String; var blnST: Boolean; strMarMkp: String = ''): Double;
  Var
    fltIva : Double;
begin
  If (strEstCli <> strEstEmp) Then
  Begin
    blnST := False;
    Result := 0;
    Exit;
  End;

  fltIva := fRetornaPercIVA(strCodAbf, strEstCli, strTipAbf);
  Result := fGetIcmsSTParteVenda(strCodAbf, strTipAbf, strCodSit, strEstCli, fltPreComLiq, fltIpiEnt, fltIcmsSai, fltIva, strEstEmp, blnST, strMarMkp);
end;

function fRetPrecoCusto(Const blnUtilizarConversorDeMoeda: Boolean; recDadosFormacaoCusto: TrecDadosFormacaoCusto): Double;
  Var
    cpcParams : TParCalculaPrecoCusto;
begin
  cpcParams := TParCalculaPrecoCusto.Create(Nil, TConfiguracao.fGetConfiguracao, True, True);
  Try
    With cpcParams Do
    Begin
      curPreCom := recDadosFormacaoCusto.fltPreCom;
      curDesF01 := recDadosFormacaoCusto.fltDesf01;
      curDesF02 := recDadosFormacaoCusto.fltDesf02;
      curDesF03 := recDadosFormacaoCusto.fltDesf03;
      curDesF04 := recDadosFormacaoCusto.fltDesf04;
      curDesF05 := recDadosFormacaoCusto.fltDesf05;
      curDesF06 := recDadosFormacaoCusto.fltDesf06;
      curDesF07 := recDadosFormacaoCusto.fltDesf07;
      curICMSEnt:= recDadosFormacaoCusto.fltIcmEnt;
      curIPIEnt := recDadosFormacaoCusto.fltIpiEnt;
      curFrete  := recDadosFormacaoCusto.fltFreEnt;
      curAcrFin := recDadosFormacaoCusto.fltAcrFin;
      curSubsti := recDadosFormacaoCusto.fltSubsti;
      curValFre := recDadosFormacaoCusto.fltValFre;
      curDesAdb := recDadosFormacaoCusto.fltDesAdb;
      curSubFed := recDadosFormacaoCusto.fltSubFed;

      if (fCfgSis('SUFRAM', varBoolean)) and (fCfgSis('FRMCUS', varString) = '4') then
      begin
        curTCIFCu := recDadosFormacaoCusto.fltTCIFCu;
        curTSCust := recDadosFormacaoCusto.fltTSCust;
        curDePiCo := recDadosFormacaoCusto.fltDePiCo;
        curDeICMS := recDadosFormacaoCusto.fltDeICMS;
        curFatReg := recDadosFormacaoCusto.fltFatReg;
      end
      else
      begin
        curTCIFCu := 0;
        curTSCust := 0;
        curDePiCo := 0;
        curDeICMS := 0;
        curFatReg := 0;
      end;
    End;
    Result := cpcParams.fCalculaPrecoCusto(blnUtilizarConversorDeMoeda);
  Finally
    FreeAndNil(cpcParams);
  End;
end;

end.
