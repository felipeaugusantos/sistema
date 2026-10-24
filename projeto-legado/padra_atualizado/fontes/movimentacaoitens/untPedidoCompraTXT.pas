unit untPedidoCompraTXT;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, Menus, StdCtrls, Buttons, ExtCtrls, Mask, ToolEdit,
  DirectoryEditFocus, strUtils, AppEvnts, 
  untFrameDirectoryEditFocus;

type
  TfrmPedidoCompraTXT = class(TfrmPai)
    pnlCabecalho: TPanel;
    Label1: TLabel;
    fraPatTxt: TfraDirectoryEditFocus;
    btnConfirmar: TBitBtn;
    procedure btnConfirmarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
    strPathArq : String;
    intOpcao   : Integer;
    
  end;

var
  frmPedidoCompraTXT: TfrmPedidoCompraTXT;

implementation

uses untFuncoes, untfuncoesSimples;

{$R *.dfm}

procedure TfrmPedidoCompraTXT.btnConfirmarClick(Sender: TObject);
begin
  inherited;

  Close;

end;

procedure TfrmPedidoCompraTXT.FormShow(Sender: TObject);
begin
  inherited;

  Case intOpcao Of
    2: fraPatTxt.edtDirectory.text := fCfgSis('PATPDS'); //LeftStr(fArqIniTinta(0,'SUVINIL','PATGPD',''), Length(fArqIniTinta(0,'SUVINIL','PATGPD','')) - 1);
    3: fraPatTxt.edtDirectory.text := fCfgSis('PATPDC'); //LeftStr(fArqIniTinta(0,'Coral Imobiliaria','PATGPD',''), Length(fArqIniTinta(0,'Coral Imobiliaria','PATGPD','')) - 1);
  End;

  fraPatTxt.SetFocus;
  
end;

procedure TfrmPedidoCompraTXT.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  If fEmptyStr(fraPatTxt.edtDirectory.text) Then
  Begin
    fMensagem('ATENÇÃO!','Path não pode ser nulo.',['&O K']);
    Action := caNone;
    fraPatTxt.SetFocus;
  End
  Else If DirectoryExists(fraPatTxt.edtDirectory.text) Then
  Begin
    strPathArq := fraPatTxt.edtDirectory.text;
  End
  Else
  Begin
    fMensagem('ATENÇÃO!','Path inválido.',['&O K']);
    Action := caNone;
    fraPatTxt.SetFocus;
  End;

end;

end.

