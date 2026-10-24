unit untQckEspelhoNotaDevolucao;

interface

uses
  SysUtils, Classes, frxClass, frxDBSet, untFuncoesFactory, Uni,
  frxDMPExport, untFuncoesGenerica, TypesRel, untIFuncoes;

type
  TfrmQckEspelhoNotaDevolucao = class(TDataModule)
    frxRelEspelhoNotaM: TfrxReport;
    frxRelEspelhoNotaJ: TfrxReport;
    frxGen: TfrxUserDataSet;
    frxRelatorio: TfrxDBDataset;
    frxMatricial: TfrxDotMatrixExport;
    procedure DataModuleCreate(Sender: TObject);
    function frxRelEspelhoNotaMUserFunction(const MethodName: String;
      var Params: Variant): Variant;
    procedure frxGenGetValue(const VarName: String; var Value: Variant);
  private
    FPais: TPais;
    function fVisualizaParcela( strEspDoc, strNumDoc, strSerie, strCodCli : String ) : String;
    function fRetVencimentos(strTabela, strNumDoc, strSerie, strCliente: String): TParcelasArray;
    function fFormataCpfCgcInterna(strCGCCPF: String): String;
    { Private declarations }
  public
    strTipImp  : String;
    arrParcelas: TParcelasArray;
    strCodEmp: String;
    { Public declarations }
  end;

var
  frmQckEspelhoNotaDevolucao: TfrmQckEspelhoNotaDevolucao;

implementation

uses Math, Data.DB;

{$R *.dfm}

procedure TfrmQckEspelhoNotaDevolucao.DataModuleCreate(Sender: TObject);
  var
    intContador:integer;
begin
  {****************************************************}
  {*  DESABILITA OS BOTÕES SAVE, LOAD e EDIT DO FAST  *}
  {*11/05/2015**************************************RB*}
  For intContador := 0 To Self.ComponentCount -1 Do
  Begin

    If (Self.Components[intContador] Is TfrxReport) Then
    Begin
      TfrxReport(Self.Components[intContador]).PreviewOptions.Buttons :=
      TfrxReport(Self.Components[intContador]).PreviewOptions.Buttons - [pbSave, pbLoad, pbEdit];
    End;
  End;

  FPais := fSetaPais;
  frxRelEspelhoNotaM.AddFunction('function fFormataCondPag(strCond: String): String;');
  frxRelEspelhoNotaM.AddFunction('function fVisualizaParcela( strEspDoc, strNumDoc, strSerie, strCodCli : String) : String');
  frxRelEspelhoNotaM.AddFunction('function fFormataCpfCgcInterna(strCGCCPF: String; intTipo: Integer): String;');

  frxRelEspelhoNotaJ.AddFunction('function fFormataCondPag(strCond: String): String;');
  frxRelEspelhoNotaJ.AddFunction('function fVisualizaParcela( strEspDoc, strNumDoc, strSerie, strCodCli : String) : String');
  frxRelEspelhoNotaJ.AddFunction('function fFormataCpfCgcInterna(strCGCCPF: String; intTipo: Integer): String;');
end;

function TfrmQckEspelhoNotaDevolucao.frxRelEspelhoNotaMUserFunction(
  const MethodName: String; var Params: Variant): Variant;
begin

  If MethodName = 'FFORMATACONDPAG' Then
    Result := fFormataCondPag(Params[0]);

  If MethodName = 'FVISUALIZAPARCELA' Then
    Result := fVisualizaParcela(Params[0],Params[1],Params[2],Params[3]);

  If MethodName = 'FFORMATACPFCGCINTERNA' Then
  Begin
    If Params[1] = 1 Then
      Result := 'CNPJ: ' + fFormataCpfCgcInterna(Params[0])
    Else
      Result := 'C.P.F: ' + fFormataCpfCgcInterna(Params[0]);
  End;

end;


procedure TfrmQckEspelhoNotaDevolucao.frxGenGetValue(const VarName: String;
  var Value: Variant);
begin
  If VarName = 'EMP_NOMEMP' Then
    Value := fRetNomeEmpresa(VS_strCodEmp)

  Else If VarName = 'REL_NOMREL' Then
    Value := Self.Name;
end;

function TfrmQckEspelhoNotaDevolucao.fVisualizaParcela( strEspDoc, strNumDoc, strSerie, strCodCli : String) : String;
  Var
    intContador  : Integer;
    strParcelas  : String;
    strArqCtp    : String;
Begin
  Try
    strArqCtp := 'CADREC';

    {********************************}
    {* PEGA OS VALORES DAS PARCELAS *}
    {*****************************AF*}
    arrParcelas := fRetVencimentos(strArqCtp,
                                   strNumDoc,
                                   strSerie,
                                   strCodCli);

    For intContador := 0 To Length(arrParcelas) -1 Do
    Begin
      strParcelas := strParcelas + String(arrLetras[intContador]) + ')' + arrParcelas[intContador].strData + ' ' + arrParcelas[intContador].strValor+'   ';
      If (arrLetras[intContador] = 'F')And(strTipImp = 'M') Then
        strParcelas := strParcelas + #13#10;
    End;

    Result := strParcelas;

  Except
    Result := '';
  End;
End;

{*********************************}
{* RETORNA PARCELAS REFERENTE AO *}
{* NUMERO DO DOCUMENTO           *}
{******************************AF*}
function TfrmQckEspelhoNotaDevolucao.fFormataCpfCgcInterna(
  strCGCCPF: String): String;
begin
  Result := fFormataCpfCgc(strCGCCPF, FPais);
end;

function TfrmQckEspelhoNotaDevolucao.fRetVencimentos(strTabela, strNumDoc, strSerie, strCliente: String): TParcelasArray;
  Var
    arrParcelas: TParcelasArray;
    strSQL     : String;
    intContador: Integer;
    qryGenVen  : TUniQuery;

Begin
  Try

    qryGenVen := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
    strSQL := strSQL + '  CTR_DTAVEN, ';
    strSQL := strSQL + '  CTR_VALORI  ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + strTabela;
    strSQL := strSQL + ' WHERE ';
    strSQL := strSQL + '  CTR_NUMDUP = :NUMDUP AND ';
    strSQL := strSQL + '  CTR_CODCLI = :CODCLI AND ';
    strSQL := strSQL + '  CTR_CODEMP = :CODEMP AND';
    strSQL := strSQL + '  CTR_ESPDOC = "NF" ';
    strSQL := strSQL + 'ORDER BY ';
    strSQL := strSQL + '  CTR_NUMDUP, ';
    strSQL := strSQL + '  CTR_PARCEL  ';
    If fEmptyStr(strCodEmp) Then
      strCodEmp := VS_strCodEmp;

    With qryGenVen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('NUMDUP').AsString := fStrZero(strNumDoc,12);
      ParamByName('CODEMP').AsString := strCodEmp;
      ParamByName('CODCLI').AsString := strCliente;
      Open;

      If Not IsEmpty Then
      Begin
        SetLength(arrParcelas,RecordCount);

        For intContador := 0 To RecordCount -1 Do
        Begin
          arrParcelas[intContador].strData  := FormatDateTime('dd/mm/yy', FieldByName('CTR_DTAVEN').AsDateTime);
          arrParcelas[intContador].strValor := FloatToStrF(-FieldByName('CTR_VALORI').AsCurrency,ffNumber,15,2);
          Next;
        End;

        Result := arrParcelas;
      End;
      Close;
    End;

  Finally
    FreeAndNil(qryGenVen);
  End;

End;


end.
