unit untEntMostraImprimeLista;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiEdit, AppEvnts, Menus, StdCtrls, Buttons, BitBtnLockedIncrem,
  ExtCtrls, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, cxDataStorage,
  cxEdit, DB, cxDBData, cxGridLevel, cxClasses, cxControls, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid, cxCheckBox,
  untEntImprimeLista, untFuncoesSimples, cxLookAndFeels, cxLookAndFeelPainters, cxNavigator, frxClass, frxExportCSVTestabilidade,
  cxDataControllerConditionalFormattingRulesManagerDialog, untLiberacao, untMsgLiberacao;

type
  TfrmEntMostraImprimeLista = class(TfrmPaiEdit)
    btnConfirma: TBitBtnLocked;
    cxgItensView: TcxGridDBTableView;
    cxgItensLevel1: TcxGridLevel;
    cxgItens: TcxGrid;
    cxgItensViewCODITE: TcxGridDBColumn;
    cxgItensViewDESITE: TcxGridDBColumn;
    cxgItensViewIMPLIS: TcxGridDBColumn;
    btnMarcaTodos: TBitBtnLocked;
    btnDesmarcaTodos: TBitBtnLocked;
    procedure btnMarcaTodosClick(Sender: TObject);
    procedure btnDesmarcaTodosClick(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    blnConfirmou: Boolean;
    objLiberacao : TLiberacao;
  public
    { Public declarations }
    objImpLis: TEntImprimeLista;
  end;

var
  frmEntMostraImprimeLista: TfrmEntMostraImprimeLista;

implementation

{$R *.dfm}

Uses
  untFuncFat, untTypesSistema;
  
procedure TfrmEntMostraImprimeLista.btnConfirmaClick(Sender: TObject);
  Var
    blnSalvar: Boolean;
    strDireitos : String;
begin
  inherited;

  If objImpLis.State = dsEdit Then
    objImpLis.Post;

  If objImpLis.ChangeCount = 0 Then
  Begin
    blnConfirmou := True;
    Close;
    Exit;
  End;

  If fPergunta('Confirma a alteração dos itens?') Then
  Begin

    strDireitos := '';
    fValidarDirEspecificos(strDireitos, strLoginUsuarioLogado, 'frmCadProdutos');

    If Pos('A', strDireitos) <= 0 Then
    Begin
      objLiberacao.Clear;
      objLiberacao.objMsgLibera.pAddTexto('Alteração de itens: "Imprime Lista"');

      objLiberacao.strDirAce := 'SENELI';
      objLiberacao.strMsgSen := 'Alteração Imprime Lista';
      objLiberacao.strCodOpe := strLoginUsuarioLogado;

      blnSalvar := objLiberacao.fLibera;

    End

    Else blnSalvar := True;


    If blnSalvar And objImpLis.fGravaLista Then
    Begin
      pMensagemOk('Operação realizada com sucesso!');
      blnConfirmou := True;
      Close;
    End;

  End;

end;

procedure TfrmEntMostraImprimeLista.btnDesmarcaTodosClick(Sender: TObject);
begin
  inherited;

  objImpLis.pMarcaTodos('N');

end;

procedure TfrmEntMostraImprimeLista.btnMarcaTodosClick(Sender: TObject);
begin
  inherited;

  objImpLis.pMarcaTodos('S');
end;

procedure TfrmEntMostraImprimeLista.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  If (Not blnConfirmou) Then
  Begin

    If Not fPergunta('Deseja abandonar a tarefa?') Then
      Action := caNone;

  End;  

end;

procedure TfrmEntMostraImprimeLista.FormCreate(Sender: TObject);
begin
  inherited;
  objLiberacao := TLiberacao.Create;
  blnConfirmou := False;
end;

procedure TfrmEntMostraImprimeLista.FormDestroy(Sender: TObject);
begin
  inherited;
  if Assigned(objLiberacao) then
    FreeAndNil(objLiberacao);
end;

procedure TfrmEntMostraImprimeLista.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_F6 : btnMarcaTodos.Click;
    VK_F7 : btnDesmarcaTodos.Click;
    VK_F10: btnConfirma.Click;
  End;
  
end;

procedure TfrmEntMostraImprimeLista.FormShow(Sender: TObject);
begin
  inherited;

  cxgItensView.DataController.DataSource := objImpLis.dtsSource;
end;

end.
