unit untModuloRelDASMetasClientes;

interface

uses
  SysUtils, Classes, frxExportRTF, frxDesgn, frxClass,
  frxExportXLS, frxExportHTML, frxExportPDF, frxDMPExport, frxDBSet;

type
  TfrmModuloRelDASMetasClientes = class(TDataModule)
    frxRelatorio: TfrxDBDataset;
    frxMatricial: TfrxDotMatrixExport;
    frxExpPDF: TfrxPDFExport;
    frxExpHtml: TfrxHTMLExport;
    frxExpXLS: TfrxXLSExport;
    frxDesigner: TfrxDesigner;
    frxExpRTF: TfrxRTFExport;
    frxAnaliticoM: TfrxReport;
    frxConRec: TfrxDBDataset;
    frxMarPra: TfrxDBDataset;
    frxSinteticoM: TfrxReport;
    frxAnaliticoJ: TfrxReport;
    frxSinteticoJ: TfrxReport;
    frxUserGen: TfrxUserDataSet;
    procedure DataModuleCreate(Sender: TObject);
    function frxAnaliticoMUserFunction(const MethodName: string;
      var Params: Variant): Variant;
    procedure DataModuleDestroy(Sender: TObject);
    procedure frxUserGenGetValue(const VarName: string; var Value: Variant);
  private
    { Private declarations }
    stlProcessados: TStringList;
    fltTotProcessado: Double;
    procedure pIniciaProcessamento;
    procedure pProcessaCliente(strCodCli: String; fltValFat: Double);
  public
    { Public declarations }
  end;

var
  frmModuloRelDASMetasClientes: TfrmModuloRelDASMetasClientes;

implementation


{$R *.dfm}

uses untFuncoesFactory, untIFuncoes;

procedure TfrmModuloRelDASMetasClientes.DataModuleCreate(Sender: TObject);
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

  frxAnaliticoM.AddFunction('function fCalculaPrecoVenda(fltTotCus, fltTotVen: Double): Double');
  frxSinteticoM.AddFunction('function fCalculaPrecoVenda(fltTotCus, fltTotVen: Double): Double');

  frxAnaliticoM.AddFunction('procedure pIniciaProcessamento');
  frxSinteticoM.AddFunction('procedure pIniciaProcessamento');

  frxAnaliticoM.AddFunction('procedure pProcessaCliente(strCodCli: String; fltValFat: Double)');
  frxSinteticoM.AddFunction('procedure pProcessaCliente(strCodCli: String; fltValFat: Double)');

  frxAnaliticoJ.AddFunction('function fCalculaPrecoVenda(fltTotCus, fltTotVen: Double): Double');
  frxSinteticoJ.AddFunction('function fCalculaPrecoVenda(fltTotCus, fltTotVen: Double): Double');

  frxAnaliticoJ.AddFunction('procedure pIniciaProcessamento');
  frxSinteticoJ.AddFunction('procedure pIniciaProcessamento');

  frxAnaliticoJ.AddFunction('procedure pProcessaCliente(strCodCli: String; fltValFat: Double)');
  frxSinteticoJ.AddFunction('procedure pProcessaCliente(strCodCli: String; fltValFat: Double)');

  stlProcessados := TStringList.Create;
end;

procedure TfrmModuloRelDASMetasClientes.DataModuleDestroy(Sender: TObject);
begin
  FreeAndNil(stlProcessados);
end;

function TfrmModuloRelDASMetasClientes.frxAnaliticoMUserFunction(
  const MethodName: string; var Params: Variant): Variant;
begin
  If SameText(MethodName, 'fCalculaPrecoVenda') Then
    Result := fCalculaPrecoVenda(2, Params[0],Params[1], 0,0,0,0,0);

  If SameText(MethodName, 'pIniciaProcessamento') Then
    pIniciaProcessamento;

  If SameText(MethodName, 'pProcessaCliente') Then
    pProcessaCliente(Params[0], Params[1]);
end;

procedure TfrmModuloRelDASMetasClientes.frxUserGenGetValue(
  const VarName: string; var Value: Variant);
begin
  If SameText(VarName, 'TOTREP') then
    Value := fltTotProcessado;
end;

procedure TfrmModuloRelDASMetasClientes.pIniciaProcessamento;
begin
  stlProcessados.Clear;
  fltTotProcessado := 0;
end;

procedure TfrmModuloRelDASMetasClientes.pProcessaCliente(strCodCli: String;
  fltValFat: Double);
begin
  If stlProcessados.IndexOf(strCodCli) = -1 Then
  Begin
    stlProcessados.Add(strCodCli);
    fltTotProcessado := fltTotProcessado + fltValFat;
  End;
end;

end.
