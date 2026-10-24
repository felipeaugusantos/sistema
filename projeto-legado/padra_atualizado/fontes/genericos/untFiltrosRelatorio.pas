unit untFiltrosRelatorio;

interface

Uses frxClass, untGeraExcel, untIFiltrosRelatorio, untInterfacedObjectNoCount,
  untTypesSistema;

Type

  TFiltrosRelatorio = Class(TInterfacedObjectNoCount, IFiltrosRelatorio)

    FNomRel: String;
    FarrFiltros: TArrRecFiltros;
  Public

    Procedure pLimpaFiltros;

    Procedure pIncluiFiltro(strNomVar, strFiltro: String; blnTitRel: Boolean = False);

    Procedure pSetaVariaveisFast(frxReport: TfrxReport; blnMatricial: Boolean);

    Constructor Create; Reintroduce;
    Destructor  Destroy; Override;

    function GetStrNomRel : String;
    procedure SetStrNomRel(Value : String);

    function GetArrFiltros : TArrRecFiltros;
    procedure SetArrFiltros(Value : TArrRecFiltros);

    property strNomRel: String  Read GetStrNomRel Write SetStrNomRel;
    property arrFiltros: TArrRecFiltros  Read GetArrFiltros Write SetArrFiltros;
  End;

implementation

Uses untFuncoesSimples, SysUtils;

Constructor TFiltrosRelatorio.Create;
Begin
  Inherited;
  SetLength(FarrFiltros, 0);
End;

Destructor TFiltrosRelatorio.Destroy;
Begin
  Inherited;
  SetLength(FarrFiltros, 0);
End;

function TFiltrosRelatorio.GetArrFiltros: TArrRecFiltros;
begin
  Result := FArrFiltros;
end;

function TFiltrosRelatorio.GetStrNomRel: String;
begin
  Result := FNomRel;
end;

Procedure TFiltrosRelatorio.pIncluiFiltro(strNomVar, strFiltro: String; blnTitRel: Boolean = False);
Begin
  SetLength(FarrFiltros, Succ(Length(arrFiltros)));
  arrFiltros[High(arrFiltros)].strNomVar := strNomVar;
  arrFiltros[High(arrFiltros)].strNomFil := strFiltro;
  arrFiltros[High(arrFiltros)].blnTitulo := blnTitRel;

  If blnTitRel Then
    FNomRel := strFiltro;
End;

Procedure TFiltrosRelatorio.pLimpaFiltros;
Begin
  SetLength(FarrFiltros, 0);
End;

Procedure TFiltrosRelatorio.pSetaVariaveisFast(frxReport: TfrxReport; blnMatricial: Boolean);
  Var
    intContador: Integer;
Begin
  For intContador := Low(arrFiltros) To High(arrFiltros) Do
    With arrFiltros[intContador] Do
    If blnMatricial Then
      frxReport.Variables[strNomVar] := QuotedStr(fRemoveAcento(strNomFil))
    Else
      frxReport.Variables[strNomVar] := QuotedStr(strNomFil);
End;

procedure TFiltrosRelatorio.SetArrFiltros(Value: TArrRecFiltros);
begin
  FArrFiltros := Value;
end;

procedure TFiltrosRelatorio.SetStrNomRel(Value: String);
begin
  FNomRel := Value;
end;


end.
