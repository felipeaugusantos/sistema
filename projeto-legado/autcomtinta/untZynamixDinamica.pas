unit untZynamixDinamica;

interface

uses SysUtils, Forms, Uni, Classes, untFuncoesSimples,
  StrUtils, untFuncEspecificas, Controls, Dialogs, untConsultaCompTinta,
  untConsultaCompTintaNova,
   Math;

Type
  TfrmConsultaCompTintaZynamix = class(TfrmConsultaCompTintaNova)
  public
    procedure pTarefaFormulacao(Sender: TObject); override;
    procedure pTarefaPrecos(Sender: TObject); override;
    procedure pTarefaVenda(Sender: TObject); override;
  End;

  TformulaZynamixDinamica  = class(TFormulaAutomotiva)
  protected
    function GetPrecoEmbalagem: Double; override;
  public
    procedure pCarregarColorantes; Override;
    procedure pCarregaPrecosBases; override;
    procedure pCalcularPrecos; Override;
  End;

  function fConsultaZynamixDinamica(Sender: TForm): String; stdcall;
  function fConsultaZynamixGeralDinamica(Sender: TForm): String; stdcall;
  function fConsultaZynamixVendaDinamica(Sender: TForm; Var qryCadZyn: TUniQuery; strTabPre: String): String; stdcall;

  function fConsultaZynamixDinamicaInterna(Sender: TForm;
    Var qryCadZyn: TUniQuery; tipoConsulta: TTipoConsulta; strTabPre: String): String; stdcall;

  function fGTinForZynamixDinamica(strIteTin: String; strTipPre: String;
            Var arrFormul: TForMulTinDetArray; Var arrBaixaPigmentos: TBaixaPigmentosArray;
            Var stlItensTraMl: TStringList; fltVolPro: Double): Boolean; stdcall;

  function fDigDadosTintometricos(qryCadZyn: TUniQuery; stlDesEmb, stlProEmbLt,
    stlProEmbGl: TStringList; strProEmbCo,
    strProEmbSp: String; Var strIteEmb,
    strTipEmb, strTipPre: String; Var intQtdEmb: Integer; Var fltPreEmb, fltEmbala,
    fltPreCus, fltPreVen, fltVolPro: Double; strTabPre: String; dicRetorno: TDicionario): Boolean;

  function fRetornaPrecoZynamixDinamica(Sender: TForm; qryTinta: TUniQuery; Var dicRetorno: TDicionario): Boolean;
  function fRetornaDescricaoZynamixDinamica(qryCadZyn: TUniQuery; strDesCor: String): String;

  procedure pRetornaDadosZynamixDinamica(strIteTin: String; dicRetorno: TDicionario);
  function fRetornaUniTraProZynamixDinamica(strTipPre : String; fltPrcTin, fltPrvTin: Double): Double;

  procedure pRetornaTabelaPrecoZynamix(dicRetorno: TDicionario; fltFatorAcerto: Double);

implementation

uses untDigTintaAutomotiva, UniClientDataSet, untClientDataSetFactory, untGravando, Data.DB,untFuncoes,
untIConfTinta,
untICalculadorFatVendas,
untIConsultaTinta,
untTintaMaquina,
untZynamixConsulta;

{ TfrmConsultaCompTintaZynamix }

procedure TfrmConsultaCompTintaZynamix.pTarefaFormulacao(Sender: TObject);
var
  qryGen: TUniQuery;
  strTipEmb     : String;
  intQtdEmb     : Integer;
  strIteEmb     : String;
  strTipPre     : String;
  fltPreEmb     : Double;
  fltEmbala     : Double;
  fltPreCus     : Double;
  fltPreVen     : Double;

  stlDesEmb     : TStringList;
  stlProEmbLt   : TStringList;
  stlProEmbGl   : TStringList;

  strProEmbCo   : String;
  strProEmbSp   : String;

  fltVolPro     : Double;
  dicParams: TDicionario;
  conf: IConfTinta;
begin
  qryGen := nil;
  dicParams := nil;
  stlDesEmb := nil;
  stlProEmbLt := nil;
  stlProEmbGl := nil;
  Try
    Try
      If (Not qryConsulta.Active) Or (qryConsulta.IsEmpty) Then
        Exit;
      conf      := fGetConfTinta('ZYN');

      stlDesEmb := TStringList.Create;
      stlDesEmb.Add('EMBALAGEM');

      qryGen := fCriaQuery(Self);
      qryGen.SQL.Add('SELECT * FROM ZYN_CADZYN WHERE AUTOINCREM = :AUTINC');
      qryGen.ParamByName('AUTINC').AsString := qryConsulta.FieldByName('AUTOINCREM').AsString;
      qryGen.Open;

      stlProEmbGl :=  TStringList.Create;
      stlProEmbLt :=  TStringList.Create;

      stlProEmbGl.Add(conf.fGet('ZYNGDU')); //stlProEmbGl.Add(fArqIniTinta(0, 'Zynamix', 'ZYNGDU', ''));
      stlProEmbLt.Add(conf.fGet('ZYNLDU')); //stlProEmbLt.Add(fArqIniTinta(0, 'Zynamix', 'ZYNLDU', ''));

      strProEmbCo := conf.fGet('ZYNCOP'); //fArqIniTinta(0, 'Zynamix', 'ZYNCOP', '');
      strProEmbSp := conf.fGet('ZYNSPR'); //fArqIniTinta(0, 'Zynamix', 'ZYNSPR', '');

      dicParams := TDicionario.Create;
      dicParams['idepro'] := 'ZYN';

      fDigDadosTintometricos(qryGen, stlDesEmb, stlProEmbLt, stlProEmbGl,
                                    strProEmbCo, strProEmbSp,
                                    strIteEmb, strTipEmb, strTipPre, intQtdEmb, fltPreEmb, fltEmbala,
                                    fltPreCus, fltPreVen, fltVolPro, strTabPre, dicParams);
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(dicParams) then FreeAndNil(dicParams);
    if Assigned(qryGen) then FreeAndNil(qryGen);
    if Assigned(stlDesEmb) then FreeAndNil(stlDesEmb);
    if Assigned(stlProEmbLt) then FreeAndNil(stlProEmbLt);
    if Assigned(stlProEmbGl) then FreeAndNil(stlProEmbGl);
  End;
end;

procedure TfrmConsultaCompTintaZynamix.pTarefaPrecos(Sender: TObject);
begin
  inherited;
  pTarefaFormulacao(Sender);
end;

procedure TfrmConsultaCompTintaZynamix.pTarefaVenda(Sender: TObject);
begin
  inherited;
  fCriarProcesso('AutTin\AutTin.exe exec ' + strLoginUsuarioLogado + ' 1 ' + VS_strCodEmp + ' TfrmCadZynNovasFormulas', False);
end;

{ TformulaZynamixDinamica }

function TformulaZynamixDinamica.GetPrecoEmbalagem: Double;
var
  qryAux: TUniQuery;
  conf: IConfTinta;
  cdsAux: TUniClientDataSet;
begin
  Result := 0;

  qryAux := nil;
  Try
    Try
      If (fArqIniTinta(0, 'GERAL', 'PRECO_GERACAO', '0') = '0') Then
      Begin
        conf := fGetConfTinta('ZYN');

        If (tpeTipEmb = teLitro) Then
          Result := conf.fGetDouble('EMBZYN') //fStrToFloat(fArqIniTinta(0, 'ZYNAMIX', '', 'EMBZYN'))

        Else If (tpeTipEmb = teGalao) Then
          Result := conf.fGetDouble('GALZYN') //fStrToFloat(fArqIniTinta(0, 'ZYNAMIX', '', 'GALZYN'))

        Else If (tpeTipEmb = teCopo) Then
          Result := conf.fGetDouble('EMBZYN') //fStrToFloat(fArqIniTinta(0, 'ZYNAMIX', '', 'EMBZYN'))

        Else If (tpeTipEmb = teSpray) Then
          Result := conf.fGetDouble('EMBZYN') //fStrToFloat(fArqIniTinta(0, 'ZYNAMIX', '', 'EMBZYN'))

      End
      Else
      Begin
        qryAux := fCriaQuery(Nil);
        qryAux.SQL.Clear;
        qryAux.SQL.Add('SELECT                     ');

        If (fArqIniTinta(0, 'GERAL', 'PRECO_GERACAO', '0') = '1') and FBlnCalculaUnitario Then
          qryAux.SQL.Add('  ITE_PREVE' + fArqIniTinta(0, 'GERAL', 'TABPRECO_GERACAO', '1') + ' AS ITE_PREVE1 ')
        Else //Opcao 2
          qryAux.SQL.Add('  ITE_PREVE' + FTabPre + ' AS ITE_PREVE1 '); //Tabela Definida no Faturamento

        qryAux.SQL.Add('FROM                       ');
        qryAux.SQL.Add('  ITEGER                   ');
        qryAux.SQL.Add('WHERE                      ');
        qryAux.SQL.Add('  ITE_CODITE = :CODITE AND ');
        qryAux.SQL.Add('  ITE_CODEMP = :CODEMP     ');

        qryAux.ParamByName('CODITE').AsString := strCodEmb;
        qryAux.ParamByName('CODEMP').AsString := VS_strCodEmp;
        cdsAux := TClientDataSetFactory.GetClientDataSet(qryAux);

        Result := cdsAux.FieldByName('ITE_PREVE1').AsFloat;
      End;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(qryAux) then FreeAndNil(qryAux);
  End;

end;

procedure TformulaZynamixDinamica.pCalcularPrecos;
var
  intIndex: Integer;
  objBase: TBaseAutomotiva;
  fltPreCusBas: Double;
  fltPreCu2Bas: Double;
  fltPreVenBas: Double;
  fltEmbala   : Double;

  fltDesBasCon: Double;
  fltDesCamCon: Double;

  fltCusBasCon: Double;
  fltCu2BasCon: Double;
  fltVenBasCon: Double;

  cdsCadBas: TUniClientDataSet;  
  procedure pZerarPrecos;
  begin
    fltDesBasCon := 0.0;
    fltDesCamCon := 0.0;
    FPrecoCu2Con := 0.0;
    FPrecoCu2Dil := 0.0;
    FPrecoCusCon := 0.0;
    FPrecoVenCon := 0.0;
                    
    FOutValCon := 0;
    FIcmsaiCon := 0;
    FImpFedCon := 0;
    FDesOpeCon := 0;
    FPreMedCon := 0;

    FOutValDil := 0;
    FIcmsaiDil := 0;
    FImpFedDil := 0;
    FDesOpeDil := 0;
    FPreMedDil := 0;        
  End;
begin
  inherited;
  pZerarPrecos;

  FVolumeOri := 1.0;

  If fltVolumePro <= 0.0 Then
    fltVolumePro := 1;

  cdsCadBas := TClientDataSetFactory.GetClientDataSet(qryCadBas);

  For intIndex := 0 To Count -1 Do
  Begin
    objBase := TBaseAutomotiva(Items[intIndex]);

    If (Not cdsCadBas.Locate('BAS_CODBAS', objBase.strCodBas, [])) Then
    Begin
      pZerarPrecos;
      Raise Exception.Create('Base ' + objBase.strCodBas + ' não cadastrada. Favor verificar.');
      Exit;
    End;

    If (fEmptyStr(cdsCadBas.FieldByName('BAS_CODITE').AsString)) Then
    Begin
      pZerarPrecos;
      Raise Exception.Create('A base ' + objBase.strCodBas + ' não está com o produto para venda associado.' + #13#10 +
                             'Favor verificar.');
      Exit;
    End;

    If (cdsCadBas.FieldByName('ITE_CNV_ML').AsFloat <= 0) Then
    Begin
      pZerarPrecos;
      Raise Exception.Create('O produto ' + cdsCadBas.FieldByName('BAS_CODITE').AsString + ' não está com o fator tintométrico ' + #13#10 +
                             'preenchido corretamente. Favor verificar.');
      Exit;
    End;

    If (cdsCadBas.FieldByName('BAS_PESPEC').AsFloat <= 0) Then
    Begin
      pZerarPrecos;
      Raise Exception.Create('A base ' + objBase.strCodBas + ' está com o peso específico zerado.' + #13#10 +
                             'Favor verificar.');
      Exit;
    End;

    if not IsItemAtivo(qryCadBas.FieldByName('BAS_CODITE').AsString) then
    begin
      pZerarPrecos;
      raise Exception.CreateFmt('O produto %s não está ativo, Favor verificar!', [qryCadBas.FieldByName('BAS_CODITE').AsString]);
    end;

    fltPreCu2Bas := fCalculaPrecoCusto2(cdsCadBas.FieldByName('ITE_PREVEN').AsFloat,
                                        cdsCadBas.FieldByName('ITE_PRECUS').AsFloat,
                                        objBase.fltOutVal,
                                        objBase.fltIcmSai,
                                        objBase.fltImpFed,
                                        objBase.fltDesOpe);

    fltPreCusBas := cdsCadBas.FieldByName('ITE_PRECUS').AsFloat;
    fltPreVenBas := cdsCadBas.FieldByName('ITE_PREVEN').AsFloat;
    fltEmbala    := cdsCadBas.FieldByName('BAS_EMBALA').AsFloat * objBase.fltPesEsp;

    fltCusBasCon := (objBase.fltQtdCon * fltPreCusBas / fltEmbala) * (FVolumePro / FVolumeOri);
    fltCu2BasCon := (objBase.fltQtdCon * fltPreCu2Bas / fltEmbala) * (FVolumePro / FVolumeOri);
    fltVenBasCon := (objBase.fltQtdCon * fltPreVenBas / fltEmbala) * (FVolumePro / FVolumeOri);
    
    FOutValCon := FOutValCon + (objBase.fltQtdCon * objBase.fltOutVal / fltEmbala) * (FVolumePro / FVolumeOri);
    FPreMedCon := FPreMedCon + (objBase.fltQtdCon * objBase.fltPreMed / fltEmbala) * (FVolumePro / FVolumeOri);
    FIcmsaiCon := FIcmsaiCon + fltVenBasCon * objBase.fltIcmSai / 100;
    FImpFedCon := FImpFedCon + fltVenBasCon * objBase.fltImpFed / 100;
    FDesOpeCon := FDesOpeCon + fltVenBasCon * objBase.fltDesOpe / 100;

    FPrecoCusCon := FPrecoCusCon + fltCusBasCon;
    FPrecoCu2Con := FPrecoCu2Con + fltCu2BasCon;
    FPrecoVenCon := FPrecoVenCon + fltVenBasCon;
  End;

end;

procedure TformulaZynamixDinamica.pCarregaPrecosBases;
var
  intContador: Integer;
  objBase: TBaseAutomotiva;
  cdsGen: TUniClientDataSet;
begin

  cdsGen := TClientDataSetFactory.GetClientDataSet(qryCadBas);

  For intContador := 0 To Self.Count-1 Do
  Begin
    objBase := TBaseAutomotiva(Self.Items[intContador]);
    cdsGen.Locate('BAS_CODBAS', objBase.strCodBas, []);

    objBase.fltEmbala := cdsGen.FieldByName('BAS_EMBALA').AsFloat;
    objBase.fltPesEsp := cdsGen.FieldByName('BAS_PESPEC').AsFloat;
    objBase.fltPreVen := cdsGen.FieldByName('ITE_PREVEN').AsFloat;
    objBase.strImpDir := cdsGen.FieldByName('ITE_IMPDIR').AsString;
    objBase.strCodIte := cdsGen.FieldByName('BAS_CODITE').AsString;
    objBase.fltPreMed := cdsGen.FieldByName('ITE_PREMED').AsFloat;

    objBase.fltOutVal := cdsGen.FieldByName('ITE_OUTVAL').AsFloat;

    if fCfgSis('IMPCF4', varBoolean) and Assigned(calculadorFatVendas) then
      objBase.fltIcmSai := calculadorFatVendas.fCalculaAliquota(objBase.strCodIte, objBase.strImpDir)
    else
      objBase.fltIcmSai := cdsGen.FieldByName('ITE_ICMSAI').AsFloat;
      
    objBase.fltImpFed := cdsGen.FieldByName('ITE_IMPFED').AsFloat;
    objBase.fltDesOpe := cdsGen.FieldByName('ITE_DESOPE').AsFloat;

  End;

  FCalculo.Clear;
  FCalculo.Add('VolumeFormula  = ' + FloatToStrF(1000, ffFixed, 12, 4));
  FCalculo.Add('Valor da Base  = (Quantidade * Preço) / (Embalagem * Peso Específico)');
  FCalculo.Add('Preço da Tinta = Soma(Valores de Base) * Volume Produzido / VolumeFormula');
end;

procedure TformulaZynamixDinamica.pCarregarColorantes;
begin
  inherited;
  qryCadBas.SQL.Clear;
  qryCadBas.SQL.Add(' SELECT                               ');
  qryCadBas.SQL.Add('   BAS_CODBAS                         ');
  qryCadBas.SQL.Add('   , BAS_CODITE                       ');
  qryCadBas.SQL.Add('   , BAS_EMBALA                       ');
  qryCadBas.SQL.Add('   , BAS_PESPEC                       ');
  qryCadBas.SQL.Add('   , ITE_CNV_ML                       ');
  qryCadBas.SQL.Add('   , ITE_PREMED                       ');
  qryCadBas.SQL.Add('   , ITE_PREULT                       ');
  qryCadBas.SQL.Add('   , ITE_IMPULT                       ');  

  If (fArqIniTinta(0, 'GERAL', 'PRECO_GERACAO', '0') <>  '0') Then
  begin
    qryCadBas.SQL.Add('   , ITE_ICMSAI                       ');
    qryCadBas.SQL.Add('   , ITE_IMPFED                       ');
    qryCadBas.SQL.Add('   , ITE_DESOPE                       ');
    qryCadBas.SQL.Add('   , ITE_OUTVAL                       ');
  end
  else
  begin
    qryCadBas.SQL.Add('   , 0 AS ITE_ICMSAI                  ');
    qryCadBas.SQL.Add('   , 0 AS ITE_IMPFED                  ');
    qryCadBas.SQL.Add('   , 0 AS ITE_DESOPE                  ');
    qryCadBas.SQL.Add('   , 0 AS ITE_OUTVAL                  ');
  end;

  If (fArqIniTinta(0, 'GERAL', 'PRECO_GERACAO', '0') = '0') Then
  begin
    qryCadBas.SQL.Add('   , BAS_PRECUS AS ITE_PRECUS         ');
    qryCadBas.SQL.Add('   , BAS_PREVEN AS ITE_PREVEN         ');
  end
  else if (fArqIniTinta(0, 'GERAL', 'PRECO_GERACAO', '0') = '1') and FBlnCalculaUnitario then
  begin
    qryCadBas.SQL.Add('   , G.ITE_PRECUS                     ');
    qryCadBas.SQL.Add('   , G.ITE_PREVE' + fArqIniTinta(0, 'GERAL', 'TABPRECO_GERACAO', '1') + ' AS ITE_PREVEN       ');
  end
  else
  begin
    qryCadBas.SQL.Add('   , G.ITE_PRECUS                     ');
    qryCadBas.SQL.Add('   , G.ITE_PREVE' + strTabPre + ' AS ITE_PREVEN       ');
  end;

  If fCfgSis('IMPDIG') = '1' Then
    qryCadBas.SQL.Add('   , I.ITE_IMPDIR                     ')
  else
    qryCadBas.SQL.Add('   , G.ITE_IMPDIR                     ');

  qryCadBas.SQL.Add(' FROM                                 ');
  qryCadBas.SQL.Add('   ZYN_CADBAS                         ');
  qryCadBas.SQL.Add('   INNER JOIN ITEGER G                ');
  qryCadBas.SQL.Add('     ON BAS_CODITE = G.ITE_CODITE     ');
  qryCadBas.SQL.Add('   INNER JOIN CADITE I                ');
  qryCadBas.SQL.Add('     ON G.ITE_CODITE = I.ITE_CODITE   ');
  qryCadBas.SQL.Add(' WHERE G.ITE_CODEMP = :CODEMP         ');

  qryCadBas.ParamByName('CODEMP').AsString := VS_strCodEmp;
  TClientDataSetFactory.GetClientDataSet(qryCadBas);
end;

function fConsultaZynamixDinamica(Sender: TForm): String;
  Var
    qryGen: TUniQuery;
begin
  qryGen := fCriaQuery(Sender);
  Result := fConsultaZynamixDinamicaInterna(Sender, qryGen, tpcGeral, IIF(fEmptyStr(fCfgSis('TABPAD')), '1', fCfgSis('TABPAD')));
  FreeAndNil(qryGen);
end;

function fConsultaZynamixGeralDinamica(Sender: TForm): String;
  Var
    qryGen: TUniQuery;
begin
  qryGen := fCriaQuery(Sender);
  Result := fConsultaZynamixDinamicaInterna(Sender, qryGen, tpcGeral, IIF(fEmptyStr(fCfgSis('TABPAD')), '1', fCfgSis('TABPAD')));
  FreeAndNil(qryGen);
end;

function fConsultaZynamixVendaDinamica(Sender: TForm; Var qryCadZyn: TUniQuery; strTabPre: String): String;
begin
  Result := fConsultaZynamixDinamicaInterna(Sender, qryCadZyn, tpcVenda, strTabPre);
end;

function fConsultaZynamixDinamicaInterna(Sender: TForm;
  Var qryCadZyn: TUniQuery; tipoConsulta: TTipoConsulta; strTabPre: String): String;
{
  Var
    strSQL      : String;
    stlIndices  : TStringList;
    stlDesInd   : TStringList;
    frmConsulta : TfrmConsultaCompTintaZynamix;
}
begin

  {************************************}
  {* PESQUISA ESPECIFICA PARA A TINTA *}
  {*********************************PH*}
{
  Result := '-1';
}
  {********************************}
  {* SELECT CONSULTA              *}
  {*****************************PH*}
{
  strSQL := '';
  strSQL := strSQL + 'SELECT   ';
  strSQL := strSQL + '  ZYN_DESCOR AS "Descrição Cor", ';
  strSQL := strSQL + '  ZYN_LINHA_ AS "Linha", ';
  strSQL := strSQL + '  ZYN_VEICUL AS "Veículo", ';
  strSQL := strSQL + '  ZYN_A_N_O_ AS "Ano", ';
  strSQL := strSQL + '  ZYN_TIPO__ AS "Tipo", ';
  strSQL := strSQL + '  ZYN_CODCOR AS "Cód. Cor", ';
  strSQL := strSQL + '	AUTOINCREM ';
  strSQL := strSQL + 'FROM   ';
  strSQL := strSQL + '	ZYN_CADZYN ';
  strSQL := strSQL + 'WHERE   ';
  strSQL := strSQL + '  TRUE ';
}
  {*********************************************}
  {* INDICES DA PESQUISA  (CAMPOS PARA INDECES)*}
  {******************************************PH*}
{
  stlIndices := TStringList.Create;

  stlIndices.Add('ZYN_DESCOR');
  stlIndices.Add('ZYN_DESCOR+ZYN_TIPO__');
  stlIndices.Add('ZYN_LINHA_+ZYN_CODCOR');
  stlIndices.Add('ZYN_LINHA_+ZYN_DESCOR');
  stlIndices.Add('ZYN_CODCOR');
  stlIndices.Add('ZYN_VEICUL+ZYN_A_N_O_+ZYN_TIPO__');
}
  {**********************************************}
  {* INDICES PARA PESQUISA (CAMPO PARA INDICES) *}
  {*******************************************PH*}
{
  stlDesInd := TStringList.Create;
  stlDesInd.Add('Descrição Cor');
  stlDesInd.Add('Descrição Cor/Tipo');
  stlDesInd.Add('Linha/Cód. Cor');
  stlDesInd.Add('Linha/Descrição Cor');
  stlDesInd.Add('Cód. Cor');
  stlDesInd.Add('Veículo/Ano/Tipo');
}
  {**********************************}
  {* CRIA COMPONENTES PARA PESQUISA *}
  {*******************************PH*}
{
  frmConsulta := TfrmConsultaCompTintaZynamix.Create(Sender, tipoConsulta, strTabPre);
  frmConsulta.Caption := 'Consulta Zynamix';

  If pConsultaEspecifica(Sender, frmConsulta, qryCadZyn,
    'ZYN_CADZYN', strSQL, stlIndices, stlDesInd, '', False, True, -1, True) Then
  Begin
}
    {**************************************************}
    {* CASO NÃO ESTEJA VAZIA RETORNE O AUTOINCREMENTO *}
    {***********************************************PH*}
{
    If (Not qryCadZyn.IsEmpty) Then
      Result := qryCadZyn.FieldByName('AUTOINCREM').AsString;
  End;
}
  {********************************}
  {* LIBERA COMPONENTES CRIADOS   *}
  {*****************************PH*}
{
  FreeAndNil(stlDesInd);
  FreeAndNil(stlIndices);
  FreeAndNil(frmConsulta);
}
  Result := (TZynamixConsulta.Create).fExecutarConsulta(Sender,
    qryCadZyn, tipoConsulta, strTabPre, TfrmConsultaCompTintaZynamix);

end;

function fGTinForZynamixDinamica(strIteTin: String; strTipPre: String;
          Var arrFormul: TForMulTinDetArray; Var arrBaixaPigmentos: TBaixaPigmentosArray;
          Var stlItensTraMl: TStringList; fltVolPro: Double): Boolean;
Var
  strSQL      : String;
  qryConsulta : TUniQuery;
  intCont     : Integer;
  strCamFor   : String;
  strCamQtd   : String;
  dicBases    : TDicionario;
  strBases    : String;
  cdsConsulta: TUniClientDataSet;
begin
  Result := False;

  qryConsulta := nil;
  dicBases := nil;
  Try
    Try
      {********************************}
      {* SELECIONE A TINTA NO CADZyn  *}
      {*****************************PH*}
      strSQL := '';
      strSQL := strSQL + 'SELECT ';
      strSQL := strSQL + '  * ';
      strSQL := strSQL + 'FROM ';
      strSQL := strSQL + '  ZYN_CADZYN ';
      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + '  CONCAT(ZYN_LINHA_, ZYN_CODCOR, ZYN_TIPO__) = :ITETIN ';

      qryConsulta := fCriaQuery;
      qryConsulta.SQL.Text := strSQL;
      qryConsulta.ParamByName('ITETIN').AsString := strIteTin;
      cdsConsulta := TClientDataSetFactory.GetClientDataSet(qryConsulta);

      {**************************************}
      {* SE NAO ACHAR A TINTA RETORNE FALSO *}
      {***********************************PH*}
      If cdsConsulta.IsEmpty Then
      Begin
        Result := False;
        Exit;
      End;

      {*********************************************************}
      {* CRIA UM DICIONARIO PARA ARMAZENAR AS BASES DA FORMULA *}
      {******************************************************PH*}
      dicBases := TDicionario.Create;

      {********************************************}
      {* ATRIBUI A FORMULACAO NO ARRAY(arrFormul) *}
      {*****************************************PH*}
      For intCont := 1 To 15 Do
      Begin
        strCamFor := 'ZYN_CODB' + fStrZero(intCont, 2);
        strCamQtd := 'ZYN_QTDC' + fStrZero(intCont, 2);

        If fEmptyStr(cdsConsulta.FieldByName(strCamFor).AsString) Then
          Break;

        arrFormul[intCont].strFormul := cdsConsulta.FieldByName(strCamFor).AsString;
        arrFormul[intCont].fltQtdbas := cdsConsulta.FieldByName(strCamQtd).AsFloat * fltVolPro;
        dicBases[arrFormul[intCont].strFormul] := arrFormul[intCont].fltQtdbas;

        {***************************************************************}
        {* ARMAZENA AS BASES EM UMA STRING PARA FAZER A BUSCA NAS BASES*}
        {************************************************************PH*}
        strBases := strBases + QuotedStr(arrFormul[intCont].strFormul) + ', ';
      End;

      strBases := Trim(strBases);
      strBases := Copy(strBases, 1, Length(strBases) - 1);

      {****************************************}
      {* SELECIONA SOMENTE AS BAES DA FORMULA *}
      {*************************************PH*}
      strSQL := '';
      strSQL := strSQL + 'SELECT ';
      strSQL := strSQL + '  BAS_CODBAS, ';
      strSQL := strSQL + '  BAS_CODITE ';
      strSQL := strSQL + 'FROM ';
      strSQL := strSQL + '  ZYN_CADBAS ';
      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + GetInToOr('BAS_CODBAS', strBases);

      qryConsulta.Close;
      qryConsulta.SQL.Text := strSQL;
      cdsConsulta := TClientDataSetFactory.GetClientDataSet(qryConsulta);

      {********************************************************************}
      {* FIXA O TAMANHO DO ARRAY DE BAIXA PARA O TANTO DE BASES DA FORMULA*}
      {*****************************************************************PH*}
      SetLength(arrBaixaPigmentos, cdsConsulta.RecordCount);

      {**************************************************}
      {* CARREGA OS ITENS PARA FAZER A BAIXA DE ESTOQUE *}
      {***********************************************PH*}
      While (Not cdsConsulta.Eof) Do
      Begin
        stlItensTraMl.Add(cdsConsulta.FieldByName('BAS_CODITE').AsString);
        arrBaixaPigmentos[cdsConsulta.RecNo - 1].strCodIte := cdsConsulta.FieldByName('BAS_CODITE').AsString;
        arrBaixaPigmentos[cdsConsulta.RecNo - 1].fltQtdBaixa := dicBases[cdsConsulta.FieldByName('BAS_CODBAS').AsString];
        cdsConsulta.Next;
      End;

      Result := True;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(qryConsulta) then FreeAndNil(qryConsulta);
    if Assigned(dicBases) then FreeAndNil(dicBases);
  End;
end;

function fDigDadosTintometricos(qryCadZyn: TUniQuery; stlDesEmb, stlProEmbLt,
  stlProEmbGl: TStringList; strProEmbCo,
  strProEmbSp: String; Var strIteEmb,
  strTipEmb, strTipPre: String; Var intQtdEmb: Integer; Var fltPreEmb, fltEmbala,
  fltPreCus, fltPreVen, fltVolPro: Double; strTabPre: String; dicRetorno: TDicionario): Boolean;
var
  objBase     : TBaseAutomotiva;
  objFormula  : TformulaZynamixDinamica;
  intCont     : Integer;
  fltPreCu2: Double;
  calculadorFatVendas: ICalculadorFatVendas;
  cdsCadBas: TUniClientDataSet;  
begin
  Result := False;
  objFormula := nil;
  frmDigTintaAutomotiva := nil;
  Try
    Try
      if not Supports(dicRetorno.RetornaObjeto('calculadorFatVendas'), ICalculadorFatVendas, calculadorFatVendas) then
        calculadorFatVendas := nil;
            
      objFormula := TformulaZynamixDinamica.Create(strTabPre);
      objFormula.calculadorFatVendas := calculadorFatVendas;
      objFormula.strDescri := qryCadZyn.FieldbyName('ZYN_DESCOR').AsString;
      objFormula.strOpcDoc := IfNull(dicRetorno['opcdoc'], '');
      cdsCadBas := TClientDataSetFactory.GetClientDataSet(objFormula.qrycadBas);

      For intCont := 1 To 15 Do
      Begin
        If fEmptyStr(qryCadZyn.FieldbyName('ZYN_CODB' + fStrZero(intCont, 2)).AsString) Then
          Break;

        objBase := TBaseAutomotiva(objFormula.Add);
        objBase.strCodBas := qryCadZyn.FieldByName('ZYN_CODB' + fStrZero(intCont, 2)).AsString;
        objBase.fltQtdCon := qryCadZyn.FieldByName('ZYN_QTDC' + fStrZero(intCont, 2)).AsFloat;

        cdsCadBas.Locate('BAS_CODBAS', objBase.strCodBas, []);
        objBase.fltEmbala := cdsCadBas.FieldbyName('BAS_EMBALA').AsFloat;
        objBase.fltPesEsp := cdsCadBas.FieldByName('BAS_PESPEC').AsFloat;
        objBase.strTipBas := 'B';
      End;

      objFormula.pCarregaPrecosBases;

      {*********************************************************************************}
      {* CARREGA AS INFORMACOES PARA VENDA NO FRMDIGTINTAAUTOMOTIVA PARA FAZER A VENDA *}
      {******************************************************************************PH*}

      Application.CreateForm(TfrmDigTintaAutomotiva, frmDigTintaAutomotiva);
      objFormula.strCodEmpEst := IfNull(dicRetorno['codemp'], VS_strCodEmp);
      frmDigTintaAutomotiva.objFormula := objFormula;
      frmDigTintaAutomotiva.stlDesEmb := stlDesEmb;
      frmDigTintaAutomotiva.stlProEmbLt := stlProEmbLt;
      frmDigTintaAutomotiva.stlProEmbGl := stlProEmbGl;
      frmDigTintaAutomotiva.strProEmbCo := strProEmbCo;
      frmDigTintaAutomotiva.strProEmbSp := strProEmbSp;
      frmDigTintaAutomotiva.Caption := frmDigTintaAutomotiva.Caption + 'Zynamix';
      frmDigTintaAutomotiva.fltVolumePadraoLitro := 1.000;
      {*************************************}
      {* NAO POSSUI CATALISADOR ESSA TINTA *}
      {**********************************PH*}
      frmDigTintaAutomotiva.chkComCat.Visible := False;
      frmDigTintaAutomotiva.strIdePro   := dicRetorno['idepro'];
      Result := (frmDigTintaAutomotiva.ShowModal = mrOk);

      If Result Then
      Begin
        strIteEmb := frmDigTintaAutomotiva.objFormula.strCodEmb;
        strTipEmb := IIF(frmDigTintaAutomotiva.objFormula.tpeTipEmb = teLitro, 'LT', 'GL');
        strTipPre := 'C';
        intQtdEmb := StrToIntDef(frmDigTintaAutomotiva.edtQtdEmb.Text, 0);
        fltPreEmb := frmDigTintaAutomotiva.objFormula.fltPrecoEmbalagem;
        fltEmbala := IIF(frmDigTintaAutomotiva.objFormula.tpeTipEmb = teLitro, 1.000, 3.600);
        fltVolPro := frmDigTintaAutomotiva.objFormula.fltVolumePro;
        fltPreCus := frmDigTintaAutomotiva.objFormula.fltPrecoCusCon + frmDigTintaAutomotiva.objFormula.fltPrecoCustoEmbalagem;
        fltPreCu2 := frmDigTintaAutomotiva.objFormula.fltPrecoCu2Con + frmDigTintaAutomotiva.objFormula.fltPrecoCusto2Embalagem;
        fltPreVen := frmDigTintaAutomotiva.objFormula.fltPrecoVenCon + frmDigTintaAutomotiva.objFormula.fltPrecoEmbalagem;


        dicRetorno['premed'] := IfThen(frmDigTintaAutomotiva.rdgModoVenda.ItemIndex = 0,
          frmDigTintaAutomotiva.objFormula.fltPreMedCon,
          frmDigTintaAutomotiva.objFormula.fltPreMedDil) +
          frmDigTintaAutomotiva.objFormula.fltPrecoMedioEmbalagem;



        dicRetorno['precus'] := fltPreCus;
        dicRetorno['precu2'] := fltPreCu2;
        dicRetorno['tippre'] := strTipPre;
        objFormula.pCalculaImpostosSaida(dicRetorno);

        dicRetorno['saldocols'] := frmDigTintaAutomotiva.blnSaldoSuficiente;
        dicRetorno.AdicionarObjeto('formul', frmDigTintaAutomotiva.matrizSaldosColorantes);
      End;
      
      If (Result) And (Assigned(dicRetorno)) Then
      Begin
        objFormula.pRecalculaTabelas(strTipPre, dicRetorno);
      End;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(frmDigTintaAutomotiva) then FreeAndNil(frmDigTintaAutomotiva);
    if Assigned(objFormula) then FreeAndNil(objFormula);
  End;
end;

function fRetornaPrecoZynamixDinamica(Sender: TForm; qryTinta: TUniQuery; Var dicRetorno: TDicionario): Boolean;
  Var
    strCodEmp     : String;
    strOpcDoc     : String;
    blnUsaPreCus  : Boolean;
    strTipEmb     : String;
    intQtdEmb     : Integer;
    strIteEmb     : String;
    strTipPre     : String;
    fltPreEmb     : Double;
    fltEmbala     : Double;
    fltPreCus     : Double;
    fltPreVen     : Double;
    strIteTin     : String;
    strMontad     : String;
    strA_n_o_     : String;
    fltPrcTin     : Double;
    fltPrvTin     : Double;

    stlDesEmb     : TStringList;
    stlProEmbLt   : TStringList;
    stlProEmbGl   : TStringList;
    strProEmbCo   : String;
    strProEmbSp   : String;

    fltVolPro     : Double;
    strTabPre     : String;
    strAuto: String;
    tinta : IConsultaTinta;
    conf: IConfTinta;
    strDesCor     : String;
begin
  Result := False;
  conf         := fGetConfTinta('ZYN');
  strCodEmp    := dicRetorno['codemp'];
  strOpcDoc    := dicRetorno['opcdoc'];
  blnUsaPreCus := dicRetorno['usaprecus'];
  strTipEmb    := dicRetorno['tipemb'];
  intQtdEmb    := dicRetorno['qtdemb'];
  strTabPre    := dicRetorno['tabpre'];

  stlDesEmb := TStringList.Create;
  stlDesEmb.Add('EMBALAGEM');

  {
  If fConsultaZynamixVendaDinamica(Sender, qryTinta, strTabPre) = '-1' Then
    Exit;
  }

  strAuto := fConsultaZynamixVendaDinamica(Sender, qryTinta, strTabPre);

  If (strAuto = '-1') Then
  Begin
    Exit;
  End;

  tinta := TZynamixConsulta.Create;

  qryTinta.Close;
  qryTinta.SQL.Text := tinta.fGetSelectAutoIncrem(strAuto);
  qryTinta.Open;

  strIteTin := qryTinta.FieldByName('ZYN_LINHA_').AsString +
               qryTinta.FieldByName('ZYN_CODCOR').AsString +
               qryTinta.FieldByName('ZYN_TIPO__').AsString;

  strMontad := '';
  strA_n_o_ := qryTinta.FieldByName('ZYN_A_N_O_').AsString;

  stlProEmbGl :=  TStringList.Create;
  stlProEmbLt :=  TStringList.Create;

  stlProEmbGl.Add(conf.fGet('ZYNGDU')); //stlProEmbGl.Add(fArqIniTinta(0, 'ZYNAMIX', 'ZYNGDU', ''));
  stlProEmbLt.Add(conf.fGet('ZYNLDU')); //stlProEmbLt.Add(fArqIniTinta(0, 'ZYNAMIX', 'ZYNLDU', ''));

  strProEmbCo := conf.fGet('ZYNCOP'); //fArqIniTinta(0, 'ZYNAMIX', 'ZYNCOP', '');
  strProEmbSp := conf.fGet('ZYNSPR'); //fArqIniTinta(0, 'ZYNAMIX', 'ZYNSPR', '');

  If Not fDigDadosTintometricos(qryTinta, stlDesEmb, stlProEmbLt, stlProEmbGl, 
                                strProEmbCo, strProEmbSp,
                                strIteEmb, strTipEmb, strTipPre, intQtdEmb, fltPreEmb, fltEmbala,
                                fltPreCus, fltPreVen, fltVolPro, strTabPre, dicRetorno) Then
    Exit;

  strDesCor := Trim(tinta.fGetDescricao(qryTinta.FieldbyName('AUTOINCREM').AsString));
  dicRetorno['unidad'] := fRetUnidadeItem(strIteEmb);

  fltPrcTin := fltPreCus;
  If blnUsaPreCus Then
    fltPreVen := fltPreCus;

  fltPrvTin := fltPreVen;

  dicRetorno['precus'] := fltPreCus;
  dicRetorno['unitar'] := fltPreVen;
  dicRetorno['prctin'] := fltPrcTin;
  dicRetorno['prvtin'] := fltPrvTin;
  dicRetorno['codite'] := conf.fGet('PROZYN'); //fArqIniTinta(0, 'ZYNAMIX', 'PROZYN', '');
  dicRetorno['itetin'] := strIteTin;

  dicRetorno['iteemb'] := strIteEmb;
  dicRetorno['tipemb'] := strTipEmb;
  dicRetorno['qtdemb'] := intQtdEmb;
  dicRetorno['preemb'] := fltPreEmb;
  dicRetorno['embala'] := fltEmbala;
  dicRetorno['volpro'] := fltVolPro;

  dicRetorno['montad'] := strMontad;
  dicRetorno['a_n_o_'] := strA_n_o_;
  dicRetorno['chafor'] := fRetornaDescricaoZynamixDinamica(qryTinta, strDesCor) + strTipEmb;
  dicRetorno['descor'] := strDesCor; 

  FreeAndNil(stlDesEmb);
  FreeAndNil(stlProEmbLt);
  FreeAndNil(stlProEmbGl);

  Result := True;
end;

function fRetornaDescricaoZynamixDinamica(qryCadZyn: TUniQuery; strDesCor: String): String;
begin
  Result := strDesCor;            
end;

procedure pRetornaDadosZynamixDinamica(strIteTin: String; dicRetorno: TDicionario);
  Var
    qryCadZyn : TUniQuery;
begin
  qryCadZyn := fCriaQuery;
  qryCadZyn.SQL.Text := 'SELECT * FROM ZYN_CADZYN WHERE CONCAT(ZYN_LINHA_, ZYN_CODCOR, ZYN_TIPO__) = :ITETIN';
  qryCadZyn.ParamByName('ITETIN').AsString := strIteTin;
  qryCadZyn.Open;

  dicRetorno['codtin'] := qryCadZyn.FieldByName('ZYN_LINHA_').AsString +
                          qryCadZyn.FieldByName('ZYN_CODCOR').AsString +
                          qryCadZyn.FieldByName('ZYN_TIPO__').AsString;

  dicRetorno['montad'] := '';
  dicRetorno['martin'] := qryCadZyn.FieldByName('ZYN_TIPO__').AsString;

  FreeAndNil(qryCadZyn);
end;

function fRetornaUniTraProZynamixDinamica(strTipPre : String; fltPrcTin, fltPrvTin: Double): Double;
Var
  conf: IConfTinta;
begin
  conf     := fGetConfTinta('ZYN');
  //If fArqIniTinta(0, 'ZYNAMIX', 'TRAZYN', '0') = 'VEN' Then
  If conf.fGet('TRAZYN') = 'VEN' Then
    Result :=  fltPrvTin * conf.fGetDouble('FATZYN')  //fStrToFloat(fArqIniTinta(0, 'ZYNAMIX', 'FATZYN', ''))
  Else
    Result :=  fltPrcTin * conf.fGetDouble('FATZYN'); //fStrToFloat(fArqIniTinta(0, 'ZYNAMIX', 'FATZYN', ''));

  Result := fFormataFloat(Result, 2);
end;

procedure pRetornaTabelaPrecoZynamix(dicRetorno: TDicionario; fltFatorAcerto: Double);
var
  strTabelas: String;
  objFormula: TformulaZynamixDinamica;
  objBase: TBaseAutomotiva;
  intContador: Integer;
  calculadorFatVendas: ICalculadorFatVendas;
  
  function GetDescri(const strDescri: string): string;
  begin
    Result := strDescri;
    if Length(strDescri) > 20 then
      Result := LeftStr(strDescri, 20) + '...';
  end;
begin
  objFormula := nil;
  Try
    Try
      if not Supports(dicRetorno.RetornaObjeto('calculadorFatVendas'), ICalculadorFatVendas, calculadorFatVendas) then
        calculadorFatVendas := nil;
            
      objFormula := TformulaZynamixDinamica.Create('1');
      objFormula.blnCalculaUnitario := False;
      objFormula.calculadorFatVendas := calculadorFatVendas;
      objFormula.fltVolumeOri := 1000;
      objFormula.fltVolumePro := dicRetorno['volpro'];
      objFormula.mveModoVenda := mvConcentrado;
      objFormula.fltFatorAcerto := fltFatorAcerto;

      objFormula.strCodEmb := dicRetorno['iteemb'];
      
      For intContador := 1 To 15 Do
      Begin

        If (fEmptyStr(IfNull(dicRetorno['base' + fStrZero(intContador, 2)], ''))) Then
          Break;

        objBase := TBaseAutomotiva(objFormula.Add);
        objBase.strCodBas := dicRetorno['base' + fStrZero(intContador, 2)];
        objBase.fltQtdCon := fFormataFloat(dicRetorno['qtdb' + fStrZero(intContador, 2)], 3) * (objFormula.fltVolumeOri / 1000) / objFormula.fltVolumePro;
        objBase.fltQtdDil := 0.0;
        objBase.strTipBas := 'B';
      End;

      strTabelas := fCfgSis('TABPRC');
      If Length(strTabelas) < 7 Then
        strTabelas := strTabelas + StringOfChar('N', 7 - Length(strTabelas));

      For intContador := 1 To Length(strTabelas) Do
      Begin
        if strTabelas[intContador] = 'S' then
        begin
          objFormula.strTabPre := IntToStr(intContador);

          TfrmGravando.fExecutarModal(objFormula.pCarregarColorantes, Format('Carregando Bases... [%s] - Tabela %d',
            [GetDescri(IfNull(dicRetorno['descri'], '')), intContador]), 'objFormula.pCarregarColorantes');

          TfrmGravando.fExecutarModal(objFormula.pCarregaPrecosBases, Format('Carregando Preços... [%s] - Tabela %d',
            [GetDescri(IfNull(dicRetorno['descri'], '')), intContador]), 'objFormula.pCarregaPrecosBases');

          TfrmGravando.fExecutarModal(objFormula.pCalcularPrecos, Format('Calculando Preços... [%s] - Tabela %d',
            [GetDescri(IfNull(dicRetorno['descri'], '')), intContador]), 'objFormula.pCalcularPrecos');

          If IfNull(dicRetorno['precus'], 0) <= 0 Then
            dicRetorno['precus'] := objFormula.fltPrecoCusCon + objFormula.fltPrecoCustoEmbalagem;

          dicRetorno['precu2'] := objFormula.fltPrecoCu2Con + objFormula.fltPrecoCusto2Embalagem;
          dicRetorno['preve' + IntToStr(intContador)] := objFormula.fltPrecoVenCon + objFormula.fltPrecoEmbalagem;
          if intContador = IfNull(dicRetorno['tabpre'], 0) then
            objFormula.pCalculaImpostosSaida(dicRetorno);

          dicRetorno['premed'] := objFormula.fltPreMedCon + objFormula.fltPrecoMedioEmbalagem;
        end;
      End;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(objFormula) then FreeAndNil(objFormula);
  End;
end;

end.
