unit untRecebedorMaterialVidro;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, EditFocus, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridCitel, cxGrid, cxCurrencyEdit, Uni;

type
  TfrmRecebedorMaterialVidro = class(TfrmPai)
    Panel1: TPanel;
    lblOperador: TLabel;
    btnConfirmar: TBitBtnLocked;
    dtsDados: TDataSource;
    cxDados: TcxGridCitel;
    cxgDados: TcxGridDBTableViewCitel;
    cxgDadosCODITE: TcxGridDBColumn;
    cxgDadosDESITE: TcxGridDBColumn;
    cxgDadosREFERE: TcxGridDBColumn;
    cxgDadosSIGUNI: TcxGridDBColumn;
    cxgDadosQTDBAI: TcxGridDBColumn;
    cxlDados: TcxGridLevel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
  private
   FstrCodOpe: String;
   blnSenhaValida: Boolean;
   qryConOpe: TUnIQuery;
   procedure pInicia;
    { Private declarations }
  public

   class function fPedeSenhaOperador(strCodOpe: String; DataSet: TDataSet): Boolean;
    { Public declarations }
  end;

var
  frmRecebedorMaterialVidro: TfrmRecebedorMaterialVidro;

implementation

uses
  untFuncoesSimples;

{$R *.dfm}

procedure TfrmRecebedorMaterialVidro.btnConfirmarClick(Sender: TObject);
begin
  If (ffrmSenha(strSenha)) Then
  Begin
    If (strSenha <> fDecrypt(qryConOpe.FieldByName('OPE_SENOPE').AsString)) Then
    Begin
      fMensagem('ATENÇÃO!', 'Senha Inválida!', ['&O k']);
      blnSenhaValida := False;
    End
    Else
    Begin
      blnSenhaValida := True;
      Close;
    End;

  End
  Else
  begin
    blnSenhaValida := False;
    Close;
  End

end;

procedure TfrmRecebedorMaterialVidro.FormCreate(Sender: TObject);
begin
  inherited;
   qryConOpe := fCriaQuery;
end;

procedure TfrmRecebedorMaterialVidro.FormDestroy(Sender: TObject);
begin
  FreeAndNil(qryConOpe);
  inherited;
end;

class function TfrmRecebedorMaterialVidro.fPedeSenhaOperador(
  strCodOpe: String; DataSet: TDataSet): Boolean;
begin
  pCriarFormularios(TfrmRecebedorMaterialVidro, frmRecebedorMaterialVidro);
  Try
    frmRecebedorMaterialVidro.FstrCodOpe :=  strCodOpe;
    frmRecebedorMaterialVidro.pInicia;
    frmRecebedorMaterialVidro.lblOperador.Caption := 'Operador: ' +
                                                     frmRecebedorMaterialVidro.qryConOpe.FieldByName('OPE_CODOPE').AsString + ' - ' +
                                                     frmRecebedorMaterialVidro.qryConOpe.FieldByName('OPE_NOMOPE').AsString;
    frmRecebedorMaterialVidro.dtsDados.DataSet := DataSet;
    frmRecebedorMaterialVidro.ShowModal;
    Result := frmRecebedorMaterialVidro.blnSenhaValida;
  Finally
    FreeAndNil(frmRecebedorMaterialVidro);
  End

end;

procedure TfrmRecebedorMaterialVidro.pInicia;
begin
  blnSenhaValida := True;
  qryConOpe.SQL.Text := 'SELECT * FROM CADOPE WHERE OPE_CODOPE = "'+FstrCodOpe+'"';
  qryConOpe.Open;

end;

end.
