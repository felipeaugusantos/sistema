unit untLazzumixDinamica;

interface

uses SysUtils, Forms, Uni, Classes, untFuncoesSimples,
  StrUtils, untFuncEspecificas, Controls, Dialogs, untConsultaCompTintaNova,
  untConsultaCompTinta, untPnlBotoesAcoesNovaConsulta,
  Math;

Type
  TFormulaLazzumix = class(TFormulaAutomotiva)
  private
    fltPerFre: Double;
    fltPerIpi: Double;
    fltPerRet: Double;
    fltPerAdi: Double;
    fltPerPer: Double;
    fltMarLuc: Double;
    fltPerAcr: Double;
  protected
    function GetPrecoEmbalagem: Double; override;
  public
    fltVolumeConcentrado: Double;
    fltVolumeDiluido: Double;

    procedure pCarregarColorantes; override;
    procedure pCalcularPrecos; override;
    procedure pCarregaPrecosBases; override;
    Constructor Create(strTabPre: String); override;
  End;

  TfrmConsultaCompTintaLazzumix = class(TfrmPnlBotoesAcoesNovaConsulta)
  public
    procedure pTarefaFormulacao(Sender: TObject); override;
    procedure pTarefaPrecos(Sender: TObject); override;
    procedure pTarefaVenda(Sender: TObject); override;
  End;

  function fConsultaLazzumixDinamica(Sender: TForm): string; stdcall;
  function fConsultaLazzumixGeralDinamica(Sender: TForm; strCodEmp: String): String; stdcall;
  function fConsultaLazzumixVendaDinamica(Sender: TForm; strCodEmp: String;
    Var qryCadMix: TUniQuery; strTabPre: String): String; stdcall;

  function fConsultaLazzumixInterna(Sender: TForm; Var qryCadMix: TUniQuery;
    tipoConsulta: TTipoConsulta; strTabPre: String): String; stdcall;

  function fRetornaUniTraProLazzumixDinamica(strTipPre: String;
    fltPrcTin, fltPrvTin: Double): Double;

  function fRetornaDescricaoLazzumixDinamica(qryCadMix: TUniQuery; strDesCor: String): String;

  function fRetornaPrecoLazzumixDinamica(Sender: TForm; qryTinta: TUniQuery;
    Var dicRetorno: TDicionario): Boolean;

  function fDigDadosTintometricos(qryCadMix: TUniQuery; stlDesEmb, stlProEmbLt, 
    stlProEmbGl: TStringList; stlProEmbLa: TStringList; strProEmbCo, strProEmbSp:
    String; Var strIteEmb, strTipEmb, strTipPre: String;
    Var intQtdEmb: Integer; Var fltPreEmb, fltEmbala, fltPreCus, fltPreVen,
    fltVolPro: Double; strTabPre: String; dicRetorno: TDicionario): Boolean;

  function fGTinForLazzumixDinamica(strIteTin: String; fltVolPro: Double; strTipPre: String;
    Var arrFormul: TForMulTinDetArray; Var arrBaixaPigmentos: TBaixaPigmentosArray;
    Var stlItensTraMl: TStringList): Boolean; stdcall;

  procedure pRetornaDadosLazzumixDinamica(strIteTin: String; dicRetorno: TDicionario);

  procedure pRetornaTabelaPrecoLazzumix(dicRetorno: TDicionario; fltFatorAcerto: Double);

  function fValidaVolumeFormulucao(strTipPre: String; fltVolCon, fltVolDil: Double) : Boolean;

implementation

uses Data.DB,
  untDigTintaAutomotiva, Variants,
  untGenericTintaDeMaquinaComponente, untTintaDeMaquinaComponenteTipo,
  untTintaDeMaquinaComponenteComparerBaseAutomotiva,untFuncoes,
untIConfTinta,
untICalculadorFatVendas,
untITintaDeMaquinaComponente,
untIConsultaTinta,
untLazzumixConsulta,
untTintaMaquina;

function fConsultaLazzumixDinamica(Sender: TForm): String;
  Var
    qryCadMix: TUniQuery;
begin
  qryCadMix := fCriaQuery(Sender);
  Result :=  fConsultaLazzumixInterna(Sender, qryCadMix, tpcGeral, IIF(fEmptyStr(fCfgSis('TABPAD')), '1', fCfgSis('TABPAD')));
  FreeAndNil(qryCadMix);

end;

function fConsultaLazzumixGeralDinamica(Sender: TForm; strCodEmp: String): string;
Begin
  Result := fConsultaLazzumixDinamica(Sender);
end;

function fConsultaLazzumixVendaDinamica(Sender: TForm; strCodEmp: String;
  Var qryCadMix: TUniQuery; strTabPre: String): string;
Begin
  Result := fConsultaLazzumixInterna(Sender, qryCadMix, tpcVenda, strTabPre);
end;

function fRetornaUniTraProLazzumixDinamica(strTipPre: String;
  fltPrcTin, fltPrvTin: Double): Double;
  Var
    strTraLazzumix: String;
    fltTraLazzumix: Double;
    conf: IConfTinta;
Begin
  conf := fGetConfTinta('LAZ');

  If (strTipPre = 'C') Then
  Begin
    strTraLazzumix := IIF(conf.fGet('TRACLZ') = '1', 'VEN', 'CUS');
    fltTraLazzumix := conf.fGetDouble('FATCLZ');
  End
  Else
  Begin
    strTraLazzumix := IIF(conf.fGet('TRADLZ') = '3', 'VEN', 'CUS');
    fltTraLazzumix := conf.fGetDouble('FATDLZ');
  End;

  If (strTraLazzumix = 'VEN') Then
    Result := fltPrvTin
  Else
    Result := fltPrcTin;

  Result := fFormataFloat(Result * fltTraLazzumix, 2);
end;

function fRetornaDescricaoLazzumixDinamica(qryCadMix: TUniQuery; strDesCor: String): String;
Begin
  Result := strDesCor;
end;

function fRetornaPrecoLazzumixDinamica(Sender: TForm; qryTinta: TUniQuery;
  Var dicRetorno: TDicionario): Boolean;
  Var
    {*******************************************}
    {* PARAMETROS                              *}
    {****************************************MV*}
    strCodEmp: String;
    strOpcDoc: String;
    blnUsaPreCus: Boolean;
    strTipPre: String;
    intLazQua: Integer;
    strTipEmb: String;
    intQtdEmb: Integer;

    strIteTin: String;
    fltPreEmb: Double;
    fltEmbala: Double;
    fltPreCus: Double;
    fltUnitar: Double;
    fltFatTin: Double;
//    fltPrcTin: Double;
    fltPrvTin: Double;

    strIteEmb: String;

    strMontad: String;
    strA_n_o_: String;

    stlDesEmb: TStringList;

    stlProEmbLt: TStringList;

    stlProEmbGl: TStringList;

    stlProEmbLa: TStringList;    

    strProEmbCo: String;

    strProEmbSp: String;

    fltVolPro: Double;
    strTabPre: String;

    strAuto: String;
    tinta : IConsultaTinta;
    strDesCor: String;
    conf: IConfTinta;
begin
  Result := False;
  stlDesEmb := nil;
  stlProEmbLt := nil;
  stlProEmbGl := nil;
  stlProEmbLa := nil;
  Try
    Try
      stlDesEmb := TStringList.Create;
      stlProEmbLt := TStringList.Create;
      stlProEmbGl := TStringList.Create;
      stlProEmbLa := TStringList.Create;

      strIteTin := '';
      fltPreCus := 0.0;
      fltUnitar := 0.0;
      fltFatTin := 0.0;

      strTipPre := '';
      strTipEmb := '';
      intQtdEmb := 0;
      fltPreEmb := 0.0;
      fltEmbala := 0.0;

      strCodEmp    := dicRetorno['codemp'];
      strOpcDoc    := dicRetorno['opcdoc'];
      blnUsaPreCus := dicRetorno['usaprecus'];
      strTipPre    := dicRetorno['tippre'];
      intLazQua    := dicRetorno['lazqua'];
      strTipEmb    := dicRetorno['tipemb'];
      intQtdEmb    := dicRetorno['qtdemb'];
      strTabPre    := dicRetorno['tabpre'];

      strAuto := fConsultaLazzumixVendaDinamica(Sender, strCodEmp, qryTinta, strTabPre);

      If (strAuto = '-1') Then
      Begin
        Exit;
      End;

      tinta := TLazzumixConsulta.Create;
      conf := fGetConfTinta('LAZ');

      qryTinta.Close;
      qryTinta.SQL.Text := tinta.fGetSelectAutoIncrem(strAuto);
      qryTinta.Open;

      strIteTin := qryTinta.FieldByName('MIX_CODIGO').AsString;
      strMontad := qryTinta.FieldByName('MIX_MONTAD').AsString;
      strA_n_o_ := qryTinta.FieldByName('MIX_A_N_O_').AsString;

      stlDesEmb.Add('LAZZURIL');
      stlDesEmb.Add('LAZZULAC');
      stlDesEmb.Add('LAZZUDUR');
      stlDesEmb.Add('P. U.');
      stlDesEmb.Add('LAZZUCRIL');
      stlDesEmb.Add('FLEET COLOR');
      stlDesEmb.Add('ULTRABASE');
      stlDesEmb.Add('LAZZUDUR PU MS');
      stlDesEmb.Add('SHERTRUCKMIX');

      stlProEmbLt.Add(conf.fGet('LAZIEM'));
      stlProEmbLt.Add(conf.fGet('LAZLLA'));
      stlProEmbLt.Add(conf.fGet('LAZLPO'));
      stlProEmbLt.Add(conf.fGet('LAZLPU'));
      stlProEmbLt.Add(conf.fGet('LAZLCR'));
      stlProEmbLt.Add(conf.fGet('LAZLFL'));
      stlProEmbLt.Add(conf.fGet('ULTRABASELT'));
      stlProEmbLt.Add(conf.fGet('PUMSLT'));
      stlProEmbLt.Add(conf.fGet('SHERLT'));

      stlProEmbGl.Add(conf.fGet('LAZIGL'));
      stlProEmbGl.Add(conf.fGet('LAZGLA'));
      stlProEmbGl.Add(conf.fGet('LAZGPO'));
      stlProEmbGl.Add(conf.fGet('LAZGPU'));
      stlProEmbGl.Add(conf.fGet('LAZGCR'));
      stlProEmbGl.Add(conf.fGet('LAZGFL'));
      stlProEmbGl.Add(conf.fGet('ULTRABASEGL'));
      stlProEmbGl.Add(conf.fGet('PUMSGL'));
      stlProEmbGl.Add(conf.fGet('SHERGL'));

      stlProEmbLa.Add(conf.fGet('LAZILA'));
      stlProEmbLa.Add(conf.fGet('LAZLAZ'));
      stlProEmbLa.Add(conf.fGet('LAZLDU'));
      stlProEmbLa.Add(conf.fGet('LAZLAP'));
      stlProEmbLa.Add(conf.fGet('LAZLIL'));
      stlProEmbLa.Add(conf.fGet('LAZLCO'));
      stlProEmbLa.Add(conf.fGet('ULTRABASELA'));
      stlProEmbLa.Add(conf.fGet('PUMSLA'));
      stlProEmbLa.Add(conf.fGet('SHERLA'));

      strProEmbCo := conf.fGet('LAZCOP');
      strProEmbSp := conf.fGet('LAZSPR');

      If (Not fDigDadosTintometricos(qryTinta, stlDesEmb, stlProEmbLt,
        stlProEmbGl, stlProEmbLa, strProEmbCo, strProEmbSp,
        strIteEmb, strTipEmb, strTipPre, intQtdEmb, fltPreEmb, fltEmbala,
        fltPreCus, fltUnitar, fltVolPro, strTabPre, dicRetorno)) Then
      Begin
        Exit;
      End;

      strDesCor := Trim(tinta.fGetDescricao(qryTinta.FieldbyName('AUTOINCREM').AsString));
      dicRetorno['unidad'] := fRetUnidadeItem(strIteEmb);

//      fltPrcTin := fltPreCus;

      If blnUsaPreCus Then
        fltUnitar := fltPreCus;

      fltPrvTin := fltUnitar;

      dicRetorno['precus'] := fltPreCus;
      dicRetorno['unitar'] := fltUnitar;
      dicRetorno['fattin'] := fltFatTin;
//      dicRetorno['prctin'] := fltPrcTin;
      dicRetorno['prvtin'] := fltPrvTin;
      dicRetorno['codite'] := conf.fGet('PROLAZ');
      dicRetorno['itetin'] := strIteTin;

      dicRetorno['iteemb'] := strIteEmb;
      dicRetorno['tippre'] := strTipPre;
      dicRetorno['lazqua'] := intLazQua;
      dicRetorno['tipemb'] := strTipEmb;
      dicRetorno['qtdemb'] := intQtdEmb;
      dicRetorno['preemb'] := fltPreEmb;
      dicRetorno['embala'] := fltEmbala;
      dicRetorno['volpro'] := fltVolPro;

      dicRetorno['montad'] := strMontad;
      dicRetorno['a_n_o_'] := strA_n_o_;
      dicRetorno['univer'] := qryTinta.FieldByName('MIX_UNIVER').AsString;
      dicRetorno['chafor'] := fRetornaDescricaoLazzumixDinamica(qryTinta, strDesCor) + strTipEmb;
      dicRetorno['descor'] := strDesCor;
      dicRetorno['desopetinta'] := conf.fGetDouble('DESOPE');

      Result := True;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(stlDesEmb) then FreeAndNil(stlDesEmb);
    if Assigned(stlProEmbLt) then FreeAndNil(stlProEmbLt);
    if Assigned(stlProEmbGl) then FreeAndNil(stlProEmbGl);
    if Assigned(stlProEmbLa) then FreeAndNil(stlProEmbLa);
  End;
end;

function fGTinForLazzumixDinamica(strIteTin: String; fltVolPro: Double; strTipPre: String;
  Var arrFormul: TForMulTinDetArray; Var arrBaixaPigmentos: TBaixaPigmentosArray;
  Var stlItensTraMl: TStringList): Boolean; stdcall;
  Var
    strSQL: String;
    strCamFor: String;
    strCamBas: String;
    intPos: Integer;
    intContador: Integer;

    strBases: String;
    dicBases: TDicionario;
    qryConsulta01: TUniQuery;
    strCamLitrag: String;
begin
  qryConsulta01 := fCriaQuery(Nil);

  dicBases := TDicionario.Create;
  strBases := '';

  Result := True;

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  * ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  LAZ_CADMIX ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  MIX_CODIGO = :ITETIN ';

  With qryConsulta01 Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('ITETIN').AsString := strIteTin;
    Open;

    If (IsEmpty) Then
    Begin
      Close;
      Result := False;
      Exit;
    End;

    For intContador := 1 To 20 Do
    Begin

      strCamFor := 'MIX_BASE' + fStrZero(IntToStr(intContador), 2);

      If strTipPre = 'C' Then
      Begin
        strCamBas    := 'MIX_QTDC' + fStrZero(IntToStr(intContador), 2);
        strCamLitrag := 'MIX_VOLCON';
      End
      Else
      Begin
        strCamBas    := 'MIX_QTDD' + fStrZero(IntToStr(intContador), 2);
        strCamLitrag := 'MIX_VOLDIL';
      End;

      If (FieldByName(strCamBas).AsFloat <= 0) Then
        Break;

      arrFormul[intContador].strFormul := FieldByName(strCamFor).AsString;
      arrFormul[intContador].fltQtdBas := fFormataFloatLaz(FieldByName(strCamBas).AsFloat) * (fltVolPro * 1000) /
                                                    qryConsulta01.FieldByName(strCamLitrag).AsFloat;
      arrFormul[intContador].fltQtdBas := fFormataFloatLaz(arrFormul[intContador].fltQtdBas);

      dicBases[arrFormul[intContador].strFormul] := arrFormul[intContador].fltQtdBas;

      {*******************************************}
      {* GUARDA BASES PARA POSTERIOR BUSCA       *}
      {* DOS ITENS                               *}
      {****************************************MV*}
      strBases := strBases + QuotedStr(arrFormul[intContador].strFormul);
      If (Not fEmptyStr(arrFormul[intContador].strFormul)) Then
        strBases := strBases + ', ';

    End;

    strBases := Trim(strBases);
    If (RightStr(strBases, 1) = ',') Then
      strBases := Copy(strBases, 1, Length(strBases)-1);

  End;

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  BAS_CODBAS, ';
  strSQL := strSQL + '  BAS_CODITE ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  LAZ_CADBAS ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  BAS_CODBAS IN (' + strBases + ') ';

  With qryConsulta01 Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    Open;

    intPos := 0;
    SetLength(arrBaixaPigmentos, RecordCount);

    While (Not Eof) Do
    Begin

      {*******************************************}
      {* ITENS QUE TEM QUE FAZER TRANSFERENCIA   *}
      {* DE SALDO EM ML                          *}
      {****************************************MV*}
      stlItensTraMl.Add(FieldByName('BAS_CODITE').AsString);

      arrBaixaPigmentos[intPos].strCodIte   := FieldByName('BAS_CODITE').AsString;
      arrBaixaPigmentos[intPos].fltQtdBaixa := dicBases[FieldByName('BAS_CODBAS').AsString];
      Inc(intPos);
      Next;
    End;

    Close;
  End;

  FreeAndNil(dicBases);
  FreeAndNil(qryConsulta01);
end;

{ TFormulaLazzumix }

constructor TFormulaLazzumix.Create(strTabPre: String);
  Var
    conf: IConfTinta;
begin
  inherited;
  conf := fGetConfTinta('LAZ');
  fltPerFre := conf.fGetDouble('PERFRE') / 100.0;
  fltPerIpi := conf.fGetDouble('PERIPI') / 100.0;
  fltPerRet := conf.fGetDouble('PERRET') / 100.0;
  fltPerAdi := conf.fGetDouble('PERADC') / 100.0;
  fltPerPer := conf.fGetDouble('PERPER') / 100.0;
  fltMarLuc := conf.fGetDouble('MARLUC') / 100.0;
  fltPerAcr := conf.fGetDouble('APREVE') / 100.0;
end;

function TFormulaLazzumix.GetPrecoEmbalagem: Double;
  Var
    qryAux: TUniQuery;
    conf: IConfTinta;
begin

  Result := 0;
  If (fArqIniTinta(0, 'GERAL', 'PRECO_GERACAO', '0') = '0') Then
  Begin
    conf := fGetConfTinta('LAZ');


    If (tpeTipEmb = teLitro) Then
      Result := conf.fGetDouble('EMBLAZ')

    Else If (tpeTipEmb = teGalao) Then
      Result := conf.fGetDouble('GALLAZ')

    Else If (tpeTipEmb = teCopo) Then
      Result := conf.fGetDouble('COPLAZ')

    Else If (tpeTipEmb = teSpray) Then
      Result := conf.fGetDouble('SPRLAZ')

    Else If (tpeTipEmb = teLata) Then
      Result := conf.fGetDouble('LATLAZ');

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
    qryAux.Open;

    Result := qryAux.FieldByName('ITE_PREVE1').AsFloat;

    FreeAndNil(qryAux);

  End;

  Result := Result + (fltPerAcr * Result);
end;

procedure TFormulaLazzumix.pCalcularPrecos;
var
  intIndex: Integer;
  objBase: TBaseAutomotiva;
  fltPreCusBas: Double;
  fltPreCu2Bas: Double;
  fltPreVenBas: Double;
  fltEmbala: Double;

  fltDesBasCon: Double;
  fltDesBasDil: Double;
  fltDesCamCon: Double;
  fltDesCamDil: Double;

  fltVenBasCon: Double;
  fltVenBasDil: Double;
  componente: array[TModoVenda] of ITintaDeMaquinaComponente;
  fltPreCusPro,
  fltPreVenPro: Double;

  procedure pZerarPrecos;
  begin
    fltDesBasCon := 0.0;
    fltDesBasDil := 0.0;
    fltDesCamCon := 0.0;
    fltDesCamDil := 0.0;

    FPrecoCusCon := 0.0;
    FPrecoCusDil := 0.0;
    FPrecoCu2Con := 0.0;
    FPrecoCu2Dil := 0.0;
    FPrecoVenCon := 0.0;
    FPrecoVenDil := 0.0;

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

    FPreUltCon := 0;
    FPreUltDil := 0;
    FImpUltCon := 0;
    FImpUltDil := 0;

    FComLiqCon := 0;
    FComLiqDil := 0;
  End;
begin
  inherited;

  pZerarPrecos;
  If mveModoVenda = mvConcentrado Then
    FVolumeOri := fltVolumeConcentrado
  Else
    FVolumeOri := fltVolumeDiluido;

  If fltVolumeConcentrado <= 0.0 Then
    fltVolumeConcentrado := 1;

  If fltVolumeDiluido <= 0.0 Then
    fltVolumeDiluido := 1;

  For intIndex := 0 To Count -1 Do
  Begin

    objBase := TBaseAutomotiva(Items[intIndex]);

    If (objBase.fltQtdCon = 0) And (Self.blnTemConcentrado) And (Self.FModoVenda = mvConcentrado) Then
      Continue;

    If (Not qryCadBas.Locate('BAS_CODBAS', objBase.strCodBas, [])) Then
    Begin
      pZerarPrecos;
      Raise Exception.Create('Base ' + objBase.strCodBas + ' não cadastrada. Favor verificar.');
      Exit;
    End;

    If (fEmptyStr(qryCadBas.FieldByName('BAS_CODITE').AsString)) Then
    Begin
      pZerarPrecos;
      Raise Exception.Create('A base ' + objBase.strCodBas + ' não está com o produto para venda associado.' + #13#10 +
                             'Favor verificar.');
      Exit;
    End;

    If (qryCadBas.FieldByName('ITE_CNV_ML').AsFloat <= 0) Then
    Begin
      pZerarPrecos;
      Raise Exception.Create('O produto ' + qryCadBas.FieldByName('BAS_CODITE').AsString + ' não está com o fator tintométrico ' + #13#10 +
                             'preenchido corretamente. Favor verificar.');
      Exit;
    End;

    If (qryCadBas.FieldByName('BAS_PESESP').AsFloat <= 0) Then
    Begin
      pZerarPrecos;
      Raise Exception.Create('A base ' + objBase.strCodBas + ' está com o peso específico zerado.' + #13#10 +
                             'Favor verificar.');
      Exit;
    End;
    
    componente[mvConcentrado] := tintaDeMaquina[mvConcentrado].Localizar(TTintaDeMaquinaComponenteComparerBaseAutomotiva.Create(objBase.strCodBas));
    if not Assigned(componente[mvConcentrado]) then
    begin
      componente[mvConcentrado] := tintaDeMaquina[mvConcentrado].Adicionar(TGenericTintaDeMaquinaComponente.Create(
        objBase.strCodIte, objBase.strCodBas, tmctBaseAutomotiva
      ));
    end;

    componente[mvDiluido] := tintaDeMaquina[mvDiluido].Localizar(TTintaDeMaquinaComponenteComparerBaseAutomotiva.Create(objBase.strCodBas));
    if not Assigned(componente[mvDiluido]) then
    begin
      componente[mvDiluido] := tintaDeMaquina[mvDiluido].Adicionar(TGenericTintaDeMaquinaComponente.Create(
        objBase.strCodIte, objBase.strCodBas, tmctBaseAutomotiva
      ));
    end;
    
    if not IsItemAtivo(qryCadBas.FieldByName('BAS_CODITE').AsString) then
    begin
      pZerarPrecos;
      raise Exception.CreateFmt('O produto %s não está ativo, Favor verificar!', [qryCadBas.FieldByName('BAS_CODITE').AsString]);
    end;

    If fCarregaPromocao(qryCadBas.FieldByName('BAS_CODITE').AsString, fTabPreco, strCodCli, strCodCnd, intPrzMed,
      fltPreCusPro, fltPreVenPro) Then
    Begin
      fltPreCusBas := fltPreCusPro;
      fltPreVenBas := fltPreVenPro;
      FPromoc := 'S';

      If fltPreCusBas = 0 Then
        fltPreCusBas := qryCadBas.FieldByName('ITE_PRECUS').AsFloat;
    End
    Else
    Begin
      fltPreCusBas := qryCadBas.FieldByName('ITE_PRECUS').AsFloat;
      fltPreVenBas := qryCadBas.FieldByName('ITE_PREVEN').AsFloat;
    End;

    fltPreCu2Bas := fCalculaPrecoCusto2(fltPreVenBas,
                                        fltPreCusBas,
                                        objBase.fltOutVal,
                                        objBase.fltIcmSai,
                                        objBase.fltImpFed,
                                        objBase.fltDesOpe);

    fltEmbala    := qryCadBas.FieldByName('BAS_EMBALA').AsFloat * qryCadBas.FieldByName('BAS_PESESP').AsFloat;

//    fltVenBasCon := (objBase.fltQtdCon * fltPreVenBas / fltEmbala) * (FVolumePro{ * 1000 }/ fltVolumeConcentrado);
//    fltVenBasDil := (objBase.fltQtdDil * fltPreVenBas / fltEmbala) * (FVolumePro{ * 1000 }/ fltVolumeDiluido);

    componente[mvConcentrado].Quantidade := fFormataFloatLaz((objBase.fltQtdCon * FVolumePro / fltVolumeConcentrado));
    componente[mvDiluido].Quantidade := fFormataFloatLaz((objBase.fltQtdDil * FVolumePro / fltVolumeDiluido));

    fltVenBasCon := (componente[mvConcentrado].Quantidade * fltPreVenBas / fltEmbala);
    fltVenBasDil := (componente[mvDiluido].Quantidade * fltPreVenBas / fltEmbala);

    componente[mvConcentrado].OutrosValores := (objBase.fltQtdCon * objBase.fltOutVal / fltEmbala) * (FVolumePro{ * 1000 }/ fltVolumeConcentrado);
    componente[mvDiluido].OutrosValores := (objBase.fltQtdDil * objBase.fltOutVal / fltEmbala) * (FVolumePro{ * 1000 }/ fltVolumeDiluido);

    componente[mvConcentrado].IcmsSaida := fltVenBasCon * objBase.fltIcmSai / 100;
    componente[mvDiluido].IcmsSaida := fltVenBasDil * objBase.fltIcmSai / 100;

    componente[mvConcentrado].ImpostosFederais := fltVenBasCon * objBase.fltImpFed / 100;
    componente[mvDiluido].ImpostosFederais := fltVenBasDil * objBase.fltImpFed / 100;

    componente[mvConcentrado].DespesasOperacionais := fltVenBasCon * objBase.fltDesOpe / 100;
    componente[mvDiluido].DespesasOperacionais := fltVenBasDil * objBase.fltDesOpe / 100;

    componente[mvConcentrado].PrecoMedio := (objBase.fltQtdCon * objBase.fltPreMed / fltEmbala) * (FVolumePro{ * 1000 }/ fltVolumeConcentrado);
    componente[mvDiluido].PrecoMedio := (objBase.fltQtdDil * objBase.fltPreMed / fltEmbala) * (FVolumePro{ * 1000 }/ fltVolumeDiluido);

//    componente[mvConcentrado].PrecoCusto := (objBase.fltQtdCon * fltPreCusBas / fltEmbala) * (FVolumePro{ * 1000 }/ fltVolumeConcentrado);
//    componente[mvDiluido].PrecoCusto := (objBase.fltQtdDil * fltPreCusBas / fltEmbala) * (FVolumePro{ * 1000 }/ fltVolumeDiluido);

    componente[mvConcentrado].PrecoCusto := (componente[mvConcentrado].Quantidade * fltPreCusBas / fltEmbala);
    componente[mvDiluido].PrecoCusto := (componente[mvDiluido].Quantidade * fltPreCusBas / fltEmbala);

    componente[mvConcentrado].PrecoCustoReal := (objBase.fltQtdCon * fltPreCu2Bas / fltEmbala) * (FVolumePro{ * 1000 }/ fltVolumeConcentrado);
    componente[mvDiluido].PrecoCustoReal := (objBase.fltQtdDil * fltPreCu2Bas / fltEmbala) * (FVolumePro{ * 1000 }/ fltVolumeDiluido);

    componente[mvConcentrado].UltimoPrecoCompra := (objBase.fltQtdCon * objBase.fltPreUlt / fltEmbala) * (FVolumePro / fltVolumeConcentrado);
    componente[mvDiluido].UltimoPrecoCompra :=     (objBase.fltQtdDil * objBase.fltPreUlt / fltEmbala) * (FVolumePro / fltVolumeDiluido);

    componente[mvConcentrado].UltimoPrecoCompraImpostos := (objBase.fltQtdCon * objBase.fltImpUlt / fltEmbala) * (FVolumePro / fltVolumeConcentrado);
    componente[mvDiluido].UltimoPrecoCompraImpostos := (objBase.fltQtdDil * objBase.fltImpUlt / fltEmbala) * (FVolumePro / fltVolumeDiluido);

//    componente[mvConcentrado].PrecoCompraLiquido := (objBase.fltQtdCon * objBase.fltComLiq / fltEmbala) * (FVolumePro / fltVolumeConcentrado);
//    componente[mvDiluido].PrecoCompraLiquido := (objBase.fltQtdDil * objBase.fltComLiq / fltEmbala) * (FVolumePro / fltVolumeDiluido);

    componente[mvConcentrado].PrecoCompraLiquido := (componente[mvConcentrado].Quantidade * objBase.fltComLiq / fltEmbala);
    componente[mvDiluido].PrecoCompraLiquido := (componente[mvDiluido].Quantidade * objBase.fltComLiq / fltEmbala);

    componente[mvConcentrado].PrecoVenda := fltVenBasCon -
      (fltVenBasCon * qryCadBas.FieldByName('BAS_DESCON').AsFloat / 100) -
      (fltVenBasCon * qryCadBas.FieldByName('BAS_DESCAM').AsFloat / 100);

    componente[mvDiluido].PrecoVenda := fltVenBasDil -
      (fltVenBasDil * qryCadBas.FieldByName('BAS_DESCON').AsFloat / 100) -
      (fltVenBasDil * qryCadBas.FieldByName('BAS_DESCAM').AsFloat / 100);

    componente[mvConcentrado].PrecoVenda := componente[mvConcentrado].PrecoVenda +
      (fltPerFre * componente[mvConcentrado].PrecoVenda);

    componente[mvDiluido].PrecoVenda := componente[mvDiluido].PrecoVenda +
      (fltPerFre * componente[mvDiluido].PrecoVenda);

    componente[mvConcentrado].PrecoVenda := componente[mvConcentrado].PrecoVenda +
      (fltPerIpi * componente[mvConcentrado].PrecoVenda);

    componente[mvDiluido].PrecoVenda := componente[mvDiluido].PrecoVenda +
      (fltPerIpi * componente[mvDiluido].PrecoVenda);

    componente[mvConcentrado].PrecoVenda := componente[mvConcentrado].PrecoVenda +
      (fltPerRet * componente[mvConcentrado].PrecoVenda);

    componente[mvDiluido].PrecoVenda := componente[mvDiluido].PrecoVenda +
      (fltPerRet * componente[mvDiluido].PrecoVenda);

    componente[mvConcentrado].PrecoVenda := componente[mvConcentrado].PrecoVenda +
      (fltPerAdi * componente[mvConcentrado].PrecoVenda);

    componente[mvDiluido].PrecoVenda := componente[mvDiluido].PrecoVenda +
      (fltPerAdi * componente[mvDiluido].PrecoVenda);

    componente[mvConcentrado].PrecoVenda := componente[mvConcentrado].PrecoVenda +
      (fltPerPer * componente[mvConcentrado].PrecoVenda);

    componente[mvDiluido].PrecoVenda := componente[mvDiluido].PrecoVenda +
      (fltPerPer * componente[mvDiluido].PrecoVenda);

    componente[mvConcentrado].PrecoVenda := componente[mvConcentrado].PrecoVenda +
      (fltMarLuc * componente[mvConcentrado].PrecoVenda);

    componente[mvDiluido].PrecoVenda := componente[mvDiluido].PrecoVenda +
      (fltMarLuc * componente[mvDiluido].PrecoVenda);

    componente[mvConcentrado].PrecoVenda := componente[mvConcentrado].PrecoVenda +
      (fltPerAcr * componente[mvConcentrado].PrecoVenda);

    componente[mvDiluido].PrecoVenda := componente[mvDiluido].PrecoVenda +
      (fltPerAcr * componente[mvDiluido].PrecoVenda);
  End;

  FOutValCon := tintaDeMaquina[mvConcentrado].GetOutrosValoresComponentes;
  FOutValDil := tintaDeMaquina[mvDiluido].GetOutrosValoresComponentes;

  FIcmsaiCon := tintaDeMaquina[mvConcentrado].GetIcmsSaidaComponentes;
  FIcmsaiDil := tintaDeMaquina[mvDiluido].GetIcmsSaidaComponentes;

  FImpFedCon := tintaDeMaquina[mvConcentrado].GetImpostosFederaisComponentes;
  FImpFedDil := tintaDeMaquina[mvDiluido].GetImpostosFederaisComponentes;

  FDesOpeCon := tintaDeMaquina[mvConcentrado].GetDespesasOperacionaisComponentes;
  FDesOpeDil := tintaDeMaquina[mvDiluido].GetDespesasOperacionaisComponentes;

  FPreMedCon := tintaDeMaquina[mvConcentrado].GetPrecoMedioComponentes;
  FPreMedDil := tintaDeMaquina[mvDiluido].GetPrecoMedioComponentes;

  FPrecoCusCon := tintaDeMaquina[mvConcentrado].GetPrecoCustoComponentes;
  FPrecoCusDil := tintaDeMaquina[mvDiluido].GetPrecoCustoComponentes;

  FPrecoCu2Con := tintaDeMaquina[mvConcentrado].GetPrecoCustoRealComponentes;
  FPrecoCu2Dil := tintaDeMaquina[mvDiluido].GetPrecoCustoRealComponentes;

  FPrecoVenCon := tintaDeMaquina[mvConcentrado].GetPrecoVendaComponentes;
  FPrecoVenDil := tintaDeMaquina[mvDiluido].GetPrecoVendaComponentes;

  FPreUltCon := tintaDeMaquina[mvConcentrado].GetUltimoPrecoCompraComponentes;
  FPreUltDil := tintaDeMaquina[mvDiluido].GetUltimoPrecoCompraComponentes;
  FImpUltCon := tintaDeMaquina[mvConcentrado].GetUltimoPrecoCompraImpostosComponentes;
  FImpUltDil := tintaDeMaquina[mvDiluido].GetUltimoPrecoCompraImpostosComponentes;

  FComLiqCon := tintaDeMaquina[mvConcentrado].GetPrecoCompraLiquidoComponentes;
  FComLiqDil := tintaDeMaquina[mvDiluido].GetPrecoCompraLiquidoComponentes;  
end;

procedure TFormulaLazzumix.pCarregaPrecosBases;
  Var
    intContador: Integer;
    objBase: TBaseAutomotiva;

    conf: IConfTinta;
    fltDesOpeTinta: Double;
    fltPreCusPro,
    fltPreVenPro: Double;
begin

  inherited;
  conf := fGetConfTinta('LAZ');
  fltDesOpeTinta := conf.fGetDouble('DESOPE');

  For intContador := 0 To Self.Count-1 Do
  Begin
    objBase := TBaseAutomotiva(Self.Items[intContador]);
    qryCadBas.Locate('BAS_CODBAS', objBase.strCodBas, []);

    objBase.fltEmbala := qryCadBas.FieldByName('BAS_EMBALA').AsFloat * qryCadBas.FieldByName('BAS_PESESP').AsFloat;

    If fCarregaPromocao(qryCadBas.FieldByName('BAS_CODITE').AsString, fTabPreco, strCodCli, strCodCnd, intPrzMed,
      fltPreCusPro, fltPreVenPro) Then
    Begin
      objBase.fltPreVen := fltPreVenPro;
      FPromoc := 'S';
    End
    Else
    Begin
      objBase.fltPreVen := qryCadBas.FieldByName('ITE_PREVEN').AsFloat;
    End;

    objBase.strImpDir := qryCadBas.FieldByName('ITE_IMPDIR').AsString;
    objBase.strCodIte := qryCadBas.FieldByName('BAS_CODITE').AsString;

    objBase.fltOutVal := qryCadBas.FieldByName('ITE_OUTVAL').AsFloat;

    if fCfgSis('IMPCF4', varBoolean) and Assigned(calculadorFatVendas) then
      objBase.fltIcmSai := calculadorFatVendas.fCalculaAliquota(objBase.strCodIte, objBase.strImpDir)
    else
      objBase.fltIcmSai := qryCadBas.FieldByName('ITE_ICMSAI').AsFloat;

    objBase.fltImpFed := qryCadBas.FieldByName('ITE_IMPFED').AsFloat;
    objBase.fltDesOpe := qryCadBas.FieldByName('ITE_DESOPE').AsFloat + fltDesOpeTinta;
    objBase.fltPesEsp := qryCadBas.FieldByName('BAS_PESESP').AsFloat;
    objBase.fltPreMed := qryCadBas.FieldByName('ITE_PREMED').AsFloat;
    objBase.fltPreUlt := qryCadBas.FieldByName('ITE_PREULT').AsFloat;
    objBase.fltImpUlt := qryCadBas.FieldByName('ITE_IMPULT').AsFloat;

    objBase.fltComLiq := fFormataFloat(fCalculaPrecoCompraLiq(qryCadBas.Fieldbyname('ITE_PRECOM').AsFloat, qryCadBas.Fieldbyname('ITE_DESF01').AsFloat,
                                                              qryCadBas.Fieldbyname('ITE_DESF02').AsFloat, qryCadBas.Fieldbyname('ITE_DESF03').AsFloat,
                                                              qryCadBas.Fieldbyname('ITE_DESF04').AsFloat, qryCadBas.Fieldbyname('ITE_DESF05').AsFloat,
                                                              qryCadBas.Fieldbyname('ITE_DESF06').AsFloat), fCfgSis('DECUNI', VarInteger));
  End;

  FCalculo.Add('VolumeConcentrado = ' + FloatToStrF(fltVolumeConcentrado, ffFixed, 12, 4));
  FCalculo.Add('VolumeDiluido = ' + FloatToStrF(fltVolumeDiluido, ffFixed, 12, 4));
  FCalculo.Add('');
  FCalculo.Add('VolumeFormula = SE CONCENTRADO VolumeConcentrado SENÃO VolumeDiluido');
  FCalculo.Add('');
  FCalculo.Add('Valor da Base = (Qtde * Valor / Embalagem) * (VolumeDigitado * 1000 / VolumeFormula)');
  FCalculo.Add('Desconto Base = Valor da Base * DescontoBase (*) ');
  FCalculo.Add('Desconto Campanha = Valor da Base * DescontoCampanha (*) ');
  FCalculo.Add('');
  FCalculo.Add('Preço da Tinta = soma do Valor da Base de todas as bases.');
  FCalculo.Add('Preço da Tinta = Preço da Tinta - Soma(Desconto Base) - Soma(Desconto Campanha) ');
  FCalculo.Add('Preço da Tinta = Preço da Tinta + %Frete ');
  FCalculo.Add('Preço da Tinta = Preço da Tinta + %IPI ');
  FCalculo.Add('Preço da Tinta = Preço da Tinta + %Retido ');
  FCalculo.Add('Preço da Tinta = Preço da Tinta + %Adicionais ');
  FCalculo.Add('Preço da Tinta = Preço da Tinta + %Perda ');
  FCalculo.Add('Preço da Tinta = Preço da Tinta + %Lucro ');
  FCalculo.Add('');
  FCalculo.Add('(*) Por questões de compatibilidade com outras tintas, não foram');
  FCalculo.Add('    acrescentadas as colunas DescontoBase e DescontoCapanha.    ');
  FCalculo.Add('    Favor olhar no cadastro de bases ');

end;

procedure TFormulaLazzumix.pCarregarColorantes;
begin
  inherited;
  qryCadBas.SQL.Clear;
  qryCadBas.SQL.Add(' SELECT                               ');
  qryCadBas.SQL.Add('   BAS_CODBAS                         ');
  qryCadBas.SQL.Add('   , BAS_CODITE                       ');
  qryCadBas.SQL.Add('   , BAS_EMBALA                       ');
  qryCadBas.SQL.Add('   , BAS_PESESP                       ');
  qryCadBas.SQL.Add('   , BAS_DESCON                       ');
  qryCadBas.SQL.Add('   , BAS_DESCAM                       ');
  qryCadBas.SQL.Add('   , ITE_CNV_ML                       ');
  qryCadBas.SQL.Add('   , ITE_PREULT                       ');
  qryCadBas.SQL.Add('   , ITE_IMPULT                       ');

  qryCadBas.SQL.Add('   , ITE_PRECOM                       ');
  qryCadBas.SQL.Add('   , ITE_DESF01                       ');
  qryCadBas.SQL.Add('   , ITE_DESF02                       ');
  qryCadBas.SQL.Add('   , ITE_DESF03                       ');
  qryCadBas.SQL.Add('   , ITE_DESF04                       ');
  qryCadBas.SQL.Add('   , ITE_DESF05                       ');
  qryCadBas.SQL.Add('   , ITE_DESF06                       ');

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
  qryCadBas.SQL.Add('   LAZ_CADBAS                         ');
  qryCadBas.SQL.Add('   INNER JOIN ITEGER G                ');
  qryCadBas.SQL.Add('     ON BAS_CODITE = G.ITE_CODITE     ');
  qryCadBas.SQL.Add('   INNER JOIN CADITE I                ');
  qryCadBas.SQL.Add('     ON G.ITE_CODITE = I.ITE_CODITE   ');
  qryCadBas.SQL.Add(' WHERE G.ITE_CODEMP = :CODEMP         ');

  qryCadBas.ParamByName('CODEMP').AsString := VS_strCodEmp;
  qryCadBas.Open;
end;

function fDigDadosTintometricos(qryCadMix: TUniQuery; stlDesEmb, stlProEmbLt,
  stlProEmbGl: TStringList; stlProEmbLa: TStringList; strProEmbCo, strProEmbSp: String;
  Var strIteEmb, strTipEmb, strTipPre: String;
  Var intQtdEmb: Integer; Var fltPreEmb, fltEmbala, fltPreCus, fltPreVen,
  fltVolPro: Double; strTabPre: String; dicRetorno: TDicionario): Boolean;
var
  objBase: TBaseAutomotiva;
  objFormula: TFormulaLazzumix;
  intContador: Integer;
  intIndEmb: Integer;
  fltPreCu2: Double;
  calculadorFatVendas: ICalculadorFatVendas;
  conf: IConfTinta;
Begin
  Result := False;
  frmDigTintaAutomotiva := nil;
  objFormula := nil;
  conf := fGetConfTinta('LAZ');
  Try
    Try
      if not Supports(dicRetorno.RetornaObjeto('calculadorFatVendas'), ICalculadorFatVendas, calculadorFatVendas) then
        calculadorFatVendas := nil;

      objFormula := TFormulaLazzumix.Create(strTabPre);
      objFormula.calculadorFatVendas := calculadorFatVendas;

      objFormula.strOpcDoc := IfNull(dicRetorno['opcdoc'], '');
      objFormula.strCodCli := IfNull(dicRetorno['codcli'], '');
      objFormula.strCodCnd := IfNull(dicRetorno['codcnd'], '');
      objFormula.intPrzMed := IfNull(dicRetorno['przmed'], 0);

      objFormula.fltVolumeOri         := qryCadMix.FieldByName('MIX_VOLCON').AsFloat / 1000;
      objFormula.fltVolumeConcentrado := qryCadMix.FieldByName('MIX_VOLCON').AsFloat / 1000;
      objFormula.fltVolumeDiluido     := qryCadMix.FieldByName('MIX_VOLDIL').AsFloat / 1000;
      objFormula.strDescri            := qryCadMix.FieldByName('MIX_DESCRI').AsString + ' - ' +
                                         qryCadMix.FieldByName('MIX_CODIGO').AsString;

      intIndEmb := -1;
      If qryCadMix.FieldByName('MIX_REFERE').AsString = 'LAZZURIL' Then
        intIndEmb := 0
      Else If qryCadMix.FieldByName('MIX_REFERE').AsString = 'LAZZULAC' Then
        intIndEmb := 1
      Else If qryCadMix.FieldByName('MIX_REFERE').AsString = 'LAZZUDUR' Then
        intIndEmb := 2
      Else If qryCadMix.FieldByName('MIX_REFERE').AsString = 'POLIURETANO' Then
        intIndEmb := 3
      Else If qryCadMix.FieldByName('MIX_REFERE').AsString = 'LAZZUCRIL' Then
        intIndEmb := 4
      Else If qryCadMix.FieldByName('MIX_REFERE').AsString = 'FLEET COLOR' Then
        intIndEmb := 5
      Else If qryCadMix.FieldByName('MIX_REFERE').AsString = 'ULTRABASE' Then
        intIndEmb := 6
      Else If qryCadMix.FieldByName('MIX_REFERE').AsString = 'LAZZUDUR PU MS' Then
        intIndEmb := 7
      Else If (Pos('SHERTRUCKMIX', qryCadMix.FieldByName('MIX_REFERE').AsString) > 0) Then
        intIndEmb := 8;

      For intContador := 1 To 20 Do
      Begin

        If (fEmptyStr(qryCadMix.FieldByName('MIX_BASE' + fStrZero(intContador, 2)).AsString)) Then
          Break;

        objBase := TBaseAutomotiva(objFormula.Add);
        objBase.strIdePro := 'LAZ';
        objBase.strCodBas := qryCadMix.FieldByName('MIX_BASE' + fStrZero(intContador, 2)).AsString;
        objBase.fltQtdCon := fFormataFloatLaz(qryCadMix.FieldByName('MIX_QTDC' + fStrZero(intContador, 2)).AsFloat);
        objBase.fltQtdDil := fFormataFloatLaz(qryCadMix.FieldByName('MIX_QTDD' + fStrZero(intContador, 2)).AsFloat);
        objBase.strTipBas := 'B';
      End;

      objFormula.pCarregaPrecosBases;

      Application.CreateForm(TfrmDigTintaAutomotiva, frmDigTintaAutomotiva);
      objFormula.strCodEmpEst := IfNull(dicRetorno['codemp'], VS_strCodEmp);
      frmDigTintaAutomotiva.objFormula  := objFormula;
      frmDigTintaAutomotiva.stlDesEmb   := stlDesEmb;
      frmDigTintaAutomotiva.stlProEmbLt := stlProEmbLt;
      frmDigTintaAutomotiva.stlProEmbGl := stlProEmbGl;
      frmDigTintaAutomotiva.stlProEmbLa := stlProEmbLa;      
      frmDigTintaAutomotiva.strProEmbCo := strProEmbCo;
      frmDigTintaAutomotiva.strProEmbSp := strProEmbSp;

      frmDigTintaAutomotiva.Caption     := frmDigTintaAutomotiva.Caption + 'Lazzumix';
      frmDigTintaAutomotiva.chkComCat.Visible := False;

      // Volume minímo permitido (C - Concentrado, D - Diluído).
      frmDigTintaAutomotiva.fltMixVolMiC               := qryCadMix.FieldByName('MIX_VOLMIC').AsFloat;
      frmDigTintaAutomotiva.fltMixVolMiD               := qryCadMix.FieldByName('MIX_VOLMID').AsFloat;


      frmDigTintaAutomotiva.strIdePro   := dicRetorno['idepro'];
      frmDigTintaAutomotiva.fltVolumePadraoSpray := 0.100;

      frmDigTintaAutomotiva.intIndEmb := intIndEmb;

      Result := (frmDigTintaAutomotiva.ShowModal = mrOk)
        and fValidaVolumeFormulucao(IIF(frmDigTintaAutomotiva.rdgModoVenda.ItemIndex = 0, 'C', 'D'),
                                         qryCadMix.FieldByName('MIX_VOLCON').AsFloat,
                                         qryCadMix.FieldByName('MIX_VOLDIL').AsFloat);

      If (Result) Then
      Begin
        strIteEmb := frmDigTintaAutomotiva.objFormula.strCodEmb;
        strTipEmb := IIF(frmDigTintaAutomotiva.objFormula.tpeTipEmb in [teLitro, teCopo, teSpray], 'LT', 'GL');
        strTipPre := IIF(frmDigTintaAutomotiva.rdgModoVenda.ItemIndex = 0, 'C', 'D');
        intQtdEmb := StrToIntDef(frmDigTintaAutomotiva.edtQtdEmb.Text, 0);
        fltPreEmb := frmDigTintaAutomotiva.objFormula.fltPrecoEmbalagem;
        fltEmbala := IIF(frmDigTintaAutomotiva.objFormula.tpeTipEmb in [teLitro, teCopo, teSpray], 0.900, 3.600);

        If (frmDigTintaAutomotiva.rdgModoVenda.ItemIndex = 0) Then
        Begin
          fltPreCus := frmDigTintaAutomotiva.objFormula.fltPrecoCusCon;
          fltPreCu2 := frmDigTintaAutomotiva.objFormula.fltPrecoCu2Con;
          fltPreVen := frmDigTintaAutomotiva.objFormula.fltPrecoVenCon;
        End
        Else
        Begin
          fltPreCus := frmDigTintaAutomotiva.objFormula.fltPrecoCusDil;
          fltPreCu2 := frmDigTintaAutomotiva.objFormula.fltPrecoCu2Dil;
          fltPreVen := frmDigTintaAutomotiva.objFormula.fltPrecoVenDil;
        End;

        dicRetorno['premed'] := IfThen(frmDigTintaAutomotiva.rdgModoVenda.ItemIndex = 0,
          frmDigTintaAutomotiva.objFormula.fltPreMedCon,
          frmDigTintaAutomotiva.objFormula.fltPreMedDil) +
          frmDigTintaAutomotiva.objFormula.fltPrecoMedioEmbalagem;

        dicRetorno['impult'] := IfThen(frmDigTintaAutomotiva.rdgModoVenda.ItemIndex = 0,
          frmDigTintaAutomotiva.objFormula.fltImpUltCon,
          frmDigTintaAutomotiva.objFormula.fltImpUltDil) +
          frmDigTintaAutomotiva.objFormula.fltUltimoImpostoEmbalagem;

        dicRetorno['preult'] := IfThen(frmDigTintaAutomotiva.rdgModoVenda.ItemIndex = 0,
          frmDigTintaAutomotiva.objFormula.fltPreUltCon,
          frmDigTintaAutomotiva.objFormula.fltPreUltDil) +
          frmDigTintaAutomotiva.objFormula.fltPreUltEmbalagem;

        dicRetorno['prctin'] := IfThen(frmDigTintaAutomotiva.rdgModoVenda.ItemIndex = 0,
          frmDigTintaAutomotiva.objFormula.fltComLiqCon,
          frmDigTintaAutomotiva.objFormula.fltComLiqDil) +
          frmDigTintaAutomotiva.objFormula.fltPrecoCompraLiquidoEmbalagem;
          
        fltPreCus := fltPreCus + frmDigTintaAutomotiva.objFormula.fltPrecoCustoEmbalagem;
        fltPreCu2 := fltPreCu2 + frmDigTintaAutomotiva.objFormula.fltPrecoCusto2Embalagem;
        fltPreVen := fltPreVen + fltPreEmb;

        fltVolPro := frmDigTintaAutomotiva.objFormula.fltVolumePro;

        dicRetorno['precus'] := fltPreCus;
        dicRetorno['precu2'] := fltPreCu2;
        dicRetorno['tippre'] := strTipPre;
        dicRetorno['desopetinta'] := conf.fGetDouble('DESOPE');
        dicRetorno['promoc']      := frmDigTintaAutomotiva.objFormula.StrPromoc;

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

procedure pRetornaDadosLazzumixDinamica(strIteTin: String; dicRetorno: TDicionario);
  Var
    strSQL: String;
    qryCadMix: TUniQuery;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  * ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  LAZ_CADMIX ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  MIX_CODIGO = :ITETIN ';

  qryCadMix := fCriaQuery(Nil);

  With qryCadMix Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('ITETIN').AsString := strIteTin;
    Open;
    dicRetorno['codtin'] := qryCadMix.FieldByName('MIX_CODIGO').AsString;
    dicRetorno['montad'] := qryCadMix.FieldByName('MIX_MONTAD').AsString;
    dicRetorno['martin'] := qryCadMix.FieldByName('MIX_REFERE').AsString;
    Close;
  End;

  FreeAndNil(qryCadMix);
end;

procedure pRetornaTabelaPrecoLazzumix(dicRetorno: TDicionario; fltFatorAcerto: Double);
var
  strTabelas: String;
  objFormula: TFormulaLazzumix;
  objBase: TBaseAutomotiva;
  intContador: Integer;
  calculadorFatVendas: ICalculadorFatVendas;
  conf: IConfTinta;
begin
  conf := fGetConfTinta('LAZ');
  objFormula := nil;
  Try
    Try
      if not Supports(dicRetorno.RetornaObjeto('calculadorFatVendas'), ICalculadorFatVendas, calculadorFatVendas) then
        calculadorFatVendas := nil;
            
      objFormula := TFormulaLazzumix.Create('1');
      objFormula.blnCalculaUnitario := False;
      objFormula.calculadorFatVendas := calculadorFatVendas;
      objFormula.fltVolumeOri         := 1;
      objFormula.fltVolumeConcentrado := 1;
      objFormula.fltVolumeDiluido     := 1;
      objFormula.fltVolumePro         := 1; //dicRetorno['volpro'];
      objFormula.mveModoVenda         := mvConcentrado;
      objFormula.fltFatorAcerto       := fltFatorAcerto;

      objFormula.strOpcDoc := IfNull(dicRetorno['opcdoc'], '');
      objFormula.strCodCli := IfNull(dicRetorno['codcli'], '');
      objFormula.strCodCnd := IfNull(dicRetorno['codcnd'], '');
      objFormula.intPrzMed := IfNull(dicRetorno['przmed'], 0);

      objFormula.strCodEmb := dicRetorno['iteemb'];

      For intContador := 1 To 20 Do
      Begin

        If (fEmptyStr(IfNull(dicRetorno['base' + fStrZero(intContador, 2)], ''))) Then
          Break;

        objBase := TBaseAutomotiva(objFormula.Add);
        objBase.strCodBas := dicRetorno['base' + fStrZero(intContador, 2)];
        If dicRetorno['tippre'] = 'C' Then
          objBase.fltQtdCon := fFormataFloat(dicRetorno['qtdb' + fStrZero(intContador, 2)], 3)
        Else
          objBase.fltQtdDil := fFormataFloat(dicRetorno['qtdb' + fStrZero(intContador, 2)], 3);
        objBase.strTipBas := 'B';
      End;

      dicRetorno['desopetinta'] := conf.fGetDouble('DESOPE');

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
          Begin
            If dicRetorno['tippre'] = 'C' Then
              dicRetorno['precus'] := objFormula.fltPrecoCusCon + objFormula.fltPrecoCustoEmbalagem
            Else
              dicRetorno['precus'] := objFormula.fltPrecoCusDil + objFormula.fltPrecoCustoEmbalagem;
          End;

          If dicRetorno['tippre'] = 'C' Then
          Begin
            dicRetorno['precu2'] := objFormula.fltPrecoCu2Con + objFormula.fltPrecoCusto2Embalagem;
            dicRetorno['preve' + IntToStr(intContador)] := objFormula.fltPrecoVenCon + objFormula.fltPrecoEmbalagem;
          End
          Else
          Begin
            dicRetorno['precu2'] := objFormula.fltPrecoCu2Dil + objFormula.fltPrecoCusto2Embalagem;
            dicRetorno['preve' + IntToStr(intContador)] := objFormula.fltPrecoVenDil + objFormula.fltPrecoEmbalagem;
          End;

          if intContador = IfNull(dicRetorno['tabpre'], 0) then
          begin
            objFormula.pCalculaImpostosSaida(dicRetorno);
            dicRetorno.AdicionarObjeto('tintaDeMaquina', objFormula.tintaDeMaquina[objFormula.mveModoVenda]);

            If dicRetorno['tippre'] = 'C' Then
            Begin
              dicRetorno['impult'] := objFormula.fltImpUltCon + objFormula.fltUltimoImpostoEmbalagem;
              dicRetorno['preult'] := objFormula.fltPreUltCon + objFormula.fltPreUltEmbalagem;
              dicRetorno['premed'] := objFormula.fltPreMedCon + objFormula.fltPrecoMedioEmbalagem;
              dicRetorno['prctin'] := objFormula.fltComLiqCon + objFormula.fltPrecoCompraLiquidoEmbalagem;
            End
            Else
            Begin
              dicRetorno['impult'] := objFormula.fltImpUltDil + objFormula.fltUltimoImpostoEmbalagem;
              dicRetorno['preult'] := objFormula.fltPreUltDil + objFormula.fltPreUltEmbalagem;
              dicRetorno['premed'] := objFormula.fltPreMedDil + objFormula.fltPrecoMedioEmbalagem;
              dicRetorno['prctin'] := objFormula.fltComLiqDil + objFormula.fltPrecoCompraLiquidoEmbalagem;              
            end;
          end;
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

{ TfrmConsultaCompTintaLazzumix }

procedure TfrmConsultaCompTintaLazzumix.pTarefaFormulacao(Sender: TObject);
var
  qryGen: TUniQuery;
  {*******************************************}
  {* PARAMETROS                              *}
  {****************************************MV*}

  strTipPre: String;
  strTipEmb: String;
  intQtdEmb: Integer;
  strIteTin: String;
  fltPreEmb: Double;
  fltEmbala: Double;
  fltPreCus: Double;
  fltUnitar: Double;
  strIteEmb: String;

  strMontad: String;
  strA_n_o_: String;

  stlDesEmb: TStringList;
  stlProEmbLt: TStringList;
  stlProEmbGl: TStringList;
  stlProEmbLa: TStringList;  
  strProEmbCo: String;
  strProEmbSp: String;
  fltVolPro: Double;
  conf: IConfTinta;
  dicParams: TDicionario;
begin
  qryGen := nil;
  dicParams := nil;
  stlDesEmb := nil;
  stlProEmbLt := nil;
  stlProEmbGl := nil;
  stlProEmbLa := nil;  
  Try
    Try
      If (Not qryConsulta.Active) Or (qryConsulta.IsEmpty) Then
        Exit;

      conf := fGetConfTinta('LAZ');
      stlDesEmb := TStringList.Create;
      stlProEmbLt := TStringList.Create;
      stlProEmbGl := TStringList.Create;
      stlProEmbLa := TStringList.Create;      

      strIteTin := '';
      fltPreCus := 0.0;
      fltUnitar := 0.0;


      strTipPre := '';
      strTipEmb := '';
      intQtdEmb := 0;
      fltPreEmb := 0.0;
      fltEmbala := 0.0;

      qryGen := fCriaQuery(Self);
      qryGen.SQL.Add('SELECT * FROM LAZ_CADMIX WHERE AUTOINCREM = :AUTINC');
      qryGen.ParamByName('AUTINC').AsString := qryConsulta.FieldByName('AUTOINCREM').AsString;
      qryGen.Open;

      strIteTin := qryGen.FieldByName('MIX_CODIGO').AsString;
      strMontad := qryGen.FieldByName('MIX_MONTAD').AsString;
      strA_n_o_ := qryGen.FieldByName('MIX_A_N_O_').AsString;

      stlDesEmb.Add('LAZZURIL');
      stlDesEmb.Add('LAZZULAC');
      stlDesEmb.Add('LAZZUDUR');
      stlDesEmb.Add('P. U.');
      stlDesEmb.Add('LAZZUCRIL');
      stlDesEmb.Add('FLEET COLOR');
      stlDesEmb.Add('ULTRABASE');
      stlDesEmb.Add('LAZZUDUR PU MS');
      stlDesEmb.Add('SHERTRUCKMIX');

      stlProEmbLt.Add(conf.fGet('LAZIEM'));
      stlProEmbLt.Add(conf.fGet('LAZLLA'));
      stlProEmbLt.Add(conf.fGet('LAZLPO'));
      stlProEmbLt.Add(conf.fGet('LAZLPU'));
      stlProEmbLt.Add(conf.fGet('LAZLCR'));
      stlProEmbLt.Add(conf.fGet('LAZLFL'));
      stlProEmbLt.Add(conf.fGet('ULTRABASELT'));
      stlProEmbLt.Add(conf.fGet('PUMSLT'));
      stlProEmbLt.Add(conf.fGet('SHERLT'));

      stlProEmbGl.Add(conf.fGet('LAZIGL'));
      stlProEmbGl.Add(conf.fGet('LAZGLA'));
      stlProEmbGl.Add(conf.fGet('LAZGPO'));
      stlProEmbGl.Add(conf.fGet('LAZGPU'));
      stlProEmbGl.Add(conf.fGet('LAZGCR'));
      stlProEmbGl.Add(conf.fGet('LAZGFL'));
      stlProEmbGl.Add(conf.fGet('ULTRABASEGL'));
      stlProEmbGl.Add(conf.fGet('PUMSGL'));
      stlProEmbGl.Add(conf.fGet('SHERGL'));

      stlProEmbLa.Add(conf.fGet('LAZILA'));
      stlProEmbLa.Add(conf.fGet('LAZLAZ'));
      stlProEmbLa.Add(conf.fGet('LAZLDU'));
      stlProEmbLa.Add(conf.fGet('LAZLAP'));
      stlProEmbLa.Add(conf.fGet('LAZLIL'));
      stlProEmbLa.Add(conf.fGet('LAZLCO'));
      stlProEmbLa.Add(conf.fGet('ULTRABASELA'));
      stlProEmbLa.Add(conf.fGet('PUMSLA'));
      stlProEmbLa.Add(conf.fGet('SHERLA'));

      strProEmbCo := conf.fGet('LAZCOP');

      strProEmbSp := conf.fGet('LAZSPR');

      dicParams := TDicionario.Create;
      dicParams['idepro'] := 'LAZ';

      If (Not fDigDadosTintometricos(qryGen, stlDesEmb, stlProEmbLt,
        stlProEmbGl, stlProEmbLa, strProEmbCo, strProEmbSp,
        strIteEmb, strTipEmb, strTipPre, intQtdEmb,
        fltPreEmb, fltEmbala, fltPreCus, fltUnitar, fltVolPro, strTabPre, dicParams)) Then
      Begin
        Exit;
      End;
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
    if Assigned(stlProEmbLa) then FreeAndNil(stlProEmbLa);
  End;
end;

procedure TfrmConsultaCompTintaLazzumix.pTarefaPrecos(Sender: TObject);
begin
  pTarefaFormulacao(Sender);
end;

procedure TfrmConsultaCompTintaLazzumix.pTarefaVenda(Sender: TObject);
begin
  inherited;
  fCriarProcesso('AutTin\AutTin.exe exec ' + strLoginUsuarioLogado + ' 1 ' + VS_strCodEmp + ' TfrmCadMixNovasFormulas', False);
end;

function fConsultaLazzumixInterna(Sender: TForm; Var qryCadMix: TUniQuery;
  tipoConsulta: TTipoConsulta; strTabPre: String): String; stdcall;
Begin
  Result := (TLazzumixConsulta.Create).fExecutarConsulta(Sender,
    qryCadMix, tipoConsulta, strTabPre, TfrmConsultaCompTintaLazzumix);
End;

function fValidaVolumeFormulucao(strTipPre: String; fltVolCon, fltVolDil: Double) : Boolean;
begin
  Result := True;

  If strTipPre = 'C' Then // Concentrado
  Begin
    If fltVolCon = 0 Then
    Begin
      fMensagem('ATENÇÃO','O Volume do concentrado está zerado!' + #13#10 +
                          'Não será possível vender concentrado,pois a ' + #13#10 +
                          'fórmula está cadastrada somente com volume diluído!',['&Ok']);
      Result := False;
    End;
  End
  Else
  Begin //Diluido
    If fltVolDil = 0 Then
    Begin
      fMensagem('ATENÇÃO','O Volume do diluído está zerado!' + #13#10 +
                          'Não será possível vender diluído,pois a ' + #13#10 +
                          'fórmula está cadastrada somente com volume concentrado!',['&Ok']);
      Result := False;
    End;
  End;
end;

end.

