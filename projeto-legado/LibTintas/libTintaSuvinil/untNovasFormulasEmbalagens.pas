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
    cdsEmbDifSUV_CODFML: TStringField;
    cdsEmbDifSUV_CODBAS: TStringField;
    cdsEmbDifSUV_CODUNI: TStringField;
    cdsEmbDifUNI_DESUNI: TStringField;
    cdsEmbDifNFM_VOLUME: TFloatField;
    procedure btnGravarClick(Sender: TObject);
  private
    { Private declarations }
    strCodNfm: string;
    strCodBas: string;
    strCodFml: string;
    procedure CarregarDados;
    procedure GravarDados;
    function fAdicionaVolumePadrao(strCodUni: String): Double;
  public
    constructor Create(AOwner: TComponent; const strCodNfm: string; const strCodBas: string; const strCodFml: string); reintroduce;
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
      '   B.SUV_CODFML                                 ' +
      '   , B.SUV_CODBAS                               ' +
      '   , B.SUV_CODUNI                               ' +
      '   , U.UNI_DESUNI                               ' +
      '   , IFNULL(E.NFM_VOLUME, 0.0000) AS NFM_VOLUME ' +
      ' FROM                                           ' +
      '   SUV_CADBAS B                                 ' +
      '   JOIN CADUNI U                                ' +
      '     ON U.UNI_CODUNI = SUV_CODUNI               ' +
      '   LEFT JOIN SUV_CADNFM N                       ' +
      '     ON B.SUV_CODFML = N.NFM_CODPRO             ' +
      '     AND B.SUV_CODBAS = N.NFM_BASE__            ' +
      '   LEFT JOIN SUV_NFMEMB E                       ' +
      '     ON E.NFM_CODNFM = N.NFM_CODNFM             ' +
      '     AND E.NFM_CODFML = N.NFM_CODPRO            ' +
      '     AND E.NFM_CODBAS = N.NFM_BASE__            ' +
      '     AND E.NFM_UNIDAD = B.SUV_CODUNI            ' +
      ' WHERE N.NFM_CODNFM = :CODNFM                   ';
    qryGen.ParamByName('CODNFM').AsString := strCodNfm;
  end
  else
  begin
    qryGen.SQL :=
      ' SELECT                           ' +
      '   B.SUV_CODFML                   ' +
      '   , B.SUV_CODBAS                 ' +
      '   , B.SUV_CODUNI                 ' +
      '   , U.UNI_DESUNI                 ' +
      '   , 0.0000 AS NFM_VOLUME         ' +
      ' FROM                             ' +
      '   SUV_CADBAS B                   ' +
      '   JOIN CADUNI U                  ' +
      '     ON U.UNI_CODUNI = SUV_CODUNI ' +
      ' WHERE B.SUV_CODFML = :CODFML     ' +
      '   AND B.SUV_CODBAS = :CODBAS     ';
    qryGen.ParamByName('CODFML').AsString := strCodFml;
    qryGen.ParamByName('CODBAS').AsString := strCodBas;
  end;
  qryGen.Open;

  while not qryGen.Eof do
  begin
    cdsEmbDif.Insert;
    cdsEmbDif.FieldByName('SUV_CODFML').AsString := qryGen.FieldByName('SUV_CODFML').AsString;
    cdsEmbDif.FieldByName('SUV_CODBAS').AsString := qryGen.FieldByName('SUV_CODBAS').AsString;
    cdsEmbDif.FieldByName('SUV_CODUNI').AsString := qryGen.FieldByName('SUV_CODUNI').AsString;
    cdsEmbDif.FieldByName('UNI_DESUNI').AsString := qryGen.FieldByName('UNI_DESUNI').AsString;
    if qryGen.FieldByName('NFM_VOLUME').AsFloat <= 0.0 then
      cdsEmbDif.FieldByName('NFM_VOLUME').AsFloat := fAdicionaVolumePadrao(qryGen.FieldByName('SUV_CODUNI').AsString)
    Else
      cdsEmbDif.FieldByName('NFM_VOLUME').AsFloat := qryGen.FieldByName('NFM_VOLUME').AsFloat;
    cdsEmbDif.Post;
    qryGen.Next;
  end;

end;

constructor TfrmNovasFormulasEmbalagens.Create(AOwner: TComponent;
  const strCodNfm: string; const strCodBas: string; const strCodFml: string);
begin
  inherited Create(AOwner);
  Self.strCodNfm := strCodNfm;
  Self.strCodBas := strCodBas;
  Self.strCodFml := strCodFml;
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
      qryGen.SQL := 'DELETE FROM SUV_NFMEMB WHERE NFM_CODNFM = :CODNFM';
      qryGen.ParamByName('CODNFM').AsString := strCodNfm;
      qryGen.ExecSQL;

      cdsEmbDif.First;
      TAutcomTintaFactory.Get.fInsereProCod('SUV_NFMEMB');
      while not cdsEmbDif.Eof do
      begin
        qryGen.Close;
        qryGen.SQL := TAutcomTintaFactory.Get.GetInsert('SUV_NFMEMB');
        qryGen.ParamByName('NFM_CODNFM').AsString := strCodNfm;
        qryGen.ParamByName('NFM_CODFML').AsString := strCodFml; //cdsEmbDif.FieldByName('SUV_CODFML').AsString;
        qryGen.ParamByName('NFM_CODBAS').AsString := strCodBas; //cdsEmbDif.FieldByName('SUV_CODBAS').AsString;
        qryGen.ParamByName('NFM_UNIDAD').AsString := cdsEmbDif.FieldByName('SUV_CODUNI').AsString;
        qryGen.ParamByName('NFM_VOLUME').AsFloat  := cdsEmbDif.FieldByName('NFM_VOLUME').AsFloat;
        qryGen.ParamByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('SUV_NFMEMB', TAutcomTintaFactory.Get.GetCodEmp);
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
