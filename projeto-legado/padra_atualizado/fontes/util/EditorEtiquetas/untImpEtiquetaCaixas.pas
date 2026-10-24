unit untImpEtiquetaCaixas;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, Vcl.ExtCtrls, EditFocus, untTypesSistema;

type
  TfrmImpEtiquetaCaixas = class(TfrmPai)
    lblEmpresa: TLabel;
    edtEAN39: TEditFocus;
    edtQtde: TEditFocus;
    Label1: TLabel;
    btnImprimir: TBitBtnLocked;
    rdgTipEti: TRadioGroup;
    procedure btnImprimirClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    procedure pAddEAN39(strEAN39: String);
    { Private declarations }
  public
    { Public declarations }
    arrEAN39: TStringArray;
  end;

var
  frmImpEtiquetaCaixas: TfrmImpEtiquetaCaixas;

implementation

{$R *.dfm}

uses untFuncoesSimples;

procedure TfrmImpEtiquetaCaixas.FormCreate(Sender: TObject);
var strCxSeq: String ;
begin
  inherited;
  strCxSeq := fCampoTabela('SIS_VALCFG', 'CFGSIS', ['SIS_CODCFG','SIS_CODEMP' ], ['CFG_PRO_CX', VS_strCodEmp]);
  edtEAN39.Text := 'CXSEQ' + fStrZero( strCxSeq , 8) ;
end;

procedure TfrmImpEtiquetaCaixas.pAddEAN39(strEAN39:String);
begin
  SetLength(arrEAN39, Length(arrEAN39) + 1);
  arrEAN39[High(arrEAN39)] := strEAN39;
end;

procedure TfrmImpEtiquetaCaixas.btnImprimirClick(Sender: TObject);
var  intQuantidade,
     intContador: Integer;
     strEAN39,
     strTrava: String;
begin
  inherited;

  intQuantidade := StrToInt(edtQtde.Text);
  If intQuantidade > 0 Then
  Begin
    strTrava := 'ETIQUETA_CAIXA_' + VS_strCodEmp;

    if not fLock_Unlock(strTrava, True, False) Then
    Begin
      fMensagem('ATENÇÃO!', 'Este recurso está sendo utilizado por outra estação: ' + fGetHostLock(strTrava), ['&Ok']);
      Exit;
    End;

    For intContador := 1 To intQuantidade Do
    Begin
      repeat
        strEAN39 := 'CXSEQ' + fStrZero(fRetSequencial('PRO_CX', VS_strCodEmp), 8) ;
      until fValidaCaixaCodBar(strEAN39);

      pAddEAN39(strEAN39);
      edtEAN39.Text := strEAN39;

    End;

    fLock_Unlock(strTrava, False, False);

    ModalResult := mrOk;
  End
  Else
    fMensagem('Atenção', 'Quantidade Inválida', ['&Ok']);
end;

end.
