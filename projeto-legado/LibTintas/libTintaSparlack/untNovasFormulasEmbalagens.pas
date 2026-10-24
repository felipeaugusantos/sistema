unit untNovasFormulasEmbalagens;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, Grids, DBGridCitel, DBGrids, StdCtrls, AppEvnts, Buttons,
  BitBtnLockedIncrem, ExtCtrls, DB, DBClient, Menus, frxClass,
  frxExportCSVTestabilidade, UniClientDataSet;

type
  TfrmNovasFormulasEmbalagens = class(TfrmPai)
    grpEmbDif: TGroupBox;
    dbgrdEmbDif: TDBGridCitel;
    btnGravar: TBitBtnLocked;
    dsCadEmb: TDataSource;
    cdsEmbDif: TUniClientDataSet;
    cdsEmbDifSPA_CODBAS: TStringField;
    cdsEmbDifSPA_CODUNI: TStringField;
    cdsEmbDifUNI_DESUNI: TStringField;
    cdsEmbDifNFM_VOLUME: TFloatField;
    procedure btnGravarClick(Sender: TObject);
  private
    { Private declarations }
    strCodNfm: string;
    strCodBas: string;
    strProdut: string;
    procedure CarregarDados;
    procedure GravarDados;
    function fAdicionaVolumePadrao(strCodUni: String): Double;
  public
    constructor Create(AOwner: TComponent; const strCodNfm: string; const strCodBas: string; const strProdut: string); reintroduce;
  { Public declarations }
  end;

var
  frmNovasFormulasEmbalagens: TfrmNovasFormulasEmbalagens;

implementation

uses
  untIDataSet, untAutcomTintaFactory, untStrUtils;

{$R *.dfm}

{ TfrmNovasFormulasEmbalagens }

procedure TfrmNovasFormulasEmbalagens.btnGravarClick(Sender: TObject);
begin
  GravarDados;
  Close;
end;

procedure TfrmNovasFormulasEmbalagens.CarregarDados;
var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  if not TStrUtils.fEmptyStr(strCodNfm) then
  begin
    qryGen.SQL :=
      ' SELECT                                         ' +
      '     B.BAS_CODBAS                               ' +
      '   , B.BAS_CODUNI                               ' +
      '   , U.UNI_DESUNI                               ' +
      '   , IFNULL(E.NFM_VOLUME, 0.0000) AS NFM_VOLUME ' +
      ' FROM                                           ' +
      '   SPA_CADBAS B                                 ' +
      '   JOIN CADUNI U                                ' +
      '     ON U.UNI_CODUNI = BAS_CODUNI               ' +
      '   LEFT JOIN SPA_CADNFM N                       ' +
      '     ON B.BAS_CODBAS = N.NFM_BASE__             ' +
      '   LEFT JOIN SPA_NFMEMB E                       ' +
      '     ON E.NFM_CODNFM  = N.NFM_CODNFM            ' +
      '     AND E.NFM_CODBAS = N.NFM_BASE__            ' +
      '     AND E.NFM_CODUNI = B.BAS_CODUNI            ' +
      ' WHERE N.NFM_CODNFM = :CODNFM                   ' +
      '   AND N.NFM_PRODUT = :PRODUT                   ' ;
    qryGen.ParamByName('CODNFM').AsString := strCodNfm;
    qryGen.ParamByName('PRODUT').AsString := strProdut;
  end
  else
  begin
    qryGen.SQL :=
      ' SELECT B.BAS_CODBAS              ' +
      '   , B.BAS_CODUNI                 ' +
      '   , U.UNI_DESUNI                 ' +
      '   , 0.0000 AS NFM_VOLUME         ' +
      ' FROM                             ' +
      '   SPA_CADBAS B                   ' +
      '   JOIN CADUNI U                  ' +
      '     ON U.UNI_CODUNI = BAS_CODUNI ' +
      ' WHERE B.BAS_CODBAS = :CODBAS     ';
    qryGen.ParamByName('CODBAS').AsString := strCodBas;
  end;
  qryGen.Open;

  while not qryGen.Eof do
  begin
    cdsEmbDif.Insert;
    cdsEmbDif.FieldByName('SPA_CODBAS').AsString := qryGen.FieldByName('BAS_CODBAS').AsString;
    cdsEmbDif.FieldByName('SPA_CODUNI').AsString := qryGen.FieldByName('BAS_CODUNI').AsString;
    cdsEmbDif.FieldByName('UNI_DESUNI').AsString := qryGen.FieldByName('UNI_DESUNI').AsString;

    if qryGen.FieldByName('NFM_VOLUME').AsFloat <= 0.0 then
      cdsEmbDif.FieldByName('NFM_VOLUME').AsFloat := fAdicionaVolumePadrao(qryGen.FieldByName('BAS_CODUNI').AsString)
    Else
      cdsEmbDif.FieldByName('NFM_VOLUME').AsFloat := qryGen.FieldByName('NFM_VOLUME').AsFloat;

    cdsEmbDif.Post;
    qryGen.Next;
  end;

end;

constructor TfrmNovasFormulasEmbalagens.Create(AOwner: TComponent;
  const strCodNfm: string; const strCodBas: string; const strProdut: string);
begin
  inherited Create(AOwner);
  Self.strCodNfm := strCodNfm;
  Self.strCodBas := strCodBas;
  Self.strProdut := strProdut;
  cdsEmbDif.CreateDataSet;
  CarregarDados;
end;

function TfrmNovasFormulasEmbalagens.fAdicionaVolumePadrao(
  strCodUni: String): Double;
begin
  Result := 0;
  If strCodUni = 'LT' Then
    Result := 900
  Else If strCodUni = 'GL' Then
    Result := 3600
  Else If strCodUni = 'LA' Then
    Result := 18000;
end;

procedure TfrmNovasFormulasEmbalagens.GravarDados;
var
  qryGen: IDataSet;
begin
  Try
    Try
      cdsEmbDif.DisableConstraints;
      cdsEmbDif.DisableControls;

      qryGen := TAutcomTintaFactory.Get.fGetDataSet;
      qryGen.SQL := 'DELETE FROM SPA_NFMEMB WHERE NFM_CODNFM = :CODNFM';
      qryGen.ParamByName('CODNFM').AsString := strCodNfm;
      qryGen.ExecSQL;

      cdsEmbDif.First;
      TAutcomTintaFactory.Get.fInsereProCod('SPA_NFMEMB');
      while not cdsEmbDif.Eof do
      begin
        qryGen.Close;
        qryGen.SQL := TAutcomTintaFactory.Get.GetInsert('SPA_NFMEMB');
        qryGen.ParamByName('NFM_CODNFM').AsString := strCodNfm;
        qryGen.ParamByName('NFM_CODBAS').AsString := cdsEmbDif.FieldByName('SPA_CODBAS').AsString;
        qryGen.ParamByName('NFM_CODUNI').AsString := cdsEmbDif.FieldByName('SPA_CODUNI').AsString;
        qryGen.ParamByName('NFM_VOLUME').AsFloat  := cdsEmbDif.FieldByName('NFM_VOLUME').AsFloat;
        qryGen.ParamByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('SPA_NFMEMB', TAutcomTintaFactory.Get.GetCodEmp);
        qryGen.ExecSQL;
        cdsEmbDif.Next;
      end;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    cdsEmbDif.EnableConstraints;
    cdsEmbDif.EnableControls;
  End;

end;

end.
