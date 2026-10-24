unit untRelFatEtiqProdAcabados;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frxClass, frxDBSet, frxBarcode, DB, 
   Uni, MemDS, DBAccess;

type
  TfrmRelFatEtiqProdAcabados = class(TForm)
    frxReport: TfrxReport;
    frxBarCodeObject1: TfrxBarCodeObject;
    frxProdutos: TfrxDBDataset;
    qryProdutos: TUniQuery;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure pImprimirEtiqProdAcabados(strCodAca: String);
  end;


implementation

uses StrUtils, untFuncoesSimples;

{$R *.dfm}

{ TfrmRelFatEtiqProdAcabados }

procedure TfrmRelFatEtiqProdAcabados.pImprimirEtiqProdAcabados(strCodAca: String);
  Var
    strNomeFila: String;
    strTipImp: String;
    intContador: Integer;
    strSalto: String;
    qryCfgRel: TUniQuery;
begin

  If fEmptyStr(strCodAca) Then
    Exit;

  strSalto := '';
  If fCfgSis('QTDSAL', varInteger) > 0 Then
  Begin
    For intContador := 1 To fCfgSis('QTDSAL', varInteger) Do
    Begin
      strSalto := strSalto + '       ' + #13#10;
    End;
  End;


  qryCfgRel := fCriaQuery;
  pCarregaConfImpr(qryCfgRel, 'frmFatVendas_PROACA');
  fPreImpressao(qryCfgRel, strNomeFila, strTipImp, False);
  FreeAndNil(qryCfgRel);

  qryProdutos.Close;
  qryProdutos.SQL.Clear;
  qryProdutos.SQL.Add('SELECT                                           ');
  qryProdutos.SQL.Add('  CONCAT(ACA_CODITE, "-", ACA_DESCRI) AS DESCRI, ');
  qryProdutos.SQL.Add('  ACA_CODBAR AS CODBAR                           ');
  qryProdutos.SQL.Add('FROM                                             ');
  qryProdutos.SQL.Add('  CADACA                                         ');
  qryProdutos.SQL.Add('WHERE                                            ');
  qryProdutos.SQL.Add('  ACA_CODACA IN (' + strCodAca + ')              ');
  qryProdutos.SQL.Add('ORDER BY                                         ');
  qryProdutos.SQL.Add('  ACA_CODACA                                     ');

  qryProdutos.Open;

  frxReport.Script.Variables['SALTO'] := strSalto;

  If (Not fEmptyStr(strNomeFila)) Then
  Begin
    frxReport.PrintOptions.Printer    := AnsiReplaceText(strNomeFila, '\\' + fRetNomeRede + '\', '');
    frxReport.PrintOptions.ShowDialog := False;
  End
  Else
  Begin
    frxReport.PrintOptions.ShowDialog := True;
  End;

  If (frxReport.PrepareReport) Then
    pPrintReport(Self.Name, Self.Caption, strNomeFila, frxReport);

end;

end.
