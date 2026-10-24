unit untPnlDadosCadLote;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, UniClientDataSet, ExtCtrls, Uni,
  DB, BitBtnLockedIncrem;

type
  TfrmPnlDadosCadLote = class(TForm)
    btnMostraEstoque: TBitBtnLocked;
    lblAvsVal: TLabel;
    grpLegenda: TGroupBox;
    ShapeChapa: TShape;
    LabelChapa: TLabel;
    ShapeMenorPrecoVenda: TShape;
    LabelMenorPrecoVenda: TLabel;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnMostraEstoqueClick(Sender: TObject);
  private
    FCodIte: String;
    FEspDoc: String;

    procedure SetCodIte(const Value: String);
    procedure SetEspDoc(const Value: String);

    function fLoteComFabricacaoInformada: Boolean;
    { Private declarations }
  public
    { Public declarations }
    cdsConsulta: TUniClientDataSet;

    property strCodIte : String read FCodIte write SetCodIte;
    property strEspDoc : String read FEspDoc write SetEspDoc;
  end;
TfrmPnlDadosCadLoteClass = Class Of TfrmPnlDadosCadLote;
var
  frmPnlDadosCadLote: TfrmPnlDadosCadLote;

implementation

uses untFuncoesSimples, untFuncoesRel, untFuncoesRel2;

{$R *.dfm}

procedure TfrmPnlDadosCadLote.btnMostraEstoqueClick(Sender: TObject);
begin

  If Not btnMostraEstoque.Visible Then
    Exit;

  If Assigned(prcExecutaRelatorio) Then
  begin
    prcExecutaRelatorio(209, 7647, [7723,7724,7725,7726],
                      ['CODITE','NUMLOT'],
                      [FCodIte,
                      cdsConsulta.FieldByName('LOT_NUMLOT').AsString],
                      Sender,
                      ['CODITE','NUMLOT'],
                      True);
  End;

end;

function TfrmPnlDadosCadLote.fLoteComFabricacaoInformada: Boolean;
  Var
    qryDados : TUniQuery;
begin
  qryDados := fCriaQuery;

  With qryDados Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT COUNT(*) CNT ');
    SQL.Add('  FROM CADLOT ');
    SQL.Add(' WHERE LOT_CODITE = :CODITE ');
    SQL.Add('   AND LOT_DTAFAB IS NOT NULL ');
    ParamByName('CODITE').AsString := FCodIte;
    Open;
    Result := (FieldByName('CNT').AsInteger > 0);
    Close;
  End;

  FreeAndNil(qryDados);
end;

procedure TfrmPnlDadosCadLote.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_F6 : Begin
              btnMostraEstoque.Click;
              Key := 0;
            End;
  end;
end;

procedure TfrmPnlDadosCadLote.SetCodIte(const Value: String);
begin
  FCodIte := Value;
  lblAvsVal.Visible := fLoteComFabricacaoInformada;

  LabelChapa.Visible := (fCfgSis('MARMOR', varBoolean)) and (fCfgSis('CTRLCH', varBoolean));
  ShapeChapa.Visible := LabelChapa.Visible;
end;

procedure TfrmPnlDadosCadLote.SetEspDoc(const Value: String);
begin
  FEspDoc := Value;

  LabelMenorPrecoVenda.Visible := Pos(FEspDoc, 'PD_OR_VN_') > 0;
  ShapeMenorPrecoVenda.Visible := LabelMenorPrecoVenda.Visible;
end;

end.
