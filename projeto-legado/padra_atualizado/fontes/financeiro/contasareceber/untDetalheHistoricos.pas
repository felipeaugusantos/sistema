unit untDetalheHistoricos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.StdCtrls, Vcl.DBCtrls,
  DBMemoFocus, Vcl.ExtCtrls, frxClass, frxExportCSVTestabilidade, Vcl.AppEvnts,
  Vcl.Menus, Vcl.Buttons, BitBtnLockedIncrem, MemoFocus, Uni, untFuncoesSimples,
  System.StrUtils;

type
  TfrmDetalheHistoricos = class(TfrmPai)
    pnlHistorico: TPanel;
    mmoHistorico: TMemoFocus;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure mmoHistoricoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    qryHistorico : TUniQuery;
    procedure pCriarTemporaria;
    function fGetSql : String;
    procedure pCarregaHistorico;
  public
    { Public declarations }
    strAutoIncrem : String;
  end;

implementation

{$R *.dfm}

{ THistórico }

function TfrmDetalheHistoricos.fGetSql: String;
begin
  Result := '';
  Result := Result +  'SELECT                             ';
  Result := Result +  '  CONCAT(CTB_HIST01,"<<csq>>",CTB_HIST02) AS HISTORICO  ';
  Result := Result +  'FROM                               ';
  Result := Result +  '  CADREC                           ';
  Result := Result +  '  lEFT JOIN MOVBAN                 ';
  Result := Result +  '    ON CTR_DOCBAI = CTB_SEQLAN     ';
  Result := Result +  'WHERE                              ';
  Result := Result +  '  CADREC.AUTOINCREM = :AUTOINC     ';
end;

procedure TfrmDetalheHistoricos.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  FreeAndNil(qryHistorico);
end;

procedure TfrmDetalheHistoricos.FormCreate(Sender: TObject);
begin
  inherited;
  qryHistorico := fCriaQuery(Nil);
end;

procedure TfrmDetalheHistoricos.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If Key = VK_ESCAPE Then
    btnSair.Click;
end;

procedure TfrmDetalheHistoricos.FormShow(Sender: TObject);
begin
  inherited;
  pCriarTemporaria;
end;

procedure TfrmDetalheHistoricos.mmoHistoricoKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If Key = VK_ESCAPE Then
    btnSair.Click;
end;

procedure TfrmDetalheHistoricos.pCarregaHistorico;
begin
  mmoHistorico.Text := AnsiReplaceStr(qryHistorico.FieldByName('HISTORICO').AsString, '<<csq>>', #13#10);
end;

procedure TfrmDetalheHistoricos.pCriarTemporaria;
begin
  Try
    qryHistorico.Close;
    qryHistorico.Sql.Clear;
    qryHistorico.Sql.Add(fGetSql);
    qryHistorico.ParamByName('AUTOINC').AsString := strAutoIncrem;
    qryHistorico.Open;
    If Not qryHistorico.IsEmpty Then
    Begin
      pCarregaHistorico;
    End;
  Except
    On E: Exception Do
        pMensagensErro(E.Message, '[THistórico.pCriarTemporaria]');
  End;
end;

end.
