unit untSolBrazImobiliariaDinamica;

interface

uses
  untFuncEspecificas, Forms, Classes, Uni,
  untFuncoesSimples, strUtils, SysUtils, Controls, Math, Dialogs, untPnlBotoesAcoesNovaConsulta;

Type

  TfrmConsultaCompSolBrazImobiliaria = class(TfrmPnlBotoesAcoesNovaConsulta)
  public
    procedure pTarefaFormulacao(Sender: TObject); override;
    procedure pTarefaPrecos(Sender: TObject); override;
    procedure pTarefaVenda(Sender: TObject); override;
  End;

  TFormulaSolbrazImobiliariaDinamica = class(TFormulaImobiliaria)
    private
    protected
      procedure SetIteBas(const Value: String); override;
      procedure pCarregarColorantes; override;
    public
      procedure pCarregaPrecosColorantes; override;
      procedure pCalculaPreco; override;
  End;

  function fRetornaPrecoSolbrazImobiliariaDinamica(Sender: TForm; qryCadSol: TUniQuery;
    Var dicRetorno: TDicionario): Boolean;

  function fRetornaUniTraProSolbrazImobiliariaDinamica(fltPrcTin, fltPrvTin: Double): Double;

  function fRetornaDescricaoSolbrazImobiliariaDinamica(strDesCor: String; qryCadSol: TUniQuery): String;

  function fDigDadosTintometricos(qryCadSol: TUniQuery; strTabPre: String;
    Var strNovBas, strDesBas, strRefere, strUniBas, strDesCor: String;
    Var fltPreCus, fltPreVen: Double; dicRetorno: TDicionario): Boolean;

  function fRetornaProdutoBase(strCodBas, strDesBas: String; strUnidade: String): String;

  function fGTinForSolbrazImobiliariaDinamica(strIteTin: String; Var arrFormul: TForMulTinDetArray;
    Var arrBaixaPigmentos: TBaixaPigmentosArray; Var stlItensTraMl: TStringList): Boolean;

  function fConsultaSolbrazImobiliariaDinamica(Sender: TForm{; strCodEmp: String}): String; stdcall;
  function fConsultaSolbrazImobiliariaDinamicaGeral(Sender: TForm; strCodEmp: String): String; stdcall;
  function fConsultaSolbrazImobiliariaDinamicaVenda(Sender: TForm; {strCodEmp: String;}
    qryCadSol: TUniQuery; strTabPre: String): String; stdcall;

  function fConsultaSolbrazImobiliariaDinamicaInterna(Sender: TForm;  qryCadSol: TUniQuery;
    strTabPre: String; tipoConsulta: TTipoConsulta): String; stdcall;

  procedure pRetornaDadosSolbrazImobiliariaDinamica(strIteTin: String; dicRetorno: TDicionario);
  procedure pRetornaTabelaPrecoSolBraz(dicRetorno: TDicionario);
  function GetIteBasOri(const strIteTin: string): string;

implementation

uses untDigTintaImobiliaria, Data.DB,
untfuncoes,
untIConfTinta,
untICalculadorFatVendas,
untIConsultaTinta,
untTintaMaquina,
untSolBrazImobiliariaConsulta;

{ TFormulaSolbrazImobiliariaDinamica }

procedure TFormulaSolbrazImobiliariaDinamica.pCalculaPreco;
  Var
    objColorante: TColoranteImobiliario;
    intIndex: Integer;

  procedure pZerarPrecos;
  begin
    FPreCus := 0.0;
    FPreVen := 0.0;
    FCusCol := 0.0;
    FCu2Col := 0.0;
    FVenCol := 0.0;

    FOutVal := 0;
    FIcmsai := 0;
    FImpFed := 0;
    FDesOpe := 0;
    FPreMed := 0;            
  End;
begin
  inherited;

  pZerarPrecos;

  For intIndex := 0 To Count -1 Do
  Begin

    objColorante := TColoranteImobiliario(Items[intIndex]);

    If (Not qryCadCol.Locate('COL_CODCOL', objColorante.strCodcol, [])) Then
    Begin
      pZerarPrecos;
//      Raise Exception.Create('Colorante ' + objColorante.strCodCol + ' não cadastrado. Favor verificar.');
      fMensagem('', 'Colorante ' + objColorante.strCodCol + ' não cadastrado. Favor verificar.', ['OK']);
      Exit;
    End;

      If (fEmptyStr(qryCadCol.FieldByName('COL_CODITE').AsString)) Then
    Begin
      pZerarPrecos;
//      Raise Exception.Create('Colorante ' + objColorante.strCodCol + ' não está com o produto para venda associado.' + #13#10 +
//                             'Favor verificar.');
      fMensagem('', 'Colorante ' + objColorante.strCodCol + ' não está com o produto para venda associado.' + #13#10 +
                             'Favor verificar.', ['OK']);
      Exit;
    End;

    If (qryCadCol.FieldByName('ITE_CNV_ML').AsFloat <= 0) Then
    Begin
      pZerarPrecos;
      {
      Raise Exception.Create('O produto ' + qryCadCOl.FieldByName('COL_CODITE').AsString + ' não está com o fator tintométrico ' + #13#10 +
                             'preenchido corretamente. Favor verificar.');
      }
      fMensagem('', 'O produto ' + qryCadCOl.FieldByName('COL_CODITE').AsString + ' não está com o fator tintométrico ' + #13#10 +
                             'preenchido corretamente. Favor verificar.', ['OK']);

      Exit;
    End;
    
    if not IsItemAtivo(qryCadCol.FieldByName('COL_CODITE').AsString) then
    begin
      pZerarPrecos;
      raise Exception.CreateFmt('O produto %s não está ativo, Favor verificar!', [qryCadCol.FieldByName('COL_CODITE').AsString]);
    end;

    FCusCol := FCusCol + (objColorante.fltQtdCol * 0.154) * (objColorante.fltPreCus / 946);
    FCu2Col := FCu2Col + (objColorante.fltQtdCol * 0.154) * (objColorante.fltPreCu2 / 946);
    FVenCol := FVenCol + (objColorante.fltQtdCol * 0.154) * (objColorante.fltPreVen / 946);
    FPreMed := FPreMed + objColorante.fltPreMed * objColorante.fltQtdCol / 1000;

    FOutVal := FOutVal + objColorante.fltOutVal * objColorante.fltQtdCol / 1000;
    FIcmsai := FIcmsai + objColorante.fltIcmSai * (objColorante.fltPreVen * objColorante.fltQtdCol * 0.154 / 946) / 100;
    FImpFed := FImpFed + objColorante.fltImpFed * (objColorante.fltPreVen * objColorante.fltQtdCol * 0.154 / 946) / 100;
    FDesOpe := FDesOpe + objColorante.fltDesOpe * (objColorante.fltPreVen * objColorante.fltQtdCol * 0.154 / 946) / 100;

  End;

  FPreCus := FCusBas + FCusCol;
  FPreCu2 := FCu2Bas + FCu2Col;
  FPreVen := FVenBas + FVenCol;
end;

procedure TFormulaSolbrazImobiliariaDinamica.pCarregaPrecosColorantes;
  Var
    intContador: Integer;
    objColorante: TColoranteImobiliario;
begin

  For intContador := 0 To Self.Count - 1 Do
  Begin
    objColorante := TColoranteImobiliario(Self.Items[intContador]);
    qryCadCol.Locate('COL_CODCOL', objColorante.strCodCol, []);
    objColorante.fltPreCus := qryCadCol.FieldByName('ITE_PRECUS').AsFloat;
    objColorante.fltPreVen := qryCadCol.FieldByName('ITE_PREVEN').AsFloat;
    objColorante.strImpDir := qryCadCol.FieldByName('ITE_IMPDIR').AsString;
    objColorante.strCodIte := qryCadCol.FieldByName('COL_CODITE').AsString;

    objColorante.fltOutVal := qryCadCol.FieldByName('ITE_OUTVAL').AsFloat;

    if fCfgSis('IMPCF4', varBoolean) and Assigned(calculadorFatVendas) then
      objColorante.fltIcmSai := calculadorFatVendas.fCalculaAliquota(objColorante.strCodIte, objColorante.strImpDir)
    else
      objColorante.fltIcmSai := qryCadCol.FieldByName('ITE_ICMSAI').AsFloat;

    objColorante.fltImpFed := qryCadCol.FieldByName('ITE_IMPFED').AsFloat;
    objColorante.fltDesOpe := qryCadCol.FieldByName('ITE_DESOPE').AsFloat;
    objColorante.fltPreMed := qryCadCol.FieldByName('ITE_PREMED').AsFloat;

  End;

  FCalculo.Add('Valor da Base = ' + FloatToStrF(fltVenBas, ffFixed, 12, 2));
  FCalculo.Add('Valor do Colorante = (Quantidade * 0.154) * (Preço / 946)');
  FCalculo.Add('Valor da Tinta = Valor da Base + (Soma do Valor do Colorante de todos os Colorantes)');
end;

procedure TFormulaSolbrazImobiliariaDinamica.pCarregarColorantes;
begin
  Try
    qryCadCol.SQL.Clear;
    qryCadCol.SQL.Add(' SELECT                             ');
    qryCadCol.SQL.Add('   COL_CODCOL                       ');
    qryCadCol.SQL.Add('   , COL_CODITE                     ');
    qryCadCol.SQL.Add('   , ITE_CNV_ML                     ');

    If (fArqIniTinta(0, 'GERAL', 'PRECO_GERACAO', '0') <>  '0') Then
    begin
      qryCadCol.SQL.Add('   , ITE_ICMSAI                     ');
      qryCadCol.SQL.Add('   , ITE_IMPFED                     ');
      qryCadCol.SQL.Add('   , ITE_DESOPE                     ');
      qryCadCol.SQL.Add('   , ITE_OUTVAL                     ');
      qryCadCol.SQL.Add('   , ITE_PREMED                     ');
    end
    else
    begin
      qryCadCol.SQL.Add('   , 0 AS ITE_ICMSAI                ');
      qryCadCol.SQL.Add('   , 0 AS ITE_IMPFED                ');
      qryCadCol.SQL.Add('   , 0 AS ITE_DESOPE                ');
      qryCadCol.SQL.Add('   , 0 AS ITE_OUTVAL                ');
      qryCadCol.SQL.Add('   , 0 AS ITE_PREMED                ');
    end;

    If fCfgSis('IMPDIG') = '1' Then
      qryCadCol.SQL.Add('   , I.ITE_IMPDIR                   ')
    else
      qryCadCol.SQL.Add('   , G.ITE_IMPDIR                   ');

    If (fArqIniTinta(0, 'GERAL', 'PRECO_GERACAO', '0') = '0') Then
    begin
      qryCadCol.SQL.Add('   , COL_PRECUS AS ITE_PRECUS       ');
      qryCadCol.SQL.Add('   , COL_PREVEN AS ITE_PREVEN       ');
    end
    Else If (fArqIniTinta(0, 'GERAL', 'PRECO_GERACAO', '0') = '1') and FBlnCalculaUnitario Then
    begin
      qryCadCol.SQL.Add('   , ITE_PRECUS                     ');
      qryCadCol.SQL.Add('   , ITE_PREVE' + fArqIniTinta(0, 'GERAL', 'TABPRECO_GERACAO', '1') + ' AS ITE_PREVEN       ');
    end
    else
    begin
      qryCadCol.SQL.Add('   , ITE_PRECUS                     ');
      qryCadCol.SQL.Add('   , ITE_PREVE' + strTabPre + ' AS ITE_PREVEN       ');
    end;

    qryCadCol.SQL.Add(' FROM                               ');
    qryCadCol.SQL.Add('   SOL_CADCOL                       ');
    qryCadCol.SQL.Add('   JOIN ITEGER G                    ');
    qryCadCol.SQL.Add('     ON G.ITE_CODITE = COL_CODITE   ');
    qryCadCol.SQL.Add('   LEFT JOIN CADITE I               ');
    qryCadCol.SQL.Add('     ON I.ITE_CODITE = COL_CODITE   ');
    qryCadCol.SQL.Add(' WHERE G.ITE_CODEMP = :CODEMP       ');

    qryCadCol.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryCadCol.Open;
  Except
    on E: Exception do
    begin
      raise;
    end;
  End;
end;

procedure TFormulaSolbrazImobiliariaDinamica.SetIteBas(
  const Value: String);
var
  qryAux: TUniQuery;
  fltIcmsai: Double;

  function fPrecoCusto2Base(const fltPreCus, fltPreVen: Double): Double;
  begin
    Result := fCalculaPrecoCusto2(fltPreVen,
      fltPreCus,
      qryAux.FieldByName('ITE_OUTVAL').AsFloat,
      fltIcmsai,
      qryAux.FieldByName('ITE_IMPFED').AsFloat,
      qryAux.FieldByName('ITE_DESOPE').AsFloat);
  end;
begin
  inherited;
  qryAux := nil;
  Try
    Try
      qryAux := fCriaQuery(Nil);
      qryAux.SQL.Clear;

      If Value = strIteBasOri Then
      Begin
        If fltCusBasOri <= 0.0 Then
        Begin
          qryAux.SQL.Clear;
          qryAux.SQL.Add(' SELECT                               ');
          qryAux.SQL.Add('   I.ITE_CODITE                       ');

          If (fArqIniTinta(0, 'GERAL', 'PRECO_GERACAO', '0') <>  '0') Then
          begin
            qryAux.SQL.Add('   , ITE_ICMSAI                       ');
            qryAux.SQL.Add('   , ITE_IMPFED                       ');
            qryAux.SQL.Add('   , ITE_DESOPE                       ');
            qryAux.SQL.Add('   , ITE_OUTVAL                       ');
            qryAux.SQL.Add('   , ITE_PREMED                       ');
          end
          else
          begin
            qryAux.SQL.Add('   , 0 AS ITE_ICMSAI                  ');
            qryAux.SQL.Add('   , 0 AS ITE_IMPFED                  ');
            qryAux.SQL.Add('   , 0 AS ITE_DESOPE                  ');
            qryAux.SQL.Add('   , 0 AS ITE_OUTVAL                  ');
            qryAux.SQL.Add('   , 0 AS ITE_PREMED                  ');
          end;

          If fCfgSis('IMPDIG') = '1' Then
            qryAux.SQL.Add('   , I.ITE_IMPDIR                     ')
          else
            qryAux.SQL.Add('   , G.ITE_IMPDIR                     ');

          If (fArqIniTinta(0, 'GERAL', 'PRECO_GERACAO', '0') = '0') Then
          begin
            qryAux.SQL.Add('   , BAS_PRECUS AS ITE_PRECUS         ');
            qryAux.SQL.Add('   , BAS_PREVEN AS ITE_PREVEN         ');
          end
          Else If (fArqIniTinta(0, 'GERAL', 'PRECO_GERACAO', '0') = '1') and FBlnCalculaUnitario Then
          begin
            qryAux.SQL.Add('   , ITE_PRECUS                       ');
            qryAux.SQL.Add('   , ITE_PREVE' + fArqIniTinta(0, 'GERAL', 'TABPRECO_GERACAO', '1') + ' AS ITE_PREVEN         ');
          end
          else
          begin
            qryAux.SQL.Add('   , ITE_PRECUS                       ');
            qryAux.SQL.Add('   , ITE_PREVE' + strTabPre + ' AS ITE_PREVEN         ');
          end;

          qryAux.SQL.Add(' FROM                                 ');
          qryAux.SQL.Add('   SOL_CADBAS B                       ');
          qryAux.SQL.Add('   INNER JOIN CADITE I                ');
          qryAux.SQL.Add('     ON B.BAS_CODITE = I.ITE_CODITE   ');
          qryAux.SQL.Add('   INNER JOIN ITEGER G                ');
          qryAux.SQL.Add('     ON I.ITE_CODITE = G.ITE_CODITE   ');
          qryAux.SQL.Add(' WHERE I.ITE_CODITE = :CODITE         ');
          qryAux.SQL.Add('   AND G.ITE_CODEMP = :CODEMP         ');

          qryAux.ParamByName('CODITE').AsString := FIteBas;
          qryAux.ParamByName('CODEMP').AsString := VS_strCodEmp;
          qryAux.Open;

          FCusBasOri := qryAux.FieldByName('ITE_PRECUS').AsFloat;
          FVenBasOri := qryAux.FieldByName('ITE_PREVEN').AsFloat;
          FOutValBas := qryAux.FieldByName('ITE_OUTVAL').AsFloat;

          if fCfgSis('IMPCF4', varBoolean) and Assigned(calculadorFatVendas) then
          begin
            fltIcmsai := calculadorFatVendas.fCalculaAliquota(Value, qryAux.FieldByName('ITE_IMPDIR').AsString);
            FIcmsaiBas := fltIcmsai * FVenBasOri / 100;
          end
          else
          begin
            fltIcmsai := qryAux.FieldByName('ITE_ICMSAI').AsFloat;
            FIcmsaiBas := fltIcmsai * FVenBasOri / 100;
          end;


          FImpFedBas := qryAux.FieldByName('ITE_IMPFED').AsFloat * FVenBasOri / 100;
          FDesOpeBas := qryAux.FieldByName('ITE_DESOPE').AsFloat * FVenBasOri / 100;
          FPreMedBas := qryAux.FieldByName('ITE_PREMED').AsFloat;

          FCu2BasOri := fPrecoCusto2Base(FCusBasOri, FVenBasOri);
        End;

        FCusBas := fltCusBasOri;
        FCu2Bas := fltCu2BasOri;
        FVenBas := fltVenBasOri;
      End
      Else
      Begin
        FIteBas := Value;
        
        qryAux.SQL.Clear;
        qryAux.SQL.Add(' SELECT                               ');
        qryAux.SQL.Add('   I.ITE_CODITE                       ');

        If (fArqIniTinta(0, 'GERAL', 'PRECO_GERACAO', '0') <>  '0') Then
        begin
          qryAux.SQL.Add('   , ITE_ICMSAI                       ');
          qryAux.SQL.Add('   , ITE_IMPFED                       ');
          qryAux.SQL.Add('   , ITE_DESOPE                       ');
          qryAux.SQL.Add('   , ITE_OUTVAL                       ');
          qryAux.SQL.Add('   , ITE_PREMED                       ');
        end
        else
        begin
          qryAux.SQL.Add('   , 0 AS ITE_ICMSAI                  ');
          qryAux.SQL.Add('   , 0 AS ITE_IMPFED                  ');
          qryAux.SQL.Add('   , 0 AS ITE_DESOPE                  ');
          qryAux.SQL.Add('   , 0 AS ITE_OUTVAL                  ');
          qryAux.SQL.Add('   , 0 AS ITE_PREMED                  ');
        end;

        If fCfgSis('IMPDIG') = '1' Then
          qryAux.SQL.Add('   , I.ITE_IMPDIR                     ')
        else
          qryAux.SQL.Add('   , G.ITE_IMPDIR                     ');

        If (fArqIniTinta(0, 'GERAL', 'PRECO_GERACAO', '0') = '1') and FBlnCalculaUnitario Then
        begin
          qryAux.SQL.Add('   , ITE_PRECUS                       ');
          qryAux.SQL.Add('   , ITE_PREVE' + fArqIniTinta(0, 'GERAL', 'TABPRECO_GERACAO', '1') + ' AS ITE_PREVEN         ');
        end
        else
        begin
          qryAux.SQL.Add('   , ITE_PRECUS                       ');
          qryAux.SQL.Add('   , ITE_PREVE' + strTabPre + ' AS ITE_PREVEN         ');
        end;

        qryAux.SQL.Add(' FROM                                 ');
        qryAux.SQL.Add('   CADITE I                           ');
        qryAux.SQL.Add('   INNER JOIN ITEGER G                ');
        qryAux.SQL.Add('     ON I.ITE_CODITE = G.ITE_CODITE   ');
        qryAux.SQL.Add(' WHERE I.ITE_CODITE = :CODITE         ');
        qryAux.SQL.Add('   AND G.ITE_CODEMP = :CODEMP         ');

        qryAux.ParamByName('CODITE').AsString := FIteBas;
        qryAux.ParamByName('CODEMP').AsString := VS_strCodEmp;
        qryAux.Open;

        FCusBas := qryAux.FieldByName('ITE_PRECUS').AsFloat;
        FVenBas := qryAux.FieldByName('ITE_PREVEN').AsFloat;
        FOutValBas := qryAux.FieldByName('ITE_OUTVAL').AsFloat;

        if fCfgSis('IMPCF4', varBoolean) and Assigned(calculadorFatVendas) then
        begin
          fltIcmsai := calculadorFatVendas.fCalculaAliquota(Value, qryAux.FieldByName('ITE_IMPDIR').AsString);
          FIcmsaiBas := fltIcmsai * FVenBas / 100;
        end
        else
        begin
          fltIcmsai := qryAux.FieldByName('ITE_ICMSAI').AsFloat;
          FIcmsaiBas := fltIcmsai * FVenBas / 100;
        end;

        FImpFedBas := qryAux.FieldByName('ITE_IMPFED').AsFloat * FVenBas / 100;
        FDesOpeBas := qryAux.FieldByName('ITE_DESOPE').AsFloat * FVenBas / 100;
        FCu2Bas := fPrecoCusto2Base(FCusBas, FVenBas);
        FPreMedBas := qryAux.FieldByName('ITE_PREMED').AsFloat;
      End;

//      FOutValBas := fFormataFloat(FOutValBas, fCfgSis('DECUNI', varInteger));
//      FIcmsaiBas := fFormataFloat(FIcmsaiBas, fCfgSis('DECUNI', varInteger));
//      FImpFedBas := fFormataFloat(FImpFedBas, fCfgSis('DECUNI', varInteger));
//      FDesOpeBas := fFormataFloat(FDesOpeBas, fCfgSis('DECUNI', varInteger));
//      FPreMed    := fFormataFloat(FPreMed,    fCfgSis('DECUNI', varInteger));
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

function fRetornaPrecoSolbrazImobiliariaDinamica(Sender: TForm; qryCadSol: TUniQuery;
  Var dicRetorno: TDicionario): Boolean;
  Var

    {*******************************************}
    {* PARAMETROS                              *}
    {****************************************MV*}
    strCodEmp: String;
    strOpcDoc: String;
    strIteTin: String;
    blnUsaPreCus: Boolean;

    {*******************************************}
    {* VARIÁVEIS INTERNAS                      *}
    {****************************************MV*}
    fltPreCus: Double;
    fltUnitar: Double;
    strCodIte: String;
    strDesCor: String;
    strTabPre: String;
    strDesBas: String;
    strRefBas: String;
    strUniBas: String;
    strAuto: String;
    tinta : IConsultaTinta;
begin

  strCodEmp    := dicRetorno['codemp'];
  strOpcDoc    := dicRetorno['opcdoc'];
  blnUsaPreCus := dicRetorno['usaprecus'];
  strTabPre    := dicRetorno['tabpre'];

  Result := False;
{
  If (fConsultaSolbrazImobiliariaDinamicaVenda(Sender, strCodEmp, qryCadSol) = '-1') Then
  Begin
    Exit;
  End;
}

  strAuto := fConsultaSolbrazImobiliariaDinamicaVenda(Sender, qryCadSol, strTabPre);

  If (strAuto = '-1') Then
  Begin
    Exit;
  End;

  tinta := TSolBrazImobiliariaConsulta.Create;

  qryCadSol.Close;
  qryCadSol.SQL.Text := tinta.fGetSelectAutoIncrem(strAuto);
  qryCadSol.Open;

  If (Not fDigDadosTintometricos(qryCadSol, strTabPre, strCodIte, strDesBas,
        strRefBas, strUniBas, strDesCor, fltPreCus, fltUnitar, dicRetorno)) Then
  Begin
    Exit;
  End;

  //strDesCor := strDesCor + ' ' + strRefBas;
//  strDesCor := strDesCor + ' %s ' + strDesBas + IIF(fEmptyStr(strRefBas), '', ' ' + strRefBas);
  //strDesCor := strDesCor [JB];

  strDesCor := Trim(strDesCor + ' ' + tinta.fGetDescricao(qryCadSol.FieldByName('AUTOINCREM').AsString, strCodIte)); 

//  strIteTin := qryCadSol.FieldByName('SOL_CODSEQ').AsString;
  strIteTin := qryCadSol.FieldByName('SOL_MARCA_').AsString +
                qryCadSol.FieldByName('SOL_CODCOR').AsString +
                qryCadSol.FieldByName('SOL_DESBAS').AsString +
                qryCadSol.FieldByName('SOL_CODBAS').AsString +
                qryCadSol.FieldByName('SOL_UNIDAD').AsString;

  fltPreCus := fltPreCus;

  If (blnUsaPreCus) Then
    fltUnitar := fltPreCus
  Else
    fltUnitar := fltUnitar;

  If (strOpcDoc = 'BR') Then
    fltUnitar := fltUnitar;

  dicRetorno['unidad'] := strUniBas;

  dicRetorno['unitar'] := fltUnitar;
  dicRetorno['precus'] := fltPreCus;
  dicRetorno['prvtin'] := fltUnitar;
  dicRetorno['prctin'] := fltPreCus;
  dicRetorno['codite'] := strCodIte;
  dicRetorno['descor'] := strDesCor;
  dicRetorno['itetin'] := strIteTin;

  Result := True;

end;

function fRetornaUniTraProSolbrazImobiliariaDinamica(fltPrcTin, fltPrvTin: Double): Double;
  Var
    strSiglaTrava: String;
    fltFatTrava: Double;
    conf: IConfTinta;
begin
  conf          := fGetConfTinta('COL');
  strSiglaTrava := conf.fGet('TRASOL'); //fArqIniTinta(0, 'ColorBraz Imobiliaria', 'TRASOL', '');
  fltFatTrava   := conf.fGetDouble('SOLFAT'); //fStrToFloat(fArqIniTinta(0, 'ColorBraz Imobiliaria', 'SOLFAT', ''));

  If strSiglaTrava = 'CUS' Then
    Result := fltPrcTin
  Else
    Result := fltPrvTin;

  Result := Result * fltFatTrava;
end;

function fRetornaDescricaoSolbrazImobiliariaDinamica(strDesCor: String; qryCadSol: TUniQuery): String;
begin
  Result := strDesCor;  
end;

function fDigDadosTintometricos(qryCadSol: TUniQuery; strTabPre: String;
  Var strNovBas, strDesBas, strRefere, strUniBas, strDesCor: String;
  Var fltPreCus, fltPreVen: Double; dicRetorno: TDicionario): Boolean;
var
  objColorante: TColoranteImobiliario;
  objFormula: TFormulaSolbrazImobiliariaDinamica;
  intContador: Integer;
  calculadorFatVendas: ICalculadorFatVendas;  
begin
  Result := False;
  objColorante := nil;
  frmDigTintaImobiliaria := nil;
  Try
    Try
      if not Supports(dicRetorno.RetornaObjeto('calculadorFatVendas'), ICalculadorFatVendas, calculadorFatVendas) then
        calculadorFatVendas := nil;
        
      objFormula := TFormulaSolbrazImobiliariaDinamica.Create(strTabPre);
      objFormula.calculadorFatVendas := calculadorFatVendas;      
      objFormula.fltFatorEstoque := 0.154;
      objFormula.strIteBasOri := fRetornaProdutoBase(qryCadSol.FieldByName('SOL_CODBAS').AsString,
                                                     qryCadSol.FieldByName('SOL_DESBAS').AsString,
                                                     qryCadSol.FieldByName('SOL_UNIDAD').AsString);

      objFormula.strIteBas    := objFormula.strIteBasOri;
      objFormula.strUnidad    := qryCadSol.FieldByName('SOL_UNIDAD').AsString;
      objFormula.strDescri    := qryCadSol.FieldByName('SOL_MARCA_').AsString + ' ' +
                                 qryCadSol.FieldByName('SOL_CODCOR').AsString + ' ' +
                                 qryCadSol.FieldByName('SOL_DESBAS').AsString + ' ' +
                                 qryCadSol.FieldByName('SOL_CODBAS').AsString + ' ' +
                                 qryCadSol.FieldByName('SOL_UNIDAD').AsString;
      objFormula.strOpcDoc := IfNull(dicRetorno['opcdoc'], '');

      For intContador := 1 To 6 Do
      Begin

        If (fEmptyStr(qryCadSol.FieldByName('SOL_FORM' + fStrZero(intContador, 2)).AsString)) Then
          Break;

        objColorante := TColoranteImobiliario(objFormula.Add);
        objColorante.strCodCol := qryCadSol.FieldByName('SOL_FORM' + fStrZero(intContador, 2)).AsString;
        objColorante.fltQtdCol := qryCadSol.FieldByName('SOL_QTDB' + fStrZero(intContador, 2)).AsFloat;

      End;

      objFormula.pCarregaPrecosColorantes;
      objFormula.pCalculaPreco;

      Result := False;

      Application.CreateForm(TfrmDigTintaImobiliaria, frmDigTintaImobiliaria);
      objFormula.strCodEmpEst := IfNull(dicRetorno['codemp'], VS_strCodEmp);
      frmDigTintaImobiliaria.Caption := frmDigTintaImobiliaria.Caption + 'ColorBraz Imobiliaria';
      frmDigTintaImobiliaria.objFormula := objFormula;

      If frmDigTintaImobiliaria.ShowModal = mrOk Then
        Result := True;

      If (Result) Then
      Begin
        strNovBas := frmDigTintaImobiliaria.strNovBas;
        strDesBas := frmDigTintaImobiliaria.strDesBas;
        strRefere := frmDigTintaImobiliaria.strRefere;
        strUniBas := frmDigTintaImobiliaria.strUniBas;
        strDesCor := frmDigTintaImobiliaria.strDesCor;
        fltPreCus := frmDigTintaImobiliaria.fltPreCus;
        fltPreVen := frmDigTintaImobiliaria.fltPreVen;

        dicRetorno['precu2'] := objFormula.fltPreCu2;
        dicRetorno['premed'] := objFormula.fltPreMed + objFormula.fltPreMedBas;
        AcertaImpostos(fltPreCus, objFormula.fltPreCu2,
            objFormula.fltOutVal + objFormula.fltOutValBas,
            objFormula.fltIcmsai + objFormula.fltIcmsaiBas,
            objFormula.fltImpFed + objFormula.fltImpFedBas,
            objFormula.fltDesOpe + objFormula.fltDesOpeBas,
            dicRetorno);

        dicRetorno['maximoqtdbase'] := frmDigTintaImobiliaria.fltQtdMaximo;
        dicRetorno.AdicionarObjeto('formul', frmDigTintaImobiliaria.matrizSaldosColorantes);
      End;

      If (Result) And (Assigned(dicRetorno)) Then
      Begin
        objFormula.pRecalculaTabelas(dicRetorno);
      End;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(frmDigTintaImobiliaria) then FreeAndNil(frmDigTintaImobiliaria);
    if Assigned(objFormula) then FreeAndNil(objFormula);
    if Assigned(objColorante) then FreeAndNil(objColorante);
  End;

end;

function fRetornaProdutoBase(strCodBas, strDesBas: String; strUnidade: String): String;
  Var
    qryAux: TUniQuery;
begin

  qryAux := fCriaQuery(Nil);
  qryAux.SQL.Add('SELECT ');
  qryAux.SQL.Add('	BAS_CODITE');
  qryAux.SQL.Add('FROM ');
  qryAux.SQL.Add('	SOL_CADBAS B');
  qryAux.SQL.Add('WHERE');
  qryAux.SQL.Add('	B.BAS_CODBAS = :CODBAS');
  qryAux.SQL.Add('	AND B.BAS_DESCRI = :DESBAS');
  qryAux.SQL.Add('  AND B.BAS_CODUNI = :CODUNI');

  qryAux.ParamByName('CODBAS').AsString := strCodBas;
  qryAux.ParamByName('DESBAS').AsString := strDesBas;
  qryAux.ParamByName('CODUNI').AsString := strUnidade;

  qryAux.Open;
  Result := qryAux.FieldByName('BAS_CODITE').AsString;
  qryAux.Close;

  FreeAndNil(qryAux);
end;

function fGTinForSolbrazImobiliariaDinamica(strIteTin: String; Var arrFormul: TForMulTinDetArray;
  Var arrBaixaPigmentos: TBaixaPigmentosArray; Var stlItensTraMl: TStringList): Boolean;
  Var
    strSQL: String;
    strCamFor: String;
    strCamBas: String;
    intPos: Integer;
    intContador: Integer;

    strColorantes: String;
    dicColorantes: TDicionario;
    qryConsulta: TUniQuery;
begin
  qryConsulta := fCriaQuery(Nil);

  dicColorantes := TDicionario.Create;
  strColorantes := '';

  Result := True;

  strSQL := '';
  strSQL := strSQL + 'SELECT  ';
  strSQL := strSQL + '	*  ';
  strSQL := strSQL + 'FROM  ';
  strSQL := strSQL + '	SOL_CADSOL  ';
  strSQL := strSQL + 'WHERE  ';
//  strSQL := strSQL + '	SOL_CODSEQ = :CODSEQ ';
  strSql := strSQL + ' CONCAT(IFNULL(SOL_MARCA_, ""), IFNULL(SOL_CODCOR, ""), IFNULL(SOL_DESBAS, ""), IFNULL(SOL_CODBAS, ""), IFNULL(SOL_UNIDAD, "")) = :CODSEQ ';

  With qryConsulta Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODSEQ').AsString := strIteTin;
    Open;

    If (IsEmpty) Then
    Begin
      Result := False;
      Exit;
    End;

    For intContador := 1 To 5 Do
    Begin

      strCamFor := 'SOL_FORM' + fStrZero(IntToStr(intContador), 2);
      strCamBas := 'SOL_QTDB' + fStrZero(IntToStr(intContador), 2);

      arrFormul[intContador].strFormul := FieldByName(strCamFor).AsString;
      arrFormul[intContador].fltQtdBas := FieldByName(strCamBas).AsFloat * 0.154;

      dicColorantes[arrFormul[intContador].strFormul] := arrFormul[intContador].fltQtdBas;

      {*******************************************}
      {* GUARDA COLORANTES PARA POSTERIOR BUSCA  *}
      {* DOS ITENS                               *}
      {****************************************MV*}
      strColorantes := strColorantes + QuotedStr(arrFormul[intContador].strFormul);
      If (Not fEmptyStr(arrFormul[intContador].strFormul)) Then
        strColorantes := strColorantes + ', ';

    End;

    strColorantes := Trim(strColorantes);
    If (RightStr(strColorantes, 1) = ',') Then
      strColorantes := Copy(strColorantes, 1, Length(strColorantes)-1);

  End;

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  COL_CODCOL, ';
  strSQL := strSQL + '  COL_CODITE ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  SOL_CADCOL ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  COL_CODCOL IN (' + strColorantes + ') ';

  With qryConsulta Do
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
      stlItensTraMl.Add(FieldByName('COL_CODITE').AsString);

      arrBaixaPigmentos[intPos].strCodIte   := FieldByName('COL_CODITE').AsString;
      arrBaixaPigmentos[intPos].fltQtdBaixa := dicColorantes[FieldByName('COL_CODCOL').AsString];
      Inc(intPos);
      Next;
    End;

    Close;
  End;

  FreeAndNil(dicColorantes);
  FreeAndNil(qryConsulta);

end;

function fConsultaSolbrazImobiliariaDinamica(Sender: TForm{; strCodEmp: String}): String; stdcall;
Var
  qryGen: TUniQuery;
begin
  qryGen := fCriaQuery(Sender);
  Result := fConsultaSolbrazImobiliariaDinamicaInterna(Sender, qryGen, IIF(fEmptyStr(fCfgSis('TABPAD')), '1', fCfgSis('TABPAD')), tpcGeral);
  FreeAndNil(qryGen);
end;

function fConsultaSolbrazImobiliariaDinamicaGeral(Sender: TForm; strCodEmp: String): String; stdcall;
Var
  qryGen: TUniQuery;
begin
  qryGen := fCriaQuery(Sender);
  Result := fConsultaSolbrazImobiliariaDinamicaInterna(Sender, qryGen, IIF(fEmptyStr(fCfgSis('TABPAD')), '1', fCfgSis('TABPAD')), tpcGeral);
  FreeAndNil(qryGen);
end;

function fConsultaSolbrazImobiliariaDinamicaVenda(Sender: TForm; {strCodEmp: String;}
  qryCadSol: TUniQuery; strTabPre: String): String; stdcall;
begin
  Result := fConsultaSolbrazImobiliariaDinamicaInterna(Sender, qryCadSol, strTabPre, tpcVenda);
end;

function fConsultaSolbrazImobiliariaDinamicaInterna(Sender: TForm;  qryCadSol: TUniQuery;
    strTabPre: String; tipoConsulta: TTipoConsulta): String; stdcall;
begin
  Result := (TSolBrazImobiliariaConsulta.Create).fExecutarConsulta(Sender,
    qryCadSol, tipoConsulta, strTabPre, TfrmConsultaCompSolBrazImobiliaria);
end;

procedure pRetornaDadosSolbrazImobiliariaDinamica(strIteTin: String; dicRetorno: TDicionario);
  Var
    qryCadSol: TUniQuery;
    strSQL: String;
begin

  qryCadSol := fCriaQuery(Nil);

  strSQL := '';
  strSQL := strSQL + 'SELECT  ';
  strSQL := strSQL + '	*  ';
  strSQL := strSQL + 'FROM  ';
  strSQL := strSQL + '	SOL_CADSOL ';
  strSQL := strSQL + 'WHERE ';
//  strSQL := strSQL + '	SOL_CODSEQ = :CODSEQ ';
  strSql := strSQL + ' CONCAT(IFNULL(SOL_MARCA_, ""), IFNULL(SOL_CODCOR, ""), IFNULL(SOL_DESBAS, ""), IFNULL(SOL_CODBAS, ""), IFNULL(SOL_UNIDAD, "")) = :CODSEQ ';

  With qryCadSOL Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODSEQ').AsString := strIteTin;
    Open;
    dicRetorno['codtin'] := qryCadSol.FieldByName('SOL_MARCA_').AsString +
                           qryCadSol.FieldByName('SOL_CODCOR').AsString +
                           qryCadSol.FieldByName('SOL_DESBAS').AsString +
                           qryCadSol.FieldByName('SOL_CODBAS').AsString +
                           qryCadSol.FieldByName('SOL_UNIDAD').AsString;
    Close;
  End;

  FreeAndNil(qryCadSol);
end;

procedure pRetornaTabelaPrecoSolbraz(dicRetorno: TDicionario);
var
  objFormula: TFormulaSolbrazImobiliariaDinamica;
  calculadorFatVendas: ICalculadorFatVendas;
begin
  objFormula := nil;
  Try
    Try
      if not Supports(dicRetorno.RetornaObjeto('calculadorFatVendas'), ICalculadorFatVendas, calculadorFatVendas) then
        calculadorFatVendas := nil;

      objFormula := TFormulaSolbrazImobiliariaDinamica.Create('1');
      objFormula.blnCalculaUnitario := False;
      objFormula.calculadorFatVendas := calculadorFatVendas;
      objFormula.strIteBasOri := GetIteBasOri(dicRetorno['itetin']);
      objFormula.strIteBas := dicRetorno['itebas'];
      pRetornaTabelaPrecoImobiliarias(dicRetorno, objFormula, 0.154);
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

{ TfrmConsultaCompSolBrazImobiliaria }

procedure TfrmConsultaCompSolBrazImobiliaria.pTarefaFormulacao(Sender: TObject);
  Var
    qryGen: TUniQuery;
    strDesBas: String;
    strUniBas: String;
    strDesCor: String;
    fltPreCus: Double;
    strNovBas: String;
    strRefere: String;
    fltPreVen: Double;
begin
  inherited;
  strTabPre := '1';

  If (Not qryConsulta.Active) Or (qryConsulta.IsEmpty) Then
    Exit;

  qryGen := fCriaQuery(Self);
  qryGen.SQL.Add('SELECT * FROM SOL_CADSOL WHERE AUTOINCREM = :AUTINC');
  qryGen.ParamByName('AUTINC').AsString := qryConsulta.FieldByName('AUTOINCREM').AsString;
  qryGen.Open;

  fDigDadosTintometricos(qryGen, strTabPre,
                         strNovBas, strDesBas, strRefere, strUniBas, strDesCor,
                         fltPreCus, fltPreVen, TDicionario.Create);

  FreeAndNil(qryGen);
end;

procedure TfrmConsultaCompSolBrazImobiliaria.pTarefaPrecos(Sender: TObject);
begin
  inherited;
  pTarefaFormulacao(Sender);
end;

procedure TfrmConsultaCompSolBrazImobiliaria.pTarefaVenda(Sender: TObject);
begin
  inherited;
  fCriarProcesso('AutTin\AutTin.exe exec ' + strLoginUsuarioLogado + ' 1 ' + VS_strCodEmp + ' TfrmCadSolNovasFormulas', False);
end;

function GetIteBasOri(const strIteTin: string): string;
var
  qryGen: TUniQuery;
begin
  Result := '';
  qryGen := nil;
  Try
    Try
      qryGen := fCriaQuery();
      qryGen.SQL.Text :=
        ' SELECT                                ' +
        '   B.BAS_CODITE                        ' +
        ' FROM                                  ' +
        '   SOL_CADSOL A                        ' +
        '   INNER JOIN SOL_CADBAS B             ' +
        '     ON A.SOL_CODBAS = B.BAS_CODBAS    ' +
        '     AND A.SOL_DESBAS = B.BAS_DESCRI   ' +
        '     AND A.SOL_UNIDAD = B.BAS_CODUNI   ' +
        ' WHERE CONCAT(                         ' +
        '     IFNULL(A.SOL_MARCA_, "")          ' +
        '     , IFNULL(A.SOL_CODCOR, "")        ' +
        '     , IFNULL(A.SOL_DESBAS, "")        ' +
        '     , IFNULL(A.SOL_CODBAS, "")        ' +
        '     , IFNULL(A.SOL_UNIDAD, "")        ' +
        '   ) = :ITETIN                         ';
      qryGen.ParamByName('ITETIN').AsString := strIteTin;
      qryGen.Open;
      if not qryGen.IsEmpty then
        Result := qryGen.FieldByName('BAS_CODITE').AsString;

    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(qryGen) then FreeAndNil(qryGen);
  End;
end;

end.
