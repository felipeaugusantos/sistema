unit untConsultaCadBzaDinamica;

interface

uses
  SysUtils, Classes, Controls, Forms, untConsultaComp, DB, 
  Uni, BitBtnLockedIncrem,
  ExtCtrls, StdCtrls, ComCtrls, Buttons, Grids, DBGridCitel, DBGrids, UniClientDataSet,
  MemDS, DBAccess;

type
  TfrmConsultaCadBzaDinamica = class(TfrmConsultaComp)
    procedure FormShow(Sender: TObject);
    procedure edtFiltro1Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtFiltro1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnExecutaTarefaClick(Sender: TObject);
  private
    procedure pDesabilitaColunas;
    procedure pAplicaMascara;
    procedure pCalculaDados;

    procedure pAtualizaDados(Data: TDataSet);
    { Private declarations }
  public
    procedure pAtuIndice(intIndice: Integer); override;
    { Public declarations }
  end;

var
  frmConsultaCadBzaDinamica: TfrmConsultaCadBzaDinamica;

implementation

uses untBrasimixAutomotivaDinamica, untConsulta, untFuncoesSimples,untIConfTinta, untTintaMaquina, untClientDataSetFactory;

{$R *.dfm}

procedure TfrmConsultaCadBzaDinamica.FormShow(Sender: TObject);
begin
  inherited;
  blnRestauraGrid := False;
end;

procedure TfrmConsultaCadBzaDinamica.edtFiltro1Change(Sender: TObject);
begin
  inherited;
  pDesabilitaColunas;
  pCalculaDados;
end;

procedure TfrmConsultaCadBzaDinamica.FormCreate(Sender: TObject);
begin
  inherited;
  qryConsulta.AfterScroll := pAtualizaDados;
end;

procedure TfrmConsultaCadBzaDinamica.edtFiltro1KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  pDesabilitaColunas;
end;

procedure TfrmConsultaCadBzaDinamica.pAplicaMascara;
begin

end;

procedure TfrmConsultaCadBzaDinamica.pAtualizaDados(Data: TDataSet);
begin
  pAplicaMascara;
  pCalculaDados;
end;

procedure TfrmConsultaCadBzaDinamica.pCalculaDados;
begin

end;

procedure TfrmConsultaCadBzaDinamica.pDesabilitaColunas;
begin
  pAplicaMascara;
end;

procedure TfrmConsultaCadBzaDinamica.pAtuIndice(intIndice: Integer);
begin
  inherited;
  pDesabilitaColunas;
  {*****************************************}
  {* RETORNA A CONEXÃO COM O GRID          *}
  {**************************************MV*}
  //dtsConsulta.DataSet := qryConsulta;
  qryConsulta.EnableControls;
  pAplicaMascara;
  pCalculaDados;
end;

procedure TfrmConsultaCadBzaDinamica.btnExecutaTarefaClick(
  Sender: TObject);
var
  qryConsulta: TUniQuery;
  strTipEmb     : String;
  intQtdEmb     : Integer;
  strIteEmb     : String;
  strTipPre     : String;
  fltPreEmb     : Double;
  fltEmbala     : Double;
  fltPreCus     : Double;
  fltPreVen     : Double;
  strIteTin     : String;
  strMontad     : String;
  strA_n_o_     : String;
  stlDesEmb     : TStringList;
  stlProEmbLt   : TStringList;
  stlProEmbGl   : TStringList;

  strProEmbCo   : String;
  strProEmbSp   : String;

  fltVolPro     : Double;
  conf: IConfTinta;
  cdsConsulta: TUniClientDataSet;
begin
  stlDesEmb := nil;
  qryConsulta := nil;
  Try
    Try
      If (Not qryConsulta.Active) Or (qryConsulta.IsEmpty) Then
        Exit;

      conf := fGetConfTinta('BZA');

      stlDesEmb := TStringList.Create;
      stlDesEmb.Add('SINTETICO');
      stlDesEmb.Add('LACA');
      stlDesEmb.Add('POLIESTER');
      stlDesEmb.Add('P. U.');
      stlDesEmb.Add('EPOXI');

      qryConsulta := fCriaQuery(Self);
      qryConsulta.SQL.Add('SELECT * FROM BZA_CADBZA WHERE AUTOINCREM = :AUTINC');
      qryConsulta.ParamByName('AUTINC').AsString := qryConsulta.FieldByName('AUTOINCREM').AsString;
      cdsConsulta := TClientDataSetFactory.GetClientDataSet(qryConsulta);

      strIteTin := qryConsulta.FieldByName('BZA_CODSEQ').AsString;
      strMontad := qryConsulta.FieldByName('BZA_MONTAD').AsString;
      strA_n_o_ := qryConsulta.FieldByName('BZA_A_N_O_').AsString;

      stlProEmbGl :=  TStringList.Create;
      stlProEmbLt :=  TStringList.Create;

      stlProEmbGl.Add(conf.fGet('BZAIGL'));
      stlProEmbGl.Add(conf.fGet('BZAGLA'));
      stlProEmbGl.Add(conf.fGet('BZAGPO'));
      stlProEmbGl.Add(conf.fGet('BZAGPU'));
      stlProEmbGl.Add(conf.fGet('BZAGPE'));

      stlProEmbLt.Add(conf.fGet('BZAIEM'));
      stlProEmbLt.Add(conf.fGet('BZALLA'));
      stlProEmbLt.Add(conf.fGet('BZALPO'));
      stlProEmbLt.Add(conf.fGet('BZALPU'));
      stlProEmbLt.Add(conf.fGet('BZALPE'));

      strProEmbCo := conf.fGet('BZACOP');
      strProEmbSp := conf.fGet('BZASPR');

      If Not fDigDadosTintometricos(cdsConsulta, stlDesEmb, stlProEmbLt, stlProEmbGl,
                                    strProEmbCo, strProEmbSp,
                                    strIteEmb, strTipEmb, strTipPre, intQtdEmb, fltPreEmb, fltEmbala,
                                    fltPreCus, fltPreVen, fltVolPro, '1', TDicionario.Create) Then
        Exit;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(stlDesEmb) then FreeAndNil(stlDesEmb);
    if Assigned(qryConsulta) then FreeAndNil(qryConsulta);
  End;
end;

end.

