unit untCadCarteiraDigital;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiCad, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls, Vcl.Buttons,
  Vcl.StdCtrls, BitBtnLockedIncrem, Vcl.ExtCtrls, Data.DB, Vcl.Mask,
  Vcl.DBCtrls, DBEditFocus, MemDS, DBAccess, Uni;

type
  TfrmCadCarteiraDigital = class(TfrmPaiCad)
    Label1: TLabel;
    dbeCodigo: TDBEditFocus;
    Label2: TLabel;
    dbeDescri: TDBEditFocus;
    dtsCarDig: TDataSource;
    Label3: TLabel;
    dbeOrdem_: TDBEditFocus;
    procedure FormCreate(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
  private
    { Private declarations }
    function fGeraSeqOrdenacao:integer ;
  public
    { Public declarations }
  protected
    procedure pInicializaIndices; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

implementation

uses untFuncoesSimples, untConsultas, untTypesSistema;

{$R *.dfm}

{ TfrmCadCarteiraDigital }

procedure TfrmCadCarteiraDigital.btnIncluirClick(Sender: TObject);
begin
  inherited;
  dbeOrdem_.Field.AsInteger := fGeraSeqOrdenacao ;
  pSetFocus(dbeCodigo) ;
end;

procedure TfrmCadCarteiraDigital.btnPesquisaClick(Sender: TObject);
Var
  chrKey: Char;
  arrEvento: TConsultasArray;
begin
  chrKey := '/';
  If fPesqCarteiraDigital(Self, Nil, Nil, qryTabela, chrKey, arrEvento) Then
  Begin
    pSetFocus(btnAlterar);
  End;
end;

function TfrmCadCarteiraDigital.fGeraSeqOrdenacao: integer;
var
  LqryExec: TUniQuery ;
begin
  LqryExec := fCriaQuery() ;
  try
    LqryExec.SQL.Clear ;
    LqryExec.SQL.Add('SELECT MAX(DIG_ORDEM_) FROM CARDIG') ;
    LqryExec.Open ;

    Result := LqryExec.Fields.Fields[0].AsInteger + 1 ;
  finally
    FreeAndNil(LqryExec) ;
  end ;
end;

procedure TfrmCadCarteiraDigital.FormCreate(Sender: TObject);
begin
  inherited;
  strNomeTabela     := 'CARDIG';
  strNomeCampo      := 'DIG_CARDSE';
  qryTabela         := fCriarQuery('SELECT * FROM CARDIG', Self);
  dtsCarDig.DataSet := qryTabela;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodigo;

end;

function TfrmCadCarteiraDigital.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
 Result := True;
  If (inherited fValidaCampos(Sender)) Then
  Begin
    If (Sender = dbeCodigo) Then
    Begin
      If fEmptyStr(dbeCodigo.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Código CardSE deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else If (blnBuscaPorChave) Then
      Begin
        If Not fBuscaPorCamposChave Then
          pLimparCampos;
      End;
    End

    Else If (Sender = dbeDescri) Then
    Begin
      If fEmptyStr(dbeDescri.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Descrição da Carteira Digital deve ser preenchido!', ['&Ok']);
        Result := False;
      End;
    End;
  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

procedure TfrmCadCarteiraDigital.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('DIG_CARDSE');
  stlCampos.Add('DIG_DESCRI');
  stlCampos.Add('DIG_ORDEM_');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('DIG_DESCRI');
  stlCamInd.Add('DIG_CARDSE');

  stlDesInd.Add('Descrição');
  stlDesInd.Add('Código CardSE');
end;

end.
