unit untConsultaCadFarDinamicaGeral;

interface

uses
  SysUtils, Classes, Controls, Forms, untConsultaComp, DB, 
  Uni, BitBtnLockedIncrem,
  ExtCtrls, StdCtrls, ComCtrls, Buttons, Grids, DBGridCitel, DBGrids, UniClientDataSet,
  MemDS, DBAccess;

type
  TfrmConsultaCadFarDinamicaGeral = class(TfrmConsultaComp)
    procedure edtFiltro1Change(Sender: TObject);
    procedure edtFiltro1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure btnExecutaTarefaClick(Sender: TObject);
  private
    { Private declarations }
    procedure pDesabilitaColunas;
  protected
    procedure pAtuIndice(intIndice: Integer); override;
  public
    { Public declarations }
  end;

var
  frmConsultaCadFarDinamicaGeral: TfrmConsultaCadFarDinamicaGeral;

implementation

uses untFuncoesSimples, untFarbenAutomotivaDinamica, untIConfTinta, untTintaMaquina,untClientDataSetFactory;

{$R *.dfm}

procedure TfrmConsultaCadFarDinamicaGeral.edtFiltro1Change(
  Sender: TObject);
begin
  inherited;
  pDesabilitaColunas;
end;

procedure TfrmConsultaCadFarDinamicaGeral.edtFiltro1KeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  pDesabilitaColunas;
end;

procedure TfrmConsultaCadFarDinamicaGeral.FormShow(Sender: TObject);
begin
  inherited;
  blnRestauraGrid := False;
end;

procedure TfrmConsultaCadFarDinamicaGeral.pAtuIndice(intIndice: Integer);
begin
  inherited;
  pDesabilitaColunas;
  qryConsulta.EnableControls;
end;

procedure TfrmConsultaCadFarDinamicaGeral.pDesabilitaColunas;
begin
  qryConsulta.FieldByName('AUTOINCREM').Visible := False;
  qryConsulta.FieldByName('FAR_CODEMP').Visible := False;
end;

procedure TfrmConsultaCadFarDinamicaGeral.btnExecutaTarefaClick(
  Sender: TObject);
var
  qryGen: TUniQuery;
  stlDesEmb: TStringList;
  stlProEmbLt: TStringList;
  stlProEmbGl: TStringList;
  strIteEmb: String;
  strTipEmb: String;
  strTipPre: String;
  intQtdEmb: Integer;
  fltPreEmb: Double;
  fltEmbala: Double;
  fltPreCus: Double;
  fltUnitar: Double;
  fltVolPro: Double;
  strProEmbCo   : String;
  strProEmbSp   : String;
  strProEmbTb   : String;
  strProEmbSy   : String;
  conf: IConfTinta;
  cdsGen: TUniClientDataSet;
begin
  inherited;
  If (Not qryConsulta.Active) Or (qryConsulta.IsEmpty) Then
    Exit;

  qryGen := nil;
  stlDesEmb := nil;
  stlProEmbLt := nil;
  stlProEmbGl := nil;
  Try
    Try
      conf := fGetConfTinta('FAR');

      qryGen := fCriaQuery(Self);
      qryGen.SQL.Add('SELECT * FROM FAR_CADFAR WHERE AUTOINCREM = :AUTINC');
      qryGen.ParamByName('AUTINC').AsString := qryConsulta.FieldByName('AUTOINCREM').AsString;
      cdsGen := TClientDataSetFactory.GetClientDataSet(qryGen);

      stlDesEmb   := TStringList.Create;
      stlProEmbLt := TStringList.Create;
      stlProEmbGl := TStringList.Create;

      stlDesEmb.Add('NORMAL');
      stlProEmbLt.Add(conf.fGet('FARPLT'));
      stlProEmbGl.Add(conf.fGet('FARPGL'));

      strProEmbCo := conf.fGet('FARPCP');
      strProEmbSp := conf.fGet('FARPSP');
      strProEmbTb := conf.fGet('FARPTB');
      strProEmbSy := conf.fGet('FARPSY');

      fDigDadosTintometricos(cdsGen, stlDesEmb, stlProEmbLt, stlProEmbGl, strIteEmb, strTipEmb, strTipPre,
        intQtdEmb, fltPreEmb, fltEmbala, fltPreCus, fltUnitar, fltVolPro, '1', TDicionario.Create,
        strProEmbCo, strProEmbSp, strProEmbTb,strProEmbSy);
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(qryGen) then FreeAndNil(qryGen);
    if Assigned(stlDesEmb) then FreeAndNil(stlDesEmb);
    if Assigned(stlProEmbLt) then FreeAndNil(stlProEmbLt);
    if Assigned(stlProEmbGl) then FreeAndNil(stlProEmbGl);
  End;
end;

end.

