unit untCadImo;

interface

Uses Classes, DB, Uni, untFuncoesSimples;

Type TCadImo = Class (TComponent)
  Private
    FCodImo: String;
    FDescri: String;
    FDtaAqu: TDateTime;
    FAutInc: String;
    FDepAnu: Double;
    FPerRes: Double;
    FValAqu: Double;
    FValIcm: Double;
    FQtdPar: Integer;
    FDocAqu: String;
    FVendid: String;
    FCodEmp: String;
    FClaImo: String;
    FLocFis: String;
    FfltDepAns: Double;
    FfltPerRss: Double;
    FfltVlrRes: Double;
    FfltVlrRss: Double;

    procedure SetDescri(const Value: String);
    procedure SetDtaAqu(const Value: TDateTime);
    procedure SetValAqu(const Value: Double);
    procedure SetDepAnu(const Value: Double);
    procedure SetPerRes(const Value: Double);
    procedure SetCodEmp(const Value: String);

    procedure pAfterOpen(Dataset: TDataset);
    procedure SetLocFis(const Value: String);
    procedure SetfltDepAns(const Value: Double);
    procedure SetfltPerRss(const Value: Double);
    procedure SetfltVlrRes(const Value: Double);
    procedure SetfltVlrRss(const Value: Double);

  Public
    qryTabela: TUniQuery;
    arrDefCam: TArrDefCam;

    Property strCodImo: String Read FCodImo Write FCodImo;
    Property strVendid: String Read FVendid Write FVendid;
    Property strDescri: String Read FDescri Write SetDescri;
    Property dtaDtaAqu: TDateTime  Read FDtaAqu Write SetDtaAqu;
    Property fltDepAnu: Double Read FDepAnu Write SetDepAnu;
    Property fltPerRes: Double Read FPerRes Write SetPerRes;
    Property fltValAqu: Double Read FValAqu Write SetValAqu;
    Property fltValIcm: Double Read FValIcm Write FValIcm;
    Property fltQtdPar: Integer Read FQtdPar Write FQtdPar;
    Property strDocAqu: String Read FDocAqu Write FDocAqu;
    Property strAutInc: String Read FAutInc Write FAutInc;
    Property strCodEmp: String Read FCodEmp Write SetCodEmp;
    Property strClaImo: String Read FClaImo Write FClaImo;
    Property strLocFis: String Read FLocFis Write SetLocFis;
    Property fltDepAns: Double  read FfltDepAns write SetfltDepAns;
    property fltPerRss: Double  read FfltPerRss write SetfltPerRss;
    property fltVlrRes: Double  read FfltVlrRes write SetfltVlrRes;
    property fltVlrRss: Double  read FfltVlrRss write SetfltVlrRss;

    Constructor Create (Owner: TComponent); Reintroduce;

    procedure pSetaCampos(qryTabela: TDataset);

  End;

Const
  arrCampos: Array[0..27] Of String = ('IMO_CODIMO', 'IMO_DESCRI', 'IMO_DTAAQU', 'IMO_VALAQU',
                                       'IMO_DEPANU', 'IMO_PERRES', 'IMO_VENDID', 'IMO_CODEMP',
                                       'AUTOINCREM', 'IMO_DOCAQU', 'IMO_CLAIMO', 'IMO_LOCFIS',
                                       'IMO_VALICM', 'IMO_QTDPAR', 'IMO_DTAVEN', 'IMO_DOCVEN',
                                       'IMO_VALVEN', 'IMO_ICMVEN', 'IMO_DEPANS', 'IMO_PERRSS',
                                       'IMO_VLRRES', 'IMO_VLRRSS', 'IMO_INDTPC', 'IMO_CONCON',
                                       'IMO_NIVEL',   'IMO_NATCON', 'IMO_TOTAQU','IMO_DIFALI');

  arrDescricao: Array[0..27] Of String = ('Código', 'Descrição', 'Data Aquisição', 'Valor Aquisição',
                                         'Depreciação Anual', 'Perc. Residual', 'Vendido', 'Empresa',
                                         'AUTOINCREM', 'N.F. Aquisição', 'Classificação', 'Loc. Física',
                                         'Valor ICMS', 'Qtd. Parc', 'Data Venda', 'N.F. de Venda',
                                         'Valor de Venda', 'Valor ICMS', 'Depreciação Anual', 'Perc. Residual',
                                         'Valor Residual', 'Valor Residual','Indicador do Tipo de Conta',
                                         'Conta Contábil','Nível','Natureza da Conta Contábil', 'Valor Total',
                                         'Diferencial de Aliquota');

  arrTipo: Array[0..26] Of TFieldType = (ftString, ftString, ftDate,   ftFloat,
                                         ftFloat,  ftFloat,  ftString, ftString,
                                         ftString, ftString, ftString, ftString,
                                         ftFloat, ftInteger, ftDate, ftString,
                                         ftFloat, ftFloat, ftFloat, ftFloat,
                                         ftFloat, ftFloat,ftString, ftString,
                                         ftString,ftString, ftFloat);

  arrTamanho: Array[0..27] Of Integer = (6, 100, 12, 20, 6, 6, 1, 3, 20, 6, 1, 20, 20, 4, 12, 6, 20, 20, 6, 6, 8, 8,1,60,5,2,20,12);

  arrVisible: Array[0..26] Of Boolean = (True, True, True, True, True, True, True, True, False,True,True,True, True, True, True, True, True, True, True, True, True, True,
    True, True, True, True, True);

  arrFormat: Array[0..26] Of String = ('','','99/99/9999','#,##0.00','#,##0.00','#,##0.00','','','','','','', '#,##0.00', '', '99/99/9999', '', '#,##0.00', '#,##0.00', '#,##0.00', '#,##0.00', '#,##0.00', '#,##0.00',
    '','','','','#,##0.00');

implementation

uses SysUtils, untConstantes, untTypesSistema;

constructor TCadImo.Create(Owner: TComponent);
  Var
    intContador: Integer;
begin
  inherited;
  Try
    SetLength(arrDefCam,9);

    For intContador := Low(arrDefCam) to High(arrDefCam) DO
    Begin
      arrDefCam[intContador].strNomCam  := arrCampos[intContador];
      arrDefCam[intContador].strDesCri  := arrDescricao[intContador];
      arrDefCam[intContador].ftpTipCam  := arrTipo[intContador];
      arrDefCam[intContador].intTamCam  := arrTamanho[intContador];
      arrDefCam[intContador].blnVisible := arrVisible[intContador];
      arrDefCam[intContador].strFormat  := arrFormat[intContador];
    End;

    qryTabela := fCriaQuery(Self);
    qryTabela.AfterOpen := pAfterOpen;

    qryTabela.Close;
    qryTabela.SQL.Clear;
    qryTabela.SQL.Add ('SELECT * FROM CADIMO WHERE FALSE');
    qryTabela.Open;

    FCodImo := '';
    FDescri := '';
    FDtaAqu := 0;
    FAutInc := '';
    FDepAnu := 0;
    FPerRes := 0;
    FValAqu := 0;
    FDocAqu := '';
    FVendid := 'N';
    FCodEmp := '';
    FClaImo := '0';
    FLocFis := '';
    FfltDepAns := 0;
    FfltPerRss := 0 ;
    FfltVlrRes := 0 ;
    FfltVlrRss := 0 ;
  Except

      On E: Exception Do
        Raise Exception.Create('Ocorreu um erro ao criar o objeto CadImo!' + #13 + E.Message);
   End;
 End;

procedure TCadImo.pSetaCampos(qryTabela: TDataset);
  Var
    intIndice,
    intArray: Integer;
Begin
  For intIndice := 0 to qryTabela.FieldCount - 1 Do
    For intArray := Low(arrCampos) to High(arrCampos) Do
      If SameText(qryTabela.Fields[intIndice].FieldName,arrCampos[intArray]) Then
      Begin
        qryTabela.Fields[intIndice].DisplayLabel := arrDescricao[intArray];
        qryTabela.Fields[intIndice].Visible      := arrVisible[intArray];

        Case qryTabela.Fields[intIndice].DataType Of
          ftFloat: (qryTabela.Fields[intIndice] As TFloatField).DisplayFormat := '#,###0.00';
          ftDate : (qryTabela.Fields[intIndice] As TDateField).EditMask  := '99/99/9999';
        End;

        Break;
      End;
End;

procedure TCadImo.SetDescri(const Value: String);
begin
  If fEmptyStr(Value)Then
    Raise ExceptionAutcom.Create('A Descrição deve ser preenchida!')
  Else
    FDescri := Value;
end;

procedure TCadImo.SetDtaAqu(const Value: TDateTime);
begin
  If Value = 0 Then
    Raise ExceptionAutcom.Create('A Data de Aquisição deve ser preenchida!')
  Else
    FDtaAqu := Value;
end;

procedure TCadImo.SetfltDepAns(const Value: Double);
begin
  If Value = 0 Then
    Raise ExceptionAutcom.Create('A Depreciação Anual deve ser preenchida!')

  Else If (Value < 0) Or (Value > 100) Then
    Raise ExceptionAutcom.Create('A Depreciação Anual deve estar entre 0 e 100%!')

  Else
    FfltDepAns := Value;
end;

procedure TCadImo.SetfltPerRss(const Value: Double);
begin
  If (Value < 0) Or (Value > 100) Then
    Raise Exception.Create('A Depreciação Anual deve estar entre 0 e 100%!')
  Else
    FfltPerRss := Value;
end;

procedure TCadImo.SetfltVlrRes(const Value: Double);
begin
  FfltVlrRes := Value;
end;

procedure TCadImo.SetfltVlrRss(const Value: Double);
begin
  FfltVlrRss := Value;
end;

procedure TCadImo.SetLocFis(const Value: String);
begin
  FLocFis := Value;
end;

procedure TCadImo.SetValAqu(const Value: Double);
begin
  If Value <= 0 Then
    Raise ExceptionAutcom.Create('O Valor da Aquisição deve maior que zero!')
  Else
    FValAqu := Value;
end;

procedure TCadImo.SetDepAnu(const Value: Double);
begin
  If Value = 0 Then
    Raise ExceptionAutcom.Create('A Depreciação Anual deve ser preenchida!')

  Else If (Value < 0) Or (Value > 100) Then
    Raise ExceptionAutcom.Create('A Depreciação Anual deve estar entre 0 e 100%!')

  Else
    FDepAnu := Value;
end;

procedure TCadImo.SetPerRes(const Value: Double);
begin
  If (Value < 0) Or (Value > 100) Then
    Raise Exception.Create('A Depreciação Anual deve estar entre 0 e 100%!')
  Else
    FPerRes := Value;
end;

procedure TCadImo.SetCodEmp(const Value: String);
begin
  If fEmptyStr(Value)Then
    Raise ExceptionAutcom.Create('A Empresa deve ser preenchida!')
  Else
    FCodEmp := Value;
end;

procedure TCadImo.pAfterOpen(Dataset: TDataset);
begin
  pSetaCampos(Dataset);
end;

end.
