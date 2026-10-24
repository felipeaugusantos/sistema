unit untBaixaInformaOrdProd;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, EditFocus, untTypesSistema, untFuncoesSimples, untConsultas,
  Vcl.Mask, MaskEditFocus, Uni;

type
  TfrmBaixaInformaOrdProd = class(TfrmPaiConfirma)
    Label1: TLabel;
    edDataOP: TMaskEditFocus;
    edtNumOP: TEditFocus;
    procedure btnConfirmaClick(Sender: TObject);
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    procedure edtNumOPKeyPress(Sender: TObject; var Key: Char);
  private

    FstrComponenteA: String;
    FstrComponenteB: String;
    FCodigoItem    : String;
    { Private declarations }
  public

    property strComponenteA: String read FstrComponenteA write FstrComponenteA;
    property strComponenteB: String read FstrComponenteB write FstrComponenteB;
    property strCodigoItem : String read FCodigoItem     write FCodigoItem;

    { Public declarations }
  end;

var
  frmBaixaInformaOrdProd: TfrmBaixaInformaOrdProd;

implementation

{$R *.dfm}

procedure TfrmBaixaInformaOrdProd.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  if fVerificaCampos then
    ModalResult := mrOk;
end;

procedure TfrmBaixaInformaOrdProd.edtNumOPKeyPress(Sender: TObject;
  var Key: Char);
Var
    arrTabela: TConsultasArray;
    intOpcStatus : TStateOPI;
begin
  intOpcStatus:= staTodas;

  If fPesqOrdProIndustrial(Self, edtNumOP, edDataOP, Nil, Key, arrTabela, poiCodigo, True, intOpcStatus, '', '', FstrComponenteA, FstrComponenteB, FCodigoItem) Then
  Begin
    If fValidaCampos(edtNumOp, True) And
       fValidaCampos(edDataOP, True) Then
    Begin
      pSetFocus(edDataOP);
    End;
  End;
end;


function TfrmBaixaInformaOrdProd.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
  var
    qryConsulta: TUniQuery;
begin
  Result := True;


  If (Sender = edtNumOP) Then
  Begin
    If fEmptyStr(edtNumOP.Text) Then
    Begin
      fMensagem('ATENÇÃO!', 'Informe o número da OP!', ['&Ok']);
      Result := False;
    End
  End;

  If (Sender = edDataOP) Then
  Begin
    If fEmptyDate(edDataOP.Text) Then
    Begin
      fMensagem('ATENÇÃO!', 'Informe a data da OP!', ['&Ok']);
      Result := False;
    End

    Else
    Begin
      qryConsulta:= fCriaQuery(Self);
      Try
        qryConsulta.Close;
        qryConsulta.SQL.Clear;
        qryConsulta.SQL.Add('SELECT * FROM ORDGER ');
        qryConsulta.SQL.Add('   INNER JOIN CADITE ON ORD_CODITE = ITE_CODITE ');
        qryConsulta.SQL.Add('                  WHERE ORD_CODORD = :CODORD');
        qryConsulta.SQL.Add('                    AND ORD_DTACAD = :DTACAD');
        qryConsulta.SQL.Add('                    AND ORD_CODEMP = :CODEMP');

        qryConsulta.ParamByName('CODEMP').AsString  := VS_strCodEmp;
        qryConsulta.ParamByName('CODORD').AsString  := edtNumOP.Text;
        qryConsulta.ParamByName('DTACAD').AsDateTime:= StrToDate(edDataOP.Text);

        If FstrComponenteA = 'S' Then
        Begin
          qryConsulta.SQL.Add('  AND ITE_COMPNB = "S" ');
          qryConsulta.SQL.Add('  AND ITE_CODITE = "'+strCodigoItem+'" ');
        End;

        If FstrComponenteB = 'S' Then
        Begin
          qryConsulta.SQL.Add('  AND ITE_COMPNA = "S" ');
          qryConsulta.SQL.Add('  AND ITE_CODITB = "'+strCodigoItem+'" ');
        End;

        qryConsulta.Open;

        If (qryConsulta.IsEmpty) Then
        Begin
          Result := False;
          pMensagemOk('Ordem de Produção não encontrada!');
        End;

      Finally
        FreeAndNil(qryConsulta);
      End;

    End;
  End;

  if Result = False then
    pSetFocus(Sender);
end;


end.
