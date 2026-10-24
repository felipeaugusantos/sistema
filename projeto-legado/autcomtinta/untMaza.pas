unit untMaza;

interface

uses
  untFuncEspecificas, Forms, Classes, Uni, untFuncoesSimples, strUtils, SysUtils, Controls, untPnlBotoesAcoesNovaConsulta,
  Math, Dialogs, Variants;

Type
  TfrmConsultaCompMaza = class(TfrmPnlBotoesAcoesNovaConsulta)
  public
    procedure pTarefaFormulacao(Sender: TObject); override;
    procedure pTarefaPrecos(Sender: TObject); override;
    procedure pTarefaVenda(Sender: TObject); override;
  End;

  TFormulaMaza = class(TFormulaImobiliaria)
  protected
    procedure SetIteBas(const Value: String); override;
    procedure pCarregarColorantes; override;
  public
    procedure pCalculaPreco; override;
    procedure pCarregaPrecosColorantes; override;
  End;

  function fRetornaPrecoMazaDinamica(Sender: TForm; qryCadMaz: TUniQuery; Var dicRetorno: TDicionario): Boolean;
  function fRetornaUniTraProMazaDinamica(fltPrcTin, fltPrvTin: Double): Double;
  function fRetornaDescricaoMazaDinamica(strDesCor: String; qryCadMaz: TUniQuery): String;

  function fDigDadosTintometricos(qryCadMaz: TUniQuery; strTabPre: String; var strCodBas: String;
    Var strNovBas, strDesBas, strRefere, strUniBas, strDesCor: String;
    Var fltPreCus, fltPreVen: Double; dicRetorno: TDicionario): Boolean;

  function fRetornaProdutoBase(strCodBas, strProd, strCodUni: String): String;
  function fGTinForMazaDinamica(strIteTin: String; Var arrFormul: TForMulTinDetArray;
    Var arrBaixaPigmentos: TBaixaPigmentosArray; Var stlItensTraMl: TStringList): Boolean;

  function fConsultaMazaDinamica(Sender: TForm): String; stdcall;
  function fConsultaMazaDinamicaGeral(Sender: TForm): String; stdcall;
  function fConsultaMazaDinamicaVenda(Sender: TForm; qryCadMaz: TUniQuery; strTabPre: String): String; stdcall;

  function fConsultaMazaDinamicaInterna(Sender: TForm;  qryCadMaz: TUniQuery;
    strTabPre: String; tipoConsulta: TTipoConsulta): String; stdcall;

  procedure pRetornaDadosMazaDinamica(strIteTin: String; dicRetorno: TDicionario);
  procedure pRetornaTabelaPrecoMaza(dicRetorno: TDicionario);
  function GetIteBasOri(const strIteTin: string): string;

implementation

uses DB, untDigTintaImobiliaria, untFuncoes, untIConfTinta,
untICalculadorFatVendas,
untTintaMaquina,
untMazaConsulta,
untIConsultaTinta;



{ TFormulaMaza }

procedure TFormulaMaza.pCalculaPreco;
  Var
    objComponente: TColoranteImobiliario;
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

    objComponente := TColoranteImobiliario(Items[intIndex]);

    If (Not qryCadCol.Locate('COL_CODCOL', objComponente.strCodcol, [])) Then
    Begin
      pZerarPrecos;
      Raise Exception.Create('Colorante ' + objComponente.strCodCol + ' não cadastrado. Favor verificar.');
      Exit;
    End;

    If (fEmptyStr(qryCadCol.FieldByName('COL_CODITE').AsString)) Then
    Begin
      pZerarPrecos;
      Raise Exception.Create('Colorante ' + objComponente.strCodCol + ' não está com o produto para venda associado.' + #13#10 +
                             'Favor verificar.');
      Exit;
    End;

    If (qryCadCol.FieldByName('ITE_CNV_ML').AsFloat <= 0) Then
    Begin
      pZerarPrecos;
      Raise Exception.Create('O produto ' + qryCadCOl.FieldByName('COL_CODITE').AsString + ' não está com o fator tintométrico ' + #13#10 +
                             'preenchido corretamente. Favor verificar.');
      Exit;
    End;
    
    if not IsItemAtivo(qryCadCol.FieldByName('COL_CODITE').AsString) then
    begin
      pZerarPrecos;
      raise Exception.CreateFmt('O produto %s não está ativo, Favor verificar!', [qryCadCol.FieldByName('COL_CODITE').AsString]);
    end;

    FCusCol := FCusCol + objComponente.fltQtdCol * objComponente.fltPreCus  * (29.57 / 192) / 946;
    FCu2Col := FCu2Col + objComponente.fltQtdCol * objComponente.fltPreCu2  * (29.57 / 192) / 946;
    FVenCol := FVenCol + objComponente.fltQtdCol * objComponente.fltPreVen  * (29.57 / 192) / 946;
    FPreMed := FPreMed + objComponente.fltPreMed * objComponente.fltQtdCol * (29.57 / 192) / 946;

    FOutVal := FOutVal + objComponente.fltOutVal * objComponente.fltQtdCol * (29.57 / 192) / 946;
    FIcmsai := FIcmsai + objComponente.fltIcmSai * (objComponente.fltPreVen * objComponente.fltQtdCol * (29.57 / 192) / 946) / 100;
    FImpFed := FImpFed + objComponente.fltImpFed * (objComponente.fltPreVen * objComponente.fltQtdCol * (29.57 / 192) / 946) / 100;
    FDesOpe := FDesOpe + objComponente.fltDesOpe * (objComponente.fltPreVen * objComponente.fltQtdCol * (29.57 / 192) / 946) / 100;

  End;

  FPreCus := FCusBas + FCusCol;
  FPreCu2 := FCu2Bas + FCu2Col;
  FPreVen := FVenBas + FVenCol;

  pCarregaPrecosColorantes;
end;

procedure TFormulaMaza.pCarregaPrecosColorantes;
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

  FCalculo.Clear;
  FCalculo.Add('Valor da Base = ' + FloatToStrF(fltVenBas, ffFixed, 12, 2));
  FCalculo.Add('Valor do Colorante = (Quantidade * (29.5735295625 / 192)) * (Preço / 946)');
  FCalculo.Add('Valor da Tinta = Valor da Base + (Soma do Valor do Colorante de todos os Colorantes)');

end;

procedure TFormulaMaza.pCarregarColorantes;
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
    qryCadCol.SQL.Add('   MAZ_CADCOL                       ');
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

procedure TFormulaMaza.SetIteBas(const Value: String);
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
          qryAux.SQL.Add('   MAZ_CADBAS B                       ');
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

{ TfrmConsultaCompMaza }

procedure TfrmConsultaCompMaza.pTarefaFormulacao(Sender: TObject);
  Var
    qryTinta: TUniQuery;
    fltPreCus: Double;
    fltPreVen: Double;
    dicRetorno: TDicionario;
    strCodBas: String;
    strNovBas: String;
    strDesBas: String;
    strRefere: String;
    strUniBas: String;
    strDesCor: String;
begin
  inherited;

  If (Not qryConsulta.Active) Or (qryConsulta.IsEmpty) Then
    Exit;

  dicRetorno := TDicionario.Create;

  qryTinta := fCriaQuery(Self);
  qryTinta.SQL.Add('SELECT * FROM MAZ_CADMAZ WHERE AUTOINCREM = :AUTINC');
  qryTinta.ParamByName('AUTINC').AsString := qryConsulta.FieldByName('AUTOINCREM').AsString;
  qryTinta.Open;

  fDigDadosTintometricos(qryTinta, strTabPre, strCodBas, strNovBas, strDesBas,
      strRefere, strUniBas, strDesCor, fltPreCus, fltPreVen, dicRetorno);

  FreeAndNil(qryTinta);
  FreeAndNil(dicRetorno);
end;

procedure TfrmConsultaCompMaza.pTarefaPrecos(Sender: TObject);
begin
  inherited;
  pTarefaFormulacao(Sender);
end;

procedure TfrmConsultaCompMaza.pTarefaVenda(Sender: TObject);
begin
  inherited;
  fCriarProcesso('AutTin\AutTin.exe exec ' + strLoginUsuarioLogado + ' 1 ' + VS_strCodEmp + ' TfrmCadMazNovasFormulas', False);
end;

function fRetornaPrecoMazaDinamica(Sender: TForm; qryCadMaz: TUniQuery; Var dicRetorno: TDicionario): Boolean;
  Var
    strCodEmp: String;
    strOpcDoc: String;
    blnUsaPreCus: Boolean;
    strTabPre: String;
    strCodBas: String;
    strNovBas: String;
    strDesBas: String;
    strRefere: String;
    strUniBas: String;
    strDesCor: String;
    fltPreCus: Double;
    fltPreVen: Double;
    strIteTin: String;
    fltUniTar: Double;

    strAuto: String;
    tinta : IConsultaTinta;

Begin
  strCodEmp    := dicRetorno['codemp'];
  strOpcDoc    := dicRetorno['opcdoc'];
  blnUsaPreCus := dicRetorno['usaprecus'];
  strTabPre    := dicRetorno['tabpre'];

  Result := False;
{
  If fConsultaMazaDinamicaVenda(Sender, qryCadMaz, strTabPre) = '-1' Then
  Begin
    Exit;
  End;
}

  strAuto := fConsultaMazaDinamicaVenda(Sender, qryCadMaz, strTabPre);

  If (strAuto = '-1') Then
  Begin
    Exit;
  End;

  tinta := TMazaConsulta.Create;

  qryCadMaz.Close;
  qryCadMaz.SQL.Text := tinta.fGetSelectAutoIncrem(strAuto);
  qryCadMaz.Open;


  If Not fDigDadosTintometricos(qryCadMaz, strTabPre, strCodBas, strNovBas,
    strDesBas, strRefere, strUniBas, strDesCor, fltPreCus, fltPreVen, dicRetorno) Then
  Begin
    Exit;
  End;

  strDesCor := Trim(tinta.fGetDescricao(qryCadMaz.FieldbyName('AUTOINCREM').AsString, strNovBas));

  strIteTin := qryCadMaz.FieldByName('MAZ_COLNUM').AsString +
      qryCadMaz.FieldByName('MAZ_COLNAM').AsString +
      qryCadMaz.FieldByName('MAZ_CODBAS').AsString +
      qryCadMaz.FieldByName('MAZ_PRODUT').AsString +
      qryCadMaz.FieldByName('MAZ_CODUNI').AsString;

  fltUniTar := fltPreVen;

  If blnUsaPreCus Then
    fltUniTar := fltPreCus;

  dicRetorno['unidad'] := strUniBas;
  dicRetorno['unitar'] := fltUniTar;
  dicRetorno['precus'] := fltPreCus;
  dicRetorno['prvtin'] := fltPreVen;
  dicRetorno['prctin'] := fltPreCus;
  dicRetorno['codite'] := strNovBas;//strCodBas;
  dicRetorno['descor'] := strDesCor;
  dicRetorno['itetin'] := strIteTin;

  Result := True;
End;

function fRetornaUniTraProMazaDinamica(fltPrcTin, fltPrvTin: Double): Double;
  Var
    strSiglaTrava: String;
    fltFatTrava: Double;
    conf: IConfTinta;
begin
  conf  := fGetConfTinta('MAZ');
  strSiglaTrava := conf.fGet('MAZTRA'); //fArqIniTinta(0, 'Maza', 'MAZTRA', '');
  fltFatTrava   := conf.fGetDouble('FATMAZ'); //fStrToFloat(fArqIniTinta(0, 'Maza', 'FATMAZ', '0'));

  If strSiglaTrava = 'CUS' Then
    Result := fltPrcTin
  Else
    Result := fltPrvTin;

  Result := Result * fltFatTrava;
End;

function fRetornaDescricaoMazaDinamica(strDesCor: String; qryCadMaz: TUniQuery): String;
Begin
  Result := strDesCor;
End;

function fDigDadosTintometricos(qryCadMaz: TUniQuery; strTabPre: String; var strCodBas: String;
  Var strNovBas, strDesBas, strRefere, strUniBas, strDesCor: String;
  Var fltPreCus, fltPreVen: Double; dicRetorno: TDicionario): Boolean;
var
  objFormula: TFormulaMaza;
  intCont: Integer;
  objColorante: TColoranteImobiliario;
  calculadorFatVendas: ICalculadorFatVendas;
Begin
  Result := False;
  objFormula := nil;
  frmDigTintaImobiliaria := nil;
  Try
    Try
      if not Supports(dicRetorno.RetornaObjeto('calculadorFatVendas'), ICalculadorFatVendas, calculadorFatVendas) then
        calculadorFatVendas := nil;
            
      objFormula := TFormulaMaza.Create(strTabPre);
      objFormula.calculadorFatVendas := calculadorFatVendas;
      objFormula.strIteBasOri := fRetornaProdutoBase(qryCadMaz.FieldByName('MAZ_CODBAS').AsString,
                                                      qryCadMaz.FieldByName('MAZ_PRODUT').AsString,
                                                      qryCadMaz.FieldByName('MAZ_CODUNI').AsString);
      objFormula.strIteBas := objFormula.strIteBasOri;
      objFormula.fltFatorEstoque := (29.57 / 192);
      objFormula.strUnidad := qryCadMaz.FieldByName('MAZ_CODUNI').AsString;
      objFormula.strDescri := fRetornaDescricaoMazaDinamica(strDesCor, qryCadMaz);
      objFormula.strOpcDoc := IfNull(dicRetorno['opcdoc'], '');

      For intCont := 1 To 10 Do
      Begin
        If fEmptyStr(qryCadMaz.FieldByName('MAZ_CODC' + fStrZero(intCont, 2)).AsString) Then
          Break;

        objColorante := TColoranteImobiliario(objFormula.Add);
        objColorante.strCodCol := qryCadMaz.FieldByName('MAZ_CODC' + fStrZero(intCont, 2)).AsString;
        objColorante.fltQtdCol := qryCadMaz.FieldByName('MAZ_QTDC' + fStrZero(intCont, 2)).AsFloat;
      End;

      objFormula.pCarregaPrecosColorantes;
      objFormula.pCalculaPreco;

      Application.CreateForm(TfrmDigTintaImobiliaria, frmDigTintaImobiliaria);
      objFormula.strCodEmpEst := IfNull(dicRetorno['codemp'], VS_strCodEmp);
      frmDigTintaImobiliaria.Caption := frmDigTintaImobiliaria.Caption + 'Maza';
      frmDigTintaImobiliaria.objFormula := objFormula;

      Result := (frmDigTintaImobiliaria.ShowModal = mrOk);
      If Result Then
      Begin
        strNovBas := frmDigTintaImobiliaria.strNovBas;
        strDesBas := frmDigTintaImobiliaria.strDesBas;
        strRefere := frmDigTintaImobiliaria.strRefere;
        strUniBas := frmDigTintaImobiliaria.strUniBas;
        strDesCor := frmDigTintaImobiliaria.strDesCor + ' ' + frmDigTintaImobiliaria.objFormula.strDescri;
        fltPreCus := frmDigTintaImobiliaria.fltPreCus;
        fltPreVen := frmDigTintaImobiliaria.fltPreVen;
        strCodBas := frmDigTintaImobiliaria.objFormula.strIteBasOri;

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

      If Result And Assigned(dicRetorno) Then
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
    if Assigned(objFormula) then FreeAndNil(objFormula);
    if Assigned(frmDigTintaImobiliaria) then FreeAndNil(frmDigTintaImobiliaria);
  End;
End;

function fRetornaProdutoBase(strCodBas, strProd, strCodUni: String): String;
  Var
    qryGen: TUniQuery;
Begin
  qryGen := fCriaQuery();
  qryGen.SQL.Add(' SELECT BAS_CODITE ');
  qryGen.SQL.Add(' FROM MAZ_CADBAS ');
  qryGen.SQL.Add(' WHERE BAS_CODBAS = :CODBAS ');
  qryGen.SQL.Add('     AND BAS_PRODUT = :PRODUT ');
  qryGen.SQL.Add('     AND BAS_CODUNI = :UNIDAD; ');

  qryGen.ParamByName('CODBAS').AsString := strCodBas;
  qryGen.ParamByName('PRODUT').AsString := strProd;
  qryGen.ParamByName('UNIDAD').AsString := strCodUni;

  qryGen.Open;
  Result := qryGen.FieldbyName('BAS_CODITE').AsString;
  FreeAndNil(qryGen);
End;

function fGTinForMazaDinamica(strIteTin: String; Var arrFormul: TForMulTinDetArray;
  Var arrBaixaPigmentos: TBaixaPigmentosArray; Var stlItensTraMl: TStringList): Boolean;
  Var
    qryGen: TUniQuery;
    intCont: Integer;
    dicFormulas: TDicionario;
    strColorantes: String;
Begin
  qryGen := fCriaQuery();
  qryGen.SQL.Add(' SELECT * ');
  qryGen.SQL.Add(' FROM MAZ_CADMAZ ');
  qryGen.SQL.Add(' WHERE  ');
  qryGen.SQL.Add('    CONCAT( ');
  qryGen.SQL.Add('    IFNULL(MAZ_COLNUM, ""),  ');
  qryGen.SQL.Add('    IFNULL(MAZ_COLNAM, ""),  ');
  qryGen.SQL.Add('    IFNULL(MAZ_CODBAS, ""),  ');
  qryGen.SQL.Add('    IFNULL(MAZ_PRODUT, ""),  ');
  qryGen.SQL.Add('    IFNULL(MAZ_CODUNI, "")) = :ITETIN ');

  qryGen.ParamByName('ITETIN').AsString := strIteTin;
  qryGen.Open;

  Result := Not qryGen.IsEmpty;
  If Not Result Then
    Exit;

  dicFormulas := TDicionario.Create;
  strColorantes := '';

  For intCont := 1 To 10 Do
  Begin
    If fEmptyStr(qryGen.FieldByName('MAZ_CODC' + fStrZero(intCont, 2)).AsString) Then
      Break;

    arrFormul[intCont].strFormul := qryGen.FieldByName('MAZ_CODC' + fStrZero(intCont, 2)).AsString;
    arrFormul[intCont].fltQtdbas := qryGen.FieldByName('MAZ_QTDC' + fStrZero(intCont, 2)).AsFloat * (29.57 / 192);
    dicFormulas[arrFormul[intCont].strFormul] := arrFormul[intCont].fltQtdbas;
    strColorantes := strColorantes + ',' + QuotedStr(arrFormul[intCont].strFormul);
  End;

  strColorantes := Trim(strColorantes);
  strColorantes := Copy(strColorantes, 2, Length(strColorantes));

  qryGen.Close;
  qryGen.SQL.Clear;
  qryGen.SQL.Add(' SELECT ');
  qryGen.SQL.Add('   COL_CODCOL, ');
  qryGen.SQL.Add('   COL_CODITE ');
  qryGen.SQL.Add(' FROM MAZ_CADCOL ');
  qryGen.SQL.Add(' WHERE COL_CODCOL IN(' + strColorantes + ') ');
  qryGen.Open;

  SetLength(arrBaixaPigmentos, qryGen.RecordCount);

  While Not qryGen.Eof Do
  Begin
    arrBaixaPigmentos[qryGen.RecNo - 1].strCodIte := qryGen.FieldByName('COL_CODITE').AsString;
    arrBaixaPigmentos[qryGen.RecNo - 1].fltQtdBaixa := dicFormulas[qryGen.FieldByName('COL_CODCOL').AsString];
    arrBaixaPigmentos[qryGen.RecNo - 1].strTipComp := 'C';
    qryGen.Next;                   
  End;

  FreeAndNil(dicFormulas);
  FreeAndNil(qryGen);
End;

function fConsultaMazaDinamica(Sender: TForm): String; stdcall;
  Var
    qryGen: TUniQuery;
Begin
  qryGen := fCriaQuery();
  Result := fConsultaMazaDinamicaInterna(Sender, qryGen, IIF(fEmptyStr(fCfgSis('TABPAD')), '1', fCfgSis('TABPAD')), tpcGeral);
  FreeAndNil(qryGen);
End;

function fConsultaMazaDinamicaGeral(Sender: TForm): String; stdcall;
Begin
  Result := fConsultaMazaDinamica(Sender);
End;

function fConsultaMazaDinamicaVenda(Sender: TForm; qryCadMaz: TUniQuery; strTabPre: String): String; stdcall;
Begin
  Result := fConsultaMazaDinamicaInterna(Sender, qryCadMaz, strTabPre, tpcVenda);
End;

function fConsultaMazaDinamicaInterna(Sender: TForm;  qryCadMaz: TUniQuery;
  strTabPre: String; tipoConsulta: TTipoConsulta): String; stdcall;
Begin
  Result := (TMazaConsulta.Create).fExecutarConsulta(Sender,
    qryCadMaz, tipoConsulta, strTabPre, TfrmConsultaCompMaza);
End;

procedure pRetornaDadosMazaDinamica(strIteTin: String; dicRetorno: TDicionario);
  Var
    qryGen: TUniQuery;
Begin
  qryGen := fCriaQuery();


  qryGen.SQL.Add(' SELECT * ');
  qryGen.SQL.Add(' FROM MAZ_CADMAZ ');
  qryGen.SQL.Add(' WHERE  ');
  qryGen.SQL.Add('    CONCAT( ');
  qryGen.SQL.Add('    IFNULL(MAZ_COLNUM, ""),  ');
  qryGen.SQL.Add('    IFNULL(MAZ_COLNAM, ""),  ');
  qryGen.SQL.Add('    IFNULL(MAZ_CODBAS, ""),  ');
  qryGen.SQL.Add('    IFNULL(MAZ_PRODUT, ""),  ');
  qryGen.SQL.Add('    IFNULL(MAZ_CODUNI, "")) = :ITETIN ');

  qryGen.ParamByName('ITETIN').AsString := strIteTin;
  qryGen.Open;
  dicRetorno['codtin'] :=
    qryGen.FieldByName('MAZ_COLNUM').AsString + ' ' +
    qryGen.FieldByName('MAZ_CODBAS').AsString + ' ' +
    qryGen.FieldByName('MAZ_PRODUT').AsString + ' ' +
    qryGen.FieldByName('MAZ_CODUNI').AsString;

  FreeAndNil(qryGen);
End;

procedure pRetornaTabelaPrecoMaza(dicRetorno: TDicionario);
var
  objFormula : TFormulaMaza;
  calculadorFatVendas: ICalculadorFatVendas;
Begin

  objFormula := nil;
  Try
    Try
      if not Supports(dicRetorno.RetornaObjeto('calculadorFatVendas'), ICalculadorFatVendas, calculadorFatVendas) then
        calculadorFatVendas := nil;

      objFormula := TFormulaMaza.Create('1');
      objFormula.blnCalculaUnitario := False;
      objFormula.calculadorFatVendas := calculadorFatVendas;
      objFormula.strIteBasOri := GetIteBasOri(dicRetorno['itetin']);
      objFormula.strIteBas := dicRetorno['itebas'];


      pRetornaTabelaPrecoImobiliarias(dicRetorno, objFormula, (29.57 / 192));
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
        '   MAZ_CADMAZ M                        ' +
        '   INNER JOIN MAZ_CADBAS B             ' +
        '     ON M.MAZ_CODBAS = B.BAS_CODBAS    ' +
        '     AND M.MAZ_PRODUT = B.BAS_PRODUT   ' +
        '     AND M.MAZ_CODUNI = B.BAS_CODUNI   ' +
        ' WHERE CONCAT(                         ' +
        '     IFNULL(M.MAZ_COLNUM, "")          ' +
        '     , IFNULL(M.MAZ_COLNAM, "")        ' +
        '     , IFNULL(M.MAZ_CODBAS, "")        ' +
        '     , IFNULL(M.MAZ_PRODUT, "")        ' +
        '     , IFNULL(M.MAZ_CODUNI, "")        ' +
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
