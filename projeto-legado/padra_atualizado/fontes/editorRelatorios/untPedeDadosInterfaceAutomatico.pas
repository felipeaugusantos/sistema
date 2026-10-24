unit untPedeDadosInterfaceAutomatico;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, Vcl.Mask, Vcl.DBCtrls, DBEditFocus,
  DBMemoFocus, BCEditor.Editor.Base, BCEditor.Editor, Data.DB,
  untInterfaceRelatorio;

type
  TfrmPedeDadosInterfaceAutomatico = class(TfrmPaiConfirma)
    pnlDadosGerais: TPanel;
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    dbeNomPar: TDBEditFocus;
    dbeDesPar: TDBEditFocus;
    pnlVisible: TPanel;
    Panel3: TPanel;
    bceSQLVIS: TBCEditor;
    Panel4: TPanel;
    dbeExpVis: TDBMemoFocus;
    dtsCadPar: TDataSource;
    pnlNomPar: TPanel;
    btnPrior: TBitBtnLocked;
    btnNext: TBitBtnLocked;
    Label3: TLabel;
    dbeGruFil: TDBEditFocus;
    lblExpImp: TLabel;
    dbeEXPIMP: TDBMemoFocus;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure btnPriorClick(Sender: TObject);
    procedure btnNextClick(Sender: TObject);
  private
    { Private declarations }

    Function fSalvaDados: Boolean;

    procedure pDadosToTela;

  public
    { Public declarations }
    strNomPar: String;

    objInterface: TInterfaceRelatorio;

  protected

    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

var
  frmPedeDadosInterfaceAutomatico: TfrmPedeDadosInterfaceAutomatico;

implementation

{$R *.dfm}

Uses
  StrUtils,
  untFuncoesSimples;

Function TfrmPedeDadosInterfaceAutomatico.fSalvaDados: Boolean;
Var
  intRecNo: Integer;
  strExpVis,
  strExpImp,
  strSqlVis: String;
Begin
  dtsCadPar.DataSet.DisableControls;
  intRecNo := dtsCadPar.DataSet.RecNo;

  strExpVis := dbeExpVis.Text;
  strExpImp := dbeExpImp.Text;
  strSqlVis := bceSQLVIS.Text;

  If fVerificaCampos And
     objInterface.fCompilaExpressao(strExpVis, 'Expressão que torna o parâmetro visível', True) And
     objInterface.fCompilaExpressao(strExpImp, 'Expressão que torna a impressão do filtro visível', True) Then
  Begin

    If dtsCadPar.DataSet.State In dsEditModes Then
    Begin
      dtsCadPar.DataSet.RecNo := intRecNo;
      dtsCadPar.DataSet.Edit;
      dtsCadPar.DataSet.FieldByName('PAR_EXPVIS').AsString := strExpVis;
      dtsCadPar.DataSet.FieldByName('PAR_EXPIMP').AsString := strExpImp;
      dtsCadPar.DataSet.FieldByName('PAR_SQLVIS').AsString := AnsiReplaceStr(strSqlVis, #13#10, '<<csq>>');
      dtsCadPar.DataSet.Post;
    End;

    Result := True;

  End Else
  Begin

    Result := False;

  End;
  dtsCadPar.DataSet.EnableControls;
End;

procedure TfrmPedeDadosInterfaceAutomatico.btnNextClick(Sender: TObject);
  Var
    intIndice: Integer;
    strCampo: String;
begin
  inherited;

  If fSalvaDados Then
  Begin
    intIndice := objInterface.fNomeToIndexTabelaDinamica(dtsCadPar.DataSet.FieldByName('PAR_NOMPAR').AsString);

    If intIndice < MAX_TABELAS_DINAMICAS Then
      Inc(intIndice)
    Else
      intIndice := 1;

    strCampo := strNomPar;

    If intIndice > 1 Then
      strCampo := strCampo + '_' + intIndice.ToString();

    objInterface.cdsParametrosAutomaticos.FindKey([strCampo]);

    pDadosToTela;
  End;
end;

procedure TfrmPedeDadosInterfaceAutomatico.btnPriorClick(Sender: TObject);
  Var
    intIndice: Integer;
    strCampo: String;
begin
  inherited;

  If fSalvaDados Then
  Begin
    intIndice := objInterface.fNomeToIndexTabelaDinamica(dtsCadPar.DataSet.FieldByName('PAR_NOMPAR').AsString);

    If intIndice > 1 Then
      Dec(intIndice)
    Else
      intIndice := MAX_TABELAS_DINAMICAS;

    strCampo := strNomPar;

    If intIndice > 1 Then
      strCampo := strCampo + '_' + intIndice.ToString();

    objInterface.cdsParametrosAutomaticos.FindKey([strCampo]);

    pDadosToTela;
  End;
end;

procedure TfrmPedeDadosInterfaceAutomatico.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  If ModalResult = mrOk Then
  Begin

    If Not fSalvaDados Then
      Action := caNone;

  End;

end;

procedure TfrmPedeDadosInterfaceAutomatico.FormCreate(Sender: TObject);
begin
  inherited;

  TInterfaceRelatorio.pAjustaEditorSQL(bceSQLVIS);
end;

procedure TfrmPedeDadosInterfaceAutomatico.pDadosToTela;
Begin
  bceSQLVIS.Text := AnsiReplaceStr(dtsCadPar.DataSet.FieldByName('PAR_SQLVIS').AsString, '<<csq>>', #13#10);
End;

procedure TfrmPedeDadosInterfaceAutomatico.FormShow(Sender: TObject);
begin
  inherited;

  btnPrior.Visible := Pos(strNomPar, 'INVENTARIO-LOTES-ESTOQUE_EXTERNO-SALINV-ENVIADO_TERCEIROS-RECEBIDO_TERCEIROS') > 0;
  btnNext.Visible  := btnPrior.Visible;

  pDadosToTela;
end;

function TfrmPedeDadosInterfaceAutomatico.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean;
begin

  Result := True;

  If (inherited fValidaCampos(Sender)) Then
  Begin


  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

end.
