unit untRelRcxReciboCob;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, frxClass, frxDBSet, untFuncoesSimples,untFastPrintEditor,
  untValorPorExtenso, Uni, UniClientDataSet,untRelQckRcxReciboCob,Data.DB;

type
  TfrmRelRcxReciboCob = class(TForm)
    frxReciboCobranca: TfrxReport;
    frxDBRecCobEmpresa: TfrxDBDataset;
    frxDBReciboCobranca: TfrxDBDataset;
    procedure FormCreate(Sender: TObject);
    function frxReciboCobrancaUserFunction(const MethodName: string;
      var Params: Variant): Variant;
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    FEmpresaLogada: TUniQuery;
  public
    { Public declarations }
    function fImprimirReciboCobranca(cdsRelCtr : TUniClientDataSet = Nil; strCodCli : String = '') : Boolean;
  end;

var
  frmRelRcxReciboCob: TfrmRelRcxReciboCob;

implementation

{$R *.dfm}

function TfrmRelRcxReciboCob.fImprimirReciboCobranca(
  cdsRelCtr: TUniClientDataSet; strCodCli: String): Boolean;
  Var
    editorFast: TFastPrintFileEditor;
    reciboCtrCob : TRelQckRcxReciboCob;
    blnEmpty : Boolean;
    Index: TIndexDef; //MF: 290025 - 16/06/23
begin
  Result := False;
  editorFast := TFastPrintFileEditor.Create(Self);
  reciboCtrCob  := TRelQckRcxReciboCob.CreateInstance(cdsRelCtr,strCodCli);
  reciboCtrCob.ModoProducao := True;
  editorFast.pSetFastPrintFile(reciboCtrCob);
  blnEmpty := reciboCtrCob.IsEmpty;

  If Not blnEmpty Then
  Begin
    If editorFast.fLoadReport Then
    Begin
      If (editorFast.FrxReport.FindObject('memOrdem') <> nil) Then //MF: 290025 - 16/06/23
      Begin
        cdsRelCtr.IndexDefs.Clear;
        Index := cdsRelCtr.IndexDefs.AddIndexDef;
        Index.Name   := 'IDXREP';
        Index.Fields := TfrxMemoView(editorFast.FrxReport.FindObject('memOrdem')).Text;

        cdsRelCtr.IndexName := 'IDXREP';
      End;

      editorFast.pConfigPrinter;
      editorFast.pPrint;
      Result := True;
    End;
  End;

  FreeAndNil(editorFast);
end;

procedure TfrmRelRcxReciboCob.FormCreate(Sender: TObject);
begin
  frxReciboCobranca.AddFunction('function fValorPorExtenso(Valor : String):String;');
  frxReciboCobranca.AddFunction('function fRetNomCidade(strCodigo: String; intOpcao: Integer = 0): String;');


  FEmpresaLogada := fCriaQuery(Nil);
  fCadEmp('NOMEMP', FEmpresaLogada);

  frxDBRecCobEmpresa.DataSet := FEmpresaLogada;

  Self.frxReciboCobranca.Variables.Clear;
  Self.frxReciboCobranca.Script.Variables['OPELIB']  := fRetNomeOperador(strLoginUsuarioLogado);
  fAtuCfgSis( 'CONREC', IIF( fCfgSisL('CONREC') = '', fStrZero( '1', 6), fStrZero( IntToStr( fCfgSisL('CONREC', varInteger) + 1 ), 6) ) );
  Self.frxReciboCobranca.Script.Variables['CONREC']  :=  'RECIBO DE COBRANCA No - ' + fCfgSisL('CONREC') + ' - ' + VS_strCodEmp;
  Self.frxReciboCobranca.Script.Variables['DATA']  := AnsiUpperCase(fRetDataExtenso(VS_Date,True))

end;

procedure TfrmRelRcxReciboCob.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FEmpresaLogada);
end;

function TfrmRelRcxReciboCob.frxReciboCobrancaUserFunction(
  const MethodName: string; var Params: Variant): Variant;
begin
  If SameText('fValorPorExtenso', MethodName) Then
    Result := fValorPorExtenso(Params[0]);
  If SameText('fRetNomCidade', MethodName) Then
    Result := fRetNomCidade(Params[0],Params[1]);
end;

end.
