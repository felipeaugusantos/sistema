unit untGeneral;

interface

uses
  untFuncEspecificas, Forms, Uni, untFuncoesSimples, Classes,
  SysUtils, Controls, Dialogs, untPnlBotoesAcoesNovaConsulta,
  Math;

type
  TfrmConsultaCompGeneral = class(TfrmPnlBotoesAcoesNovaConsulta)
  public
    procedure pTarefaFormulacao(Sender: TObject); override;
    procedure pTarefaPrecos(Sender: TObject); override;
    procedure pTarefaVenda(Sender: TObject); override;
  end;

  TGeneral = class(TFormulaAutomotiva)
  protected
  public
    procedure pCalcularPrecos; override;
    procedure pCarregaPrecosBases; override;
    procedure pCarregarColorantes; override;
  End;

  function fConsultaGeneralAutomotivaDinamica(Sender: TForm): String; stdcall;
  function fConsultaGeneralAutomotivaDinamicaGeral(Sender: TForm): String; stdcall;
  function fConsultaGeneralAutomotivaDinamicaVenda(Sender: TForm; qryTinta: TUniQuery;
    strTabPre: String): String; stdcall;

  function fConsultaGeneralAutomotivaDinamicaInterna(Sender: TForm; qryTinta: TUniQuery;
    tipoConsulta: TTipoConsulta; strTabPre: String): String;

  function fGTinForGeneralAutomotivaDinamica(strIteTin: String; strTipPre: String;
            Var arrFormul: TForMulTinDetArray; Var arrBaixaPigmentos: TBaixaPigmentosArray;
            Var stlItensTraMl: TStringList; fltVolPro: Double): Boolean; stdcall;

  function fDigDadosTintometricos(qryCadGen: TUniQuery; stlDesEmb, stlProEmbLt,
    stlProEmbGl: TStringList; strProEmbCo,
    strProEmbSp: String; Var strIteEmb,
    strTipEmb, strTipPre: String; Var intQtdEmb: Integer; Var fltPreEmb, fltEmbala,
    fltPreCus, fltPreVen, fltVolPro: Double; strTabPre: String; dicRetorno: TDicionario): Boolean;

  function fRetornaPrecoGeneralAutomotivaDinamica(Sender: TForm; qryTinta: TUniQuery; Var dicRetorno: TDicionario): Boolean;
  function fRetornaDescricaoGeneralAutomotivaDinamica(qryCadGen: TUniQuery; strDesCor: String): String;

  procedure pRetornaDadosGeneralAutomotivaDinamica(strIteTin: String; dicRetorno: TDicionario);

  procedure pRetornaTabelaPrecoGeneralAutomotiva(dicRetorno: TDicionario; fltFatorAcerto: Double);
  function fRetDescriMontadora(strCodMon: String): String;

  function fRetornaUniTraProGeneralAutomotivaDinamica(fltPrcTin, fltPrvTin: Double): Double;


  
implementation

uses DB, untDigTintaAutomotiva, untFuncoes, untICalculadorFatVendas,untIConfTinta,untIConsultaTinta,untTintaMaquina,untGeneralConsulta;

procedure TGeneral.pCalcularPrecos;
var
  intCont: Integer;
  objBase: TBaseAutomotiva;

  fltPreCusBas: Double;
  fltPreCu2Bas: Double;
  fltPreVenBas: Double;
  fltEmbala: Double;

  fltPreCusCon: double;
  fltPreCu2Con: double;
  fltPreVenCon: Double;

  fltPreVenDil: Double;
  fltPreCusDil: Double;
  fltPreCu2Dil: Double;

  fltValIpiCon: Double;
  fltValIcmsCon: Double;
  fltValIpiDil: Double;
  fltValIcmsDil: Double;

  fltQtdMlCon: Double;
  fltQtdMlDil: Double;

  procedure ZerarPrecos;
  Begin
    fltPreCusBas := 0.0;
    fltPreCu2Bas := 0.0;
    fltPreVenBas := 0.0;
    fltEmbala := 0.0;
    fltPreCusCon := 0.0;
    fltPreCu2Con := 0.0;
    fltPreVenCon := 0.0;
    fltPreCusCon := 0.0;
    fltPreCu2Con := 0.0;
    fltPreVenCon := 0.0;
    FPrecoCusCon := 0.0;
    FPrecoCu2Con := 0.0;
    FPrecoVenCon := 0.0;
    FPrecoCusDil := 0.0;
    FPrecoCu2Dil := 0.0;
    FPrecoVenDil := 0.0;
    fltPreVenDil := 0.0;
    fltPreCusDil := 0.0;
    fltPreCu2Dil := 0.0;

    fltValIpiCon := 0.0;
    fltValIcmsCon := 0.0;
    fltValIpiDil := 0.0;
    fltValIcmsDil := 0.0;

    fltQtdMlCon := 0.0;
    fltQtdMlDil := 0.0;

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
  fltVolumeOri := 0.9;
  ZerarPrecos;

  For intCont := 0 To Count - 1 Do
  Begin
    objBase := TBaseAutomotiva(Items[intCont]);

    If Not qryCadBas.Locate('BAS_CODBAS', objBase.strCodBas, []) Then
    Begin
      ZerarPrecos;
      Raise Exception.Create(Format('A base %s não está cadastrada. Favor verificar', [objBase.strCodBas]));
    End;

    If fEmptyStr(qryCadBas.FieldByName('BAS_CODITE').AsString) Then
    Begin
      ZerarPrecos;
      Raise Exception.Create(Format('A base %s não está com um item associado. Favor verificar', [objBase.strCodBas]));
    End;

    If qryCadBas.FieldByName('ITE_CNV_ML').AsFloat <= 0 Then
    Begin
      ZerarPrecos;
      Raise Exception.Create(Format('O produto %s não está com o fator tintometrico preenchido corretamente. Favor verificar', [qryCadBas.FieldByName('BAS_CODITE').AsString]));
    End;

    If objBase.fltPesEsp <= 0 Then
    Begin
      ZerarPrecos;
      Raise Exception.Create(Format('A base %s não está com o peso específico preenchido corretamente. Favor verificar', [objBase.strCodBas]));
    End;

    if not IsItemAtivo(qryCadBas.FieldByName('BAS_CODITE').AsString) then
    begin
      ZerarPrecos;
      raise Exception.CreateFmt('O produto %s não está ativo, Favor verificar!', [qryCadBas.FieldByName('BAS_CODITE').AsString]);
    end;

    fltEmbala := qryCadBas.FieldByName('BAS_EMBALA').AsFloat;

    fltPreCu2Bas := fCalculaPrecoCusto2(qryCadBas.FieldByName('ITE_PREVEN').AsFloat,
                                        qryCadBas.FieldByName('ITE_PRECUS').AsFloat,
                                        objBase.fltOutVal,
                                        objBase.fltIcmSai,
                                        objBase.fltImpFed,
                                        objBase.fltDesOpe);

    fltPreCusBas := qryCadBas.FieldByName('ITE_PRECUS').AsFloat;

    fltPreCusCon := objBase.fltQtdCon * fltPreCusBas * FVolumePro / fltEmbala;
    fltPreCu2Con := objBase.fltQtdCon * fltPreCu2Bas * FVolumePro / fltEmbala;

    fltPreCusDil := objBase.fltQtdDil * fltPreCusBas * FVolumePro / fltEmbala;
    fltPreCu2Dil := objBase.fltQtdDil * fltPreCu2Bas * FVolumePro / fltEmbala;
    
    FPrecoCusCon := FPrecoCusCon + fltPreCusCon;
    FPrecoCu2Con := FPrecoCu2Con + fltPreCu2Con;

    FPrecoCusDil := FPrecoCusDil + fltPreCusDil;
    FPrecoCu2Dil := FPrecoCu2Dil + fltPreCu2Dil;

    fltPreVenBas := qryCadBas.FieldByName('ITE_PREVEN').AsFloat;

    fltQtdMlCon := (objBase.fltQtdCon * FVolumePro) / (objBase.fltPesEsp * 0.9);

    fltPreVenCon := fltQtdMlCon * fltPreVenBas  / fltEmbala;
    fltValIpiCon := fltPreVenCon * qryCadBas.FieldByName('ITE_IPISAI').AsFloat / 100;
    fltValIcmsCon := fltPreVenCon * qryCadBas.FieldByName('ITE_ICMSAI').AsFloat / 100;
    FPrecoVenCon := FPrecoVenCon + fltPreVenCon + fltValIpiCon + fltValIcmsCon;

    fltQtdMlDil := (objBase.fltQtdDil * FVolumePro) / (objBase.fltPesEsp * 0.9);

    fltPreVenDil := fltQtdMlDil * fltPreVenBas / fltEmbala;
    fltValIpiDil := fltPreVenDil * qryCadBas.FieldByName('ITE_IPISAI').AsFloat / 100;
    fltValIcmsDil := fltPreVenDil * qryCadBas.FieldByName('ITE_ICMSAI').AsFloat / 100;
    FPrecoVenDil := FPrecoVenDil + fltPreVenDil + fltValIpiDil + fltValIcmsDil;

    FOutValCon := FOutValCon + fltQtdMlCon * objBase.fltOutVal  / fltEmbala;
    FOutValDil := FOutValDil + fltQtdMlDil * objBase.fltOutVal  / fltEmbala;

    FIcmsaiCon := FIcmsaiCon + fltPreVenCon * objBase.fltIcmSai / 100;
    FIcmsaiDil := FIcmsaiDil + fltPreVenDil * objBase.fltIcmSai / 100;

    FImpFedCon := FImpFedCon + fltPreVenCon * objBase.fltImpFed / 100;
    FImpFedDil := FImpFedDil + fltPreVenDil * objBase.fltImpFed / 100;

    FDesOpeCon := FDesOpeCon + fltPreVenCon * objBase.fltDesOpe / 100;
    FDesOpeDil := FDesOpeDil + fltPreVenDil * objBase.fltDesOpe / 100;

    FPreMedCon := FPreMedCon + fltQtdMlCon * objBase.fltPreMed / fltEmbala;
    FPreMedDil := FPreMedDil + fltQtdMlDil * objBase.fltPreMed / fltEmbala;
  End;

  pCarregaPrecosBases;
end;

procedure TGeneral.pCarregaPrecosBases;
  Var
    intContador: Integer;
    objBase: TBaseAutomotiva;
begin

  For intContador := 0 To Self.Count - 1 Do
  Begin
    objBase := TBaseAutomotiva(Self.Items[intContador]);
    qryCadBas.Locate('BAS_CODBAS', objBase.strCodBas, []);

    objBase.fltEmbala := qryCadBas.FieldByName('BAS_EMBALA').AsFloat;
    objBase.fltPesEsp := qryCadBas.FieldByName('BAS_PESESP').AsFloat;
    objBase.fltPreVen := qryCadBas.FieldByName('ITE_PREVEN').AsFloat;
    objBase.strImpDir := qryCadBas.FieldByName('ITE_IMPDIR').AsString;
    objBase.strCodIte := qryCadBas.FieldByName('BAS_CODITE').AsString;            

    objBase.fltOutVal := qryCadBas.FieldByName('ITE_OUTVAL').AsFloat;

    if fCfgSis('IMPCF4', varBoolean) and Assigned(calculadorFatVendas) then
      objBase.fltIcmSai := calculadorFatVendas.fCalculaAliquota(objBase.strCodIte, objBase.strImpDir)
    else
      objBase.fltIcmSai := qryCadBas.FieldByName('ITE_ICMSAI').AsFloat;
      
    objBase.fltImpFed := qryCadBas.FieldByName('ITE_IMPFED').AsFloat;
    objBase.fltDesOpe := qryCadBas.FieldByName('ITE_DESOPE').AsFloat;
    objBase.fltPreMed := qryCadBas.FieldByName('ITE_PREMED').AsFloat;    
  End;

  FCalculo.Clear;
  FCalculo.Add('VolumeFormula  = ' + FloatToStrF(FVolumeOri, ffFixed, 12, 4));
  FCalculo.Add('Valor da Base  = (Qtde. Concentrado * Preço) / (Embalagem * Peso Específico)');
  FCalculo.Add('Preço da Tinta = Soma(Valores de Base) * Volume Produzido');
end;

procedure TGeneral.pCarregarColorantes;
begin
  qryCadBas.SQL.Clear;
  qryCadBas.SQL.Add(' SELECT                               ');
  qryCadBas.SQL.Add('   BAS_CODBAS                         ');
  qryCadBas.SQL.Add('   , BAS_CODITE                       ');
  qryCadBas.SQL.Add('   , BAS_EMBALA                       ');
  qryCadBas.SQL.Add('   , BAS_PESESP                       ');
  qryCadBas.SQL.Add('   , BAS_I_P_I_                       ');
  qryCadBas.SQL.Add('   , BAS_ICMS__                       ');
  qryCadBas.SQL.Add('   , ITE_CNV_ML                       ');

  If (fArqIniTinta(0, 'GERAL', 'PRECO_GERACAO', '0') <>  '0') Then
  begin
    qryCadBas.SQL.Add('   , ITE_ICMSAI                       ');
    qryCadBas.SQL.Add('   , ITE_IMPFED                       ');
    qryCadBas.SQL.Add('   , ITE_DESOPE                       ');
    qryCadBas.SQL.Add('   , ITE_OUTVAL                       ');
    qryCadBas.SQL.Add('   , ITE_PREMED                       ');
  end
  else
  begin
    qryCadBas.SQL.Add('   , 0 AS ITE_ICMSAI                  ');
    qryCadBas.SQL.Add('   , 0 AS ITE_IMPFED                  ');
    qryCadBas.SQL.Add('   , 0 AS ITE_DESOPE                  ');
    qryCadBas.SQL.Add('   , 0 AS ITE_OUTVAL                  ');
    qryCadBas.SQL.Add('   , 0 AS ITE_PREMED                  ');
  end;

  If (fArqIniTinta(0, 'GERAL', 'PRECO_GERACAO', '0') = '0') Then
  begin
    qryCadBas.SQL.Add('   , BAS_PRECUS AS ITE_PRECUS         ');
    qryCadBas.SQL.Add('   , BAS_PREVEN AS ITE_PREVEN         ');
    qryCadBas.SQL.Add('   , BAS_I_P_I_ AS ITE_IPISAI         ');
    qryCadBas.SQL.Add('   , BAS_ICMS__ AS ITE_ICMSAI         ');
  end
  else if (fArqIniTinta(0, 'GERAL', 'PRECO_GERACAO', '0') = '1') and FBlnCalculaUnitario then
  begin
    qryCadBas.SQL.Add('   , G.ITE_PRECUS                     ');
    qryCadBas.SQL.Add('   , G.ITE_PREVE' + fArqIniTinta(0, 'GERAL', 'TABPRECO_GERACAO', '1') + ' AS ITE_PREVEN       ');
    qryCadBas.SQL.Add('   , G.ITE_IPISAI                     ');
    qryCadBas.SQL.Add('   , G.ITE_ICMSAI                     ');
  end
  else
  begin
    qryCadBas.SQL.Add('   , G.ITE_PRECUS                     ');
    qryCadBas.SQL.Add('   , G.ITE_PREVE' + strTabPre + ' AS ITE_PREVEN       ');
    qryCadBas.SQL.Add('   , G.ITE_IPISAI                     ');
    qryCadBas.SQL.Add('   , G.ITE_ICMSAI                     ');
  end;

  If fCfgSis('IMPDIG') = '1' Then
    qryCadBas.SQL.Add('   , I.ITE_IMPDIR                     ')
  else
    qryCadBas.SQL.Add('   , G.ITE_IMPDIR                     ');

  qryCadBas.SQL.Add(' FROM                                 ');
  qryCadBas.SQL.Add('   GEN_CADBAS                         ');
  qryCadBas.SQL.Add('   INNER JOIN ITEGER G                ');
  qryCadBas.SQL.Add('     ON BAS_CODITE = G.ITE_CODITE     ');
  qryCadBas.SQL.Add('   INNER JOIN CADITE I                ');
  qryCadBas.SQL.Add('     ON G.ITE_CODITE = I.ITE_CODITE   ');
  qryCadBas.SQL.Add(' WHERE G.ITE_CODEMP = :CODEMP         ');

  qryCadBas.ParamByName('CODEMP').AsString := VS_strCodEmp;
  qryCadBas.Open;
end;

{ TfrmConsultaCompGeneral }

procedure TfrmConsultaCompGeneral.pTarefaFormulacao(Sender: TObject);
var
  qryTinta: TUniQuery;
  dicRetorno: TDicionario;
  stlDesEmb: TStringList;
  stlProEmb: TStringList;
  stlProEmbGl: TStringList;

  strProEmbCo: String;
  strProEmbSp: String;
  strIteEmb: String;
  strTipEmb: String;
  strTipPre: String;

  intQtdEmb: Integer;

  fltPreEmb: Double;
  fltEmbala: Double;
  fltPreCus: Double;
  fltPreVen: Double;
  fltVolPro: Double;
  conf: IConfTinta;
begin
  qryTinta := nil;
  dicRetorno := nil;
  stlDesEmb := nil;
  stlProEmb := nil;
  stlProEmbGl := nil;
  Try
    Try
      If (Not qryConsulta.Active) Or (qryConsulta.IsEmpty) Then
        Exit;

      conf     := fGetConfTinta('GEN');
      dicRetorno := TDicionario.Create;
      stlDesEmb := TStringList.Create;
      stlProEmbGl := TStringList.Create;
      stlProEmb := TStringList.Create;

      qryTinta := fCriaQuery(Self);
      qryTinta.SQL.Add('SELECT * FROM GEN_CADGEN WHERE AUTOINCREM = :AUTINC');
      qryTinta.ParamByName('AUTINC').AsString := qryConsulta.FieldByName('AUTOINCREM').AsString;
      qryTinta.Open;

      stlDesEmb.Add(qryTinta.FieldByName('GEN_PRODUT').AsString);
      stlProEmbGl.Add(conf.fGet('GENGAL')); //stlProEmbGl.Add(fArqIniTinta(0, 'GENERAL', 'GENGAL', ''));
      stlProEmb.Add(conf.fGet('GENLIT')); //stlProEmb.Add(fArqIniTinta(0, 'GENERAL', 'GENLIT', ''));
      strProEmbCo := conf.fGet('GENCOP'); //fArqIniTinta(0, 'GENERAL', 'GENCOP', '');
      strProEmbSp := conf.fGet('GENSPR'); //fArqIniTinta(0, 'GENERAL', 'GENSPR', '');

      dicRetorno['idepro'] := 'GEN';

      fDigDadosTintometricos(qryTinta, stlDesEmb, stlProEmb, stlProEmbGl, strProEmbCo, strProEmbSp,
                            strIteEmb, strTipEmb, strTipPre, intQtdEmb, fltPreEmb, fltEmbala,
                            fltPreCus, fltPreVen, fltVolPro, strTabPre, dicRetorno);
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(qryTinta) then FreeAndNil(qryTinta);
    if Assigned(dicRetorno) then FreeAndNil(dicRetorno);
    if Assigned(stlDesEmb) then FreeAndNil(stlDesEmb);
    if Assigned(stlProEmb) then FreeAndNil(stlProEmb);
    if Assigned(stlProEmbGl) then FreeAndNil(stlProEmbGl);
  End;
end;

procedure TfrmConsultaCompGeneral.pTarefaPrecos(Sender: TObject);
begin
  inherited;
  pTarefaFormulacao(Sender);
end;

procedure TfrmConsultaCompGeneral.pTarefaVenda(Sender: TObject);
begin
  inherited;
  fCriarProcesso('AutTin\AutTin.exe exec ' + strLoginUsuarioLogado + ' 1 ' + VS_strCodEmp + ' TfrmCadGenNfm', False);
end;

function fConsultaGeneralAutomotivaDinamica(Sender: TForm): String; stdcall;
  Var
    qryGen: TUniQuery;
Begin
  qryGen := fCriaQuery();
  Result := fConsultaGeneralAutomotivaDinamicaInterna(Sender,qryGen, tpcGeral, IIF(fEmptyStr(fCfgSis('TABPAD')), '1', fCfgSis('TABPAD')));
  FreeAndNil(qryGen);
End;

function fConsultaGeneralAutomotivaDinamicaGeral(Sender: TForm): String; stdcall;
Begin
  Result := fConsultaGeneralAutomotivaDinamica(Sender);
End;

function fConsultaGeneralAutomotivaDinamicaVenda(Sender: TForm; qryTinta: TUniQuery;
  strTabPre: String): String; stdcall;
Begin
  Result := fConsultaGeneralAutomotivaDinamicaInterna(Sender, qryTinta, tpcVenda, strTabPre);
End;

function fConsultaGeneralAutomotivaDinamicaInterna(Sender: TForm; qryTinta: TUniQuery;
  tipoConsulta: TTipoConsulta; strTabPre: String): String;
{
  Var
    strSql: String;
    stlCamInd: TStringList;
    stlDesInd: TStringList;
    frmConsulta: TfrmConsultaCompGeneral;
}
begin
{
  Result := '-1';

  If Not Assigned(qryTinta) Then
    Exit;

  strSQL := '';
  strSQL := strSQL + ' SELECT ';
  strSQL := strSQL + '   GEN_CADGEN.AUTOINCREM, ';
  strSQL := strSQL + '   GEN_CODIGO               "Código", ';
  strSQL := strSQL + '   GEN_VARIAC               "Variação", ';
  strSQL := strSQL + '   GEN_DESCRI               "Descrição", ';
  strSQL := strSQL + '   MON_DESCRI               "Montadora", ';
  strSQL := strSQL + '   GEN_ANOINI               "Ano Inicial", ';
  strSQL := strSQL + '   GEN_ANOFIN               "Ano Final", ';
  strSQL := strSQL + '   GEN_NACION               "Nascional", ';
  strSQL := strSQL + '   GEN_CODCOR               "Código Cor", ';
  strSQL := strSQL + '   GEN_VERSAO               "Versão", ';
  strSQL := strSQL + '   GEN_PRODUT               "Produto", ';
  strSQL := strSQL + '   GEN_OBSERV               "Observação" ';
  strSQL := strSQL + ' FROM GEN_CADGEN ';
  strSQL := strSQL + '   LEFT JOIN GEN_CADMON ';
  strSQL := strSQL + '     ON GEN_CODMON = MON_CODMON ';
  strSQL := strSQL + ' WHERE TRUE ';

  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCamInd.Add('GEN_DESCRI');
  stlCamInd.Add('GEN_CODIGO+GEN_VARIAC');
  stlCamInd.Add('MON_DESCRI');
  stlCamInd.Add('GEN_ANOINI+GEN_ANOFIN');
  stlCamInd.Add('GEN_CODCOR');
  stlCamInd.Add('GEN_PRODUT+GEN_DESCRI');

  stlDesInd.Add('Descrição');
  stlDesInd.Add('Código/Variação');
  stlDesInd.Add('Montadora');
  stlDesInd.Add('Ano Inicial/Ano Final');
  stlDesInd.Add('Código Cor');
  stlDesInd.Add('Produto/Descrição');

  frmConsulta := TfrmConsultaCompGeneral.Create(Sender, tipoConsulta, strTabPre);
  frmConsulta.Caption := 'Consulta General';

  If pConsultaEspecifica(Sender, frmConsulta, qryTinta, 'GEN_CADGEN', strSql,
    stlCamInd, stlDesInd, '', False, True, 5, True) Then
  Begin
    If Not qryTinta.IsEmpty Then
      Result := qryTinta.FieldByName('AUTOINCREM').AsString;
  End;

  FreeAndNil(stlCamInd);
  FreeAndNil(stlDesInd);
  FreeAndNil(frmConsulta);
}

  Result := (TGeneralConsulta.Create).fExecutarConsulta(Sender,
    qryTinta, tipoConsulta, strTabPre, TfrmConsultaCompGeneral);

end;

function fGTinForGeneralAutomotivaDinamica(strIteTin: String; strTipPre: String;
          Var arrFormul: TForMulTinDetArray; Var arrBaixaPigmentos: TBaixaPigmentosArray;
          Var stlItensTraMl: TStringList; fltVolPro: Double): Boolean; stdcall;
  Var
    qryGen: TUniQuery;
    dicRetorno: TDicionario;
    strBases: String;
    strSql: String;
    intCont: Integer;
Begin
  qryGen := fCriaQuery();
  dicRetorno := TDicionario.Create;

  Result := True;

  strSQL := '';
  strSQL := strSQL + ' SELECT * ';
  strSQL := strSQL + ' FROM GEN_CADGEN ';
  strSQL := strSQL + ' WHERE  ';
  strSQL := strSQL + '    UPPER(CAST(MD5(CONCAT( ';
  strSQL := strSQL + '       IFNULL(GEN_CODIGO, ""),  ';
  strSQL := strSQL + '       IFNULL(GEN_VARIAC, ""),  ';
  strSQL := strSQL + '       IFNULL(GEN_DESCRI, ""),  ';
  strSQL := strSQL + '       IFNULL(GEN_CODMON, ""),  ';
  strSQL := strSQL + '       IFNULL(GEN_ANOINI, ""),  ';
  strSQL := strSQL + '       IFNULL(GEN_ANOFIN, ""),  ';
  strSQL := strSQL + '       IFNULL(GEN_NACION, ""),  ';
  strSQL := strSQL + '       IFNULL(GEN_CODCOR, ""),  ';
  strSQL := strSQL + '       IFNULL(GEN_VERSAO, ""),  ';
  strSQL := strSQL + '       IFNULL(GEN_CODNFM, ""),  ';
  strSQL := strSQL + '       IFNULL(GEN_PRODUT, "")))AS CHAR)) = :ITETIN ';

  qryGen := fCriaQuery();
  qryGen.SQL.Text := strSql;
  qryGen.ParamByName('ITETIN').AsString := strIteTin;
  qryGen.Open;

  If qryGen.IsEmpty Then
  Begin
    Result := False;
    FreeAndNil(qryGen);
    Exit;
  End;

  dicRetorno := TDicionario.Create;

  For intCont := 1 To 15 Do
  Begin
    If fEmptyStr(qryGen.FieldByName('GEN_FORM' + fStrZero(intCont, 2)).AsString) Then
      Break;

    If (strTipPre = 'C') And (qryGen.FieldByName('GEN_QTDC' + fStrZero(intCont, 2)).AsFloat = 0) Then
      Break;

    arrFormul[intCont].strFormul := qryGen.FieldByName('GEN_FORM' + fStrZero(intCont, 2)).AsString;

    If strTipPre = 'C' Then
      arrFormul[intCont].fltQtdbas := qryGen.FieldByName('GEN_QTDC' + fStrZero(intCont, 2)).AsFloat
    Else
    Begin
      arrFormul[intCont].fltQtdbas :=
        qryGen.FieldByName('GEN_QTDC' + fStrZero(intCont, 2)).AsFloat * 5 / 6
    End;

    arrFormul[intCont].fltQtdbas := fltVolPro * arrFormul[intCont].fltQtdbas / 0.9;
    dicRetorno[arrFormul[intCont].strFormul] := arrFormul[intCont].fltQtdbas;

    strBases := strBases + ',' + QuotedStr(arrFormul[intCont].strFormul);
  End;

  {**************************************************************************}
  {* TINTA GENERAL SOMENTE TEM DILUIDO QUANDO É PU, E SOMENTE É UM DILUENTE *}
  {***********************************************************************PH*}
  If strTipPre = 'D' Then
  Begin
    arrFormul[intCont].strFormul := '7540563';
    arrFormul[intCont].fltQtdbas := 110.13 * fltVolPro / 750;
  End;

  strBases := Trim(strBases);
  strBases := Copy(strBases, 2, Length(strBases));

  strSql := '';
  strSql := strSql + ' SELECT ';
  strSql := strSql + '   BAS_CODBAS, ';
  strSql := strSql + '   BAS_CODITE ';
  strSql := strSql + ' FROM GEN_CADBAS ';
  strSql := strSql + ' WHERE BAS_CODBAS IN(' + strBases + ') ';

  qryGen.Close;
  qryGen.SQL.Text := strSql;
  qryGen.Open;

  SetLength(arrBaixaPigmentos, qryGen.RecordCount);

  While Not qryGen.Eof Do
  Begin
    stlItensTraMl.Add(qryGen.FieldByName('BAS_CODITE').AsString);
    arrBaixaPigmentos[qryGen.RecNo - 1].strCodIte := qryGen.FieldByName('BAS_CODITE').AsString;
    arrBaixaPigmentos[qryGen.RecNo - 1].fltQtdBaixa := dicRetorno[qryGen.FieldByName('BAS_CODBAS').AsString];
    qryGen.Next;
  End;

  FreeAndNil(dicRetorno);
  FreeAndNil(qryGen);
End;

function fDigDadosTintometricos(qryCadGen: TUniQuery; stlDesEmb, stlProEmbLt,
  stlProEmbGl: TStringList; strProEmbCo,
  strProEmbSp: String; Var strIteEmb,
  strTipEmb, strTipPre: String; Var intQtdEmb: Integer; Var fltPreEmb, fltEmbala,
  fltPreCus, fltPreVen, fltVolPro: Double; strTabPre: String; dicRetorno: TDicionario): Boolean;
var
  objBase: TBaseAutomotiva;
  objFormula: TGeneral;
  intCont: Integer;
  fltPreCu2: Double;
  calculadorFatVendas: ICalculadorFatVendas;  
Begin
  Result := False;
  frmDigTintaAutomotiva := nil;
  objFormula := nil;
  Try
    Try
      if not Supports(dicRetorno.RetornaObjeto('calculadorFatVendas'), ICalculadorFatVendas, calculadorFatVendas) then
        calculadorFatVendas := nil;
            
      objFormula := TGeneral.Create(strTabPre);
      objFormula.calculadorFatVendas := calculadorFatVendas;
      objFormula.strDescri := fRetornaDescricaoGeneralAutomotivaDinamica(qryCadGen, '');
      objFormula.strOpcDoc := IfNull(dicRetorno['opcdoc'], '');

      For intCont := 1 To 15 Do
      Begin
        If fEmptyStr(qryCadGen.FieldbyName('GEN_FORM' + fStrZero(intCont, 2)).AsString) Then
          Break;

        objBase := TBaseAutomotiva(objFormula.Add);
        objBase.strCodBas := qryCadGen.FieldbyName('GEN_FORM' + fStrZero(intCont, 2)).AsString;
        objBase.fltQtdCon := qryCadGen.FieldbyName('GEN_QTDC' + fStrZero(intCont, 2)).AsFloat;

        { TEM DILUIDO }
        If qryCadGen.FieldByName('GEN_PRODUT').AsString = 'PU' Then
        Begin
          objBase.fltQtdDil := objBase.fltQtdCon * 5 / 6;
        End;

        objFormula.qryCadBas.Locate('BAS_CODBAS', objBase.strCodBas, []);
        objBase.fltEmbala := objFormula.qryCadBas.FieldByName('BAS_EMBALA').AsFloat;
        objBase.fltPesEsp := objFormula.qryCadBas.FieldByName('BAS_PESESP').AsFloat;

        If (objFormula.blnTemConcentrado) And (objBase.fltQtdCon = 0) Then
          objBase.strTipBas := 'D'
        Else
          objBase.strTipBas := 'B';
      End;

      {**************************************************************************}
      {* TINTA GENERAL SOMENTE TEM DILUIDO QUANDO É PU, E SOMENTE É UM DILUENTE *}
      {***********************************************************************PH*}
      If qryCadGen.FieldByName('GEN_PRODUT').AsString = 'PU' Then
      Begin
        objBase := TBaseAutomotiva(objFormula.Add);
        objBase.strCodBas := '7540563';
        objBase.fltQtdCon := 0;
        objBase.fltQtdDil := 110.13 * 900 / 750;

        objFormula.qryCadBas.Locate('BAS_CODBAS', objBase.strCodBas, []);
        objBase.fltEmbala := objFormula.qryCadBas.FieldByName('BAS_EMBALA').AsFloat;
        objBase.fltPesEsp := objFormula.qryCadBas.FieldByName('BAS_PESESP').AsFloat;
      End;

      objFormula.pCarregaPrecosBases;

      Application.CreateForm(TfrmDigTintaAutomotiva, frmDigTintaAutomotiva);
      objFormula.strCodEmpEst := IfNull(dicRetorno['codemp'], VS_strCodEmp);
      frmDigTintaAutomotiva.objFormula := objFormula;
      frmDigTintaAutomotiva.stlDesEmb := stlDesEmb;
      frmDigTintaAutomotiva.stlProEmbLt := stlProEmbLt;
      frmDigTintaAutomotiva.stlProEmbGl := stlProEmbGl;
      frmDigTintaAutomotiva.strProEmbCo := strProEmbCo;
      frmDigTintaAutomotiva.strProEmbSp := strProEmbSp;
      frmDigTintaAutomotiva.Caption := frmDigTintaAutomotiva.Caption + 'General';
      frmDigTintaAutomotiva.edtQtdEmb.Text := '1';

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
        strTipPre := IIF(frmDigTintaAutomotiva.rdgModoVenda.ItemIndex = 0, 'C', 'D');
        intQtdEmb := StrToIntDef(frmDigTintaAutomotiva.edtQtdEmb.Text, 0);
        fltPreEmb := frmDigTintaAutomotiva.objFormula.fltPrecoEmbalagem;
        fltEmbala := IIF(frmDigTintaAutomotiva.objFormula.tpeTipEmb = teLitro, 0.900, 3.600);
        fltVolPro := frmDigTintaAutomotiva.objFormula.fltVolumePro;

        If (frmDigTintaAutomotiva.rdgModoVenda.ItemIndex = 0) Then
        Begin
          fltPreCus := frmDigTintaAutomotiva.objFormula.fltPrecoCusCon + frmDigTintaAutomotiva.objFormula.fltPrecoCustoEmbalagem;
          fltPreCu2 := frmDigTintaAutomotiva.objFormula.fltPrecoCu2Con + frmDigTintaAutomotiva.objFormula.fltPrecoCusto2Embalagem;
          fltPreVen := frmDigTintaAutomotiva.objFormula.fltPrecoVenCon + frmDigTintaAutomotiva.objFormula.fltPrecoEmbalagem;
        End
        Else
        Begin
          fltPreCus := frmDigTintaAutomotiva.objFormula.fltPrecoCusDil + frmDigTintaAutomotiva.objFormula.fltPrecoCustoEmbalagem;
          fltPreCu2 := frmDigTintaAutomotiva.objFormula.fltPrecoCu2Dil + frmDigTintaAutomotiva.objFormula.fltPrecoCusto2Embalagem;
          fltPreVen := frmDigTintaAutomotiva.objFormula.fltPrecoVenDil + frmDigTintaAutomotiva.objFormula.fltPrecoEmbalagem;
        End;

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
End;

function fRetornaPrecoGeneralAutomotivaDinamica(Sender: TForm; qryTinta: TUniQuery; Var dicRetorno: TDicionario): Boolean;
  Var
    strIteTin: String;

    stlDesEmb: TStringList;
    stlProEmbGl: TStringList;
    stlProEmb: TStringList;

    strProEmbCo: String;
    strProEmbSp: String;
    strIteEmb: String;
    strTipEmb: String;
    strTipPre: String;
    intQtdEmb: Integer;
    fltPreEmb: Double;
    fltEmbala: Double;
    fltPreCus: Double;
    fltPreVen: Double;
    fltVolPro: Double;
    strTabPre: String;

    fltPrcTin: Double;
    fltPrvTin: Double;

    blnUsaPreCus : Boolean;

    strAuto: String;
    tinta : IConsultaTinta;
    strDesCor : String;
    conf : IConfTinta;
Begin
  Result := False;

  stlDesEmb := TStringList.Create;
  stlProEmbGl := TStringList.Create;
  stlProEmb := TStringList.Create;

  blnUsaPreCus := dicRetorno['usaprecus'];
{
  If fConsultaGeneralAutomotivaDinamicaVenda(Sender, qryTinta, strTabPre) = '-1' Then
    Exit;
}

  strAuto := fConsultaGeneralAutomotivaDinamicaVenda(Sender, qryTinta, strTabPre);

  If (strAuto = '-1') Then
  Begin
    Exit;
  End;

  conf  := fGetConfTinta('GEN');
  tinta := TGeneralConsulta.Create;

  qryTinta.Close;
  qryTinta.SQL.Text := tinta.fGetSelectAutoIncrem(strAuto);
  qryTinta.Open;

  strIteTin := fGetMd5MySQl(qryTinta.FieldByName('GEN_CODIGO').AsString +
                            qryTinta.FieldByName('GEN_VARIAC').AsString +
                            qryTinta.FieldByName('GEN_DESCRI').AsString +
                            qryTinta.FieldByName('GEN_CODMON').AsString +
                            qryTinta.FieldByName('GEN_ANOINI').AsString +
                            qryTinta.FieldByName('GEN_ANOFIN').AsString +
                            qryTinta.FieldByName('GEN_NACION').AsString +
                            qryTinta.FieldByName('GEN_CODCOR').AsString +
                            qryTinta.FieldByName('GEN_VERSAO').AsString +
                            qryTinta.FieldByName('GEN_CODNFM').AsString +
                            qryTinta.FieldByName('GEN_PRODUT').AsString);

  stlDesEmb.Add(qryTinta.FieldByName('GEN_PRODUT').AsString);
  stlProEmbGl.Add(conf.fGet('GENGAL')); //stlProEmbGl.Add(fArqIniTinta(0, 'GENERAL', 'GENGAL', ''));
  stlProEmb.Add(conf.fGet('GENLIT')); //stlProEmb.Add(fArqIniTinta(0, 'GENERAL', 'GENLIT', ''));
  strProEmbCo := conf.fGet('GENCOP'); //fArqIniTinta(0, 'GENERAL', 'GENCOP', '');
  strProEmbSp := conf.fGet('GENSPR'); //fArqIniTinta(0, 'GENERAL', 'GENSPR', '');

  If Not fDigDadosTintometricos(qryTinta, stlDesEmb, stlProEmb, stlProEmbGl, strProEmbCo, strProEmbSp,
                        strIteEmb, strTipEmb, strTipPre, intQtdEmb, fltPreEmb, fltEmbala,
                        fltPreCus, fltPreVen, fltVolPro, strTabPre, dicRetorno) Then
    Exit;

  strDesCor := Trim(tinta.fGetDescricao(qryTinta.FieldByName('AUTOINCREM').AsString));    

  fltPrcTin := fltPreCus;
  If blnUsaPreCus Then
    fltPreVen := fltPreCus;

  fltPrvTin := fltPreVen;

  dicRetorno['unidad'] := fRetUnidadeItem(strIteEmb);
  dicRetorno['precus'] := fltPreCus;
  dicRetorno['unitar'] := fltPreVen;
  dicRetorno['prctin'] := fltPrcTin;
  dicRetorno['prvtin'] := fltPrvTin;
  dicRetorno['codite'] := conf.fGet('GENPRO'); //fArqIniTinta(0, 'GENERAL', 'GENPRO', '');
  dicRetorno['itetin'] := strIteTin;
  dicRetorno['tippre'] := strTipPre;

  dicRetorno['iteemb'] := strIteEmb;
  dicRetorno['gruemb'] := fRetGrupoItem(strIteEmb); //strGruEmb;
  dicRetorno['tipemb'] := strTipEmb;
  dicRetorno['qtdemb'] := intQtdEmb;
  dicRetorno['preemb'] := fltPreEmb;
  dicRetorno['embala'] := fltEmbala;
  dicRetorno['volpro'] := fltVolPro;

  dicRetorno['montad'] := fRetDescriMontadora(qryTinta.FieldByName('GEN_CODMON').AsString);
  dicRetorno['a_n_o_'] := qryTinta.FieldByName('GEN_ANOINI').AsString;
  dicRetorno['chafor'] := fRetornaDescricaoGeneralAutomotivaDinamica(qryTinta, strDesCor);
  dicRetorno['descor'] := strDesCor;

  FreeAndNil(stlDesEmb);
  FreeAndNil(stlProEmbGl);
  FreeAndNil(stlProEmb);

  Result := True;
End;

function fRetornaDescricaoGeneralAutomotivaDinamica(qryCadGen: TUniQuery; strDesCor: String): String;
Begin
  Result := strDesCor;      
End;

procedure pRetornaDadosGeneralAutomotivaDinamica(strIteTin: String; dicRetorno: TDicionario);
  Var
    qryGen: TUniQuery;
    strSql: String;
Begin
  strSQL :=
    ' SELECT                              ' +
    '   *                                 ' +
    ' FROM                                ' +
    '   GEN_CADGEN                        ' +
    '   LEFT JOIN GEN_CADMON              ' +
    '     ON GEN_CODMON = MON_CODMON      ' +
    ' WHERE UPPER(CAST(MD5(CONCAT(        ' +
    '           IFNULL(GEN_CODIGO, "")    ' +
    '           , IFNULL(GEN_VARIAC, "")  ' +
    '           , IFNULL(GEN_DESCRI, "")  ' +
    '           , IFNULL(GEN_CODMON, "")  ' +
    '           , IFNULL(GEN_ANOINI, "")  ' +
    '           , IFNULL(GEN_ANOFIN, "")  ' +
    '           , IFNULL(GEN_NACION, "")  ' +
    '           , IFNULL(GEN_CODCOR, "")  ' +
    '           , IFNULL(GEN_VERSAO, "")  ' +
    '           , IFNULL(GEN_CODNFM, "")  ' +
    '           , IFNULL(GEN_PRODUT, "")  ' +
    '         )) AS CHAR)) = :ITETIN      ';

  qryGen := fCriaQuery();
  qryGen.SQL.Text := strSql;
  qryGen.ParamByName('ITETIN').AsString := strIteTin;
  qryGen.Open;

  dicRetorno['codtin'] := qryGen.FieldByName('GEN_CODIGO').AsString + ' ' +
                          qryGen.FieldByName('GEN_VARIAC').AsString + ' ' +
                          qryGen.FieldByName('GEN_DESCRI').AsString + ' ' +
                          qryGen.FieldByName('GEN_ANOINI').AsString + ' ' +
                          qryGen.FieldByName('GEN_ANOFIN').AsString + ' ' +
                          qryGen.FieldByName('GEN_NACION').AsString + ' ' +
                          qryGen.FieldByName('GEN_CODCOR').AsString + ' ' +
                          qryGen.FieldByName('GEN_VERSAO').AsString + ' ' +
                          qryGen.FieldByName('GEN_PRODUT').AsString;


  dicRetorno['montad'] := qryGen.FieldByName('MON_DESCRI').AsString;
  FreeAndNil(qryGen);

End;

procedure pRetornaTabelaPrecoGeneralAutomotiva(dicRetorno: TDicionario; fltFatorAcerto: Double);
var
  objFormula: TGeneral;
  objBase: TBaseAutomotiva;
  intContador: Integer;
  strTabelas: String;
  calculadorFatVendas: ICalculadorFatVendas;
begin
  objFormula := nil;
  Try
    Try
      if not Supports(dicRetorno.RetornaObjeto('calculadorFatVendas'), ICalculadorFatVendas, calculadorFatVendas) then
        calculadorFatVendas := nil;
            
      objFormula := TGeneral.Create('1');
      objFormula.blnCalculaUnitario := False;
      objFormula.calculadorFatVendas := calculadorFatVendas;
      objFormula.fltVolumeOri := 0.9;
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
        objBase.fltQtdCon := fFormataFloat(dicRetorno['qtdb' + fStrZero(intContador, 2)], 3);
        objBase.fltQtdDil := 0.0;
        objBase.strTipBas := 'B';
      End;

      strTabelas := fCfgSis('TABPRC');
      If Length(strTabelas) < 7 Then
        strTabelas := strTabelas + StringOfChar('N',7 - Length(strTabelas));

      For intContador := 1 To Length(strTabelas) Do
      Begin
        if strTabelas[intContador] = 'S' then
        begin
          objFormula.strTabPre := IntToStr(intContador);
          objFormula.pCarregarColorantes;
          objFormula.pCarregaPrecosBases;
          objFormula.pCalcularPrecos;
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
End;

function fRetDescriMontadora(strCodMon: String): String;
  Var
    qryGen: TUniQuery;
begin
  qryGen := fCriaQuery();

  qryGen.SQL.Add(' SELECT ');
  qryGen.SQL.Add('   MON_DESCRI ');
  qryGen.SQL.Add(' FROM GEN_CADMON ');
  qryGen.SQL.Add(' WHERE MON_CODMON = :CODMON ');

  qryGen.ParamByName('CODMON').AsString := strCodMon;
  qryGen.Open;
  Result := qryGen.FieldByName('MON_DESCRI').AsString;
  FreeAndNil(qryGen);
end;

function fRetornaUniTraProGeneralAutomotivaDinamica(fltPrcTin, fltPrvTin: Double): Double;
Var
  conf: IConfTinta;
begin
  conf     := fGetConfTinta('GEN');

//  If fArqIniTinta(0, 'GENERAL', 'GENTRV', '') = 'VEN' Then
  If conf.fGet('GENTRV') = 'VEN' Then
    Result :=  fltPrvTin * fStrToFloat(conf.fGet('GENFAT')) //fStrToFloat(fArqIniTinta(0, 'GENERAL', 'GENFAT', ''), 0)
  Else
    Result :=  fltPrcTin * fStrToFloat(conf.fGet('GENFAT'));//fStrToFloat(fArqIniTinta(0, 'GENERAL', 'GENFAT', ''), 0);

  Result := fFormataFloat(Result, 2);
end;


end.
