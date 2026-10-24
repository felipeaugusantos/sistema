unit untEntAutorizacaoRedPreco;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls, Grids,
  DBGridCitel, DBGrids, DB, UniClientDataSet, Uni, BitBtnLockedIncrem, frxClass,
  frxExportCSVTestabilidade, untAlteraFornecedorEntrada;

type
  TfrmEntAutorizacaoRedPreco = class(TfrmPai)
    dtsItens: TDataSource;
    dbgItens: TDBGridCitel;
    btnAutoriz: TBitBtnLocked;
    procedure btnAutorizClick(Sender: TObject);
    procedure dbgItensKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
    FNumDoc, FEspDoc, FCodEmp, FSerie, FCodFor: String;

    blnConfirma: Boolean;

  end;

  function fAbreTelaAutorizacao(blnNotaImp: Boolean;
                                qryEntMer: TUniQuery;
                                strNumDoc,
                                strEspDoc,
                                strCodEmp,
                                strSerie,
                                strCodFor,
                                strNaoAtu: String;
                                objAtuFor: TAlteraFornecedorEntrada;
                                dtaDtaEnt: TDateTime;
                                blnPrecoPraticado,
                                blnConEqu: Boolean;
                                fltCotDol: Double;
                                blnEncargosNoFrete: Boolean): Boolean; Overload;

  function fAbreTelaAutorizacao(cdsItens: TUniClientDataSet;
                                strNumDoc,
                                strEspDoc,
                                strCodEmp,
                                strSerie,
                                strCodFor: String): Boolean; Overload;

var
  frmEntAutorizacaoRedPreco: TfrmEntAutorizacaoRedPreco;

implementation

uses untFuncoesSimples, untPcmGer;

{$R *.dfm}

procedure TfrmEntAutorizacaoRedPreco.btnAutorizClick(Sender: TObject);
begin
  inherited;

  If Not btnAutoriz.Enabled Then
    Exit;

  If fLiberaPrecoMedio(dtsItens.DataSet, FNumDoc, FEspDoc, FCodEmp, FSerie, FCodFor) Then
  Begin
    blnConfirma := True;
    Close;
  End;
end;

function fAbreTelaAutorizacao(blnNotaImp: Boolean;
                              qryEntMer: TUniQuery;
                              strNumDoc,
                              strEspDoc,
                              strCodEmp,
                              strSerie,
                              strCodFor,
                              strNaoAtu: String;
                              objAtuFor: TAlteraFornecedorEntrada;
                              dtaDtaEnt: TDateTime;
                              blnPrecoPraticado,
                              blnConEqu: Boolean;
                              fltCotDol: Double;
                              blnEncargosNoFrete: Boolean): Boolean;
  Var
    cdsItens: TUniClientDataSet;
    blnErro: Boolean;
begin
  Try
    Result := True;

    {If Not fCfgSis('ATPRAU', varBoolean) Then
       Exit;
     REMOVIDO ->  Req: 279690 - ESSA CONFIGURAÇÃO SÓ FUNCIONA QUANDO A OUTRA CONFIGURAÇÃO: "CFG_ATPRAU - Atualizar preços do cadastro de produtos automaticamente?"
     ESTA ATIVA (SIM) DEVEMOS REMOVER ESSE VINCULO ENTRE AS CONFIGURAÇÕES, ONDE A "CFG_OSCMED" VAI FUNCIONAR INDEPENDENTE DE QUALQUER OUTRA CFG. }

    cdsItens := fVerificaItensAbaixoPrecoMedio(blnNotaImp,
                                               qryEntMer,
                                               strCodFor,
                                               strCodEmp,
                                               strEspDoc,
                                               strNaoAtu,
                                               dtaDtaEnt,
                                               blnErro,
                                               blnPrecoPraticado,
                                               blnConEqu,
                                               objAtuFor,
                                               fltCotDol,
                                               blnEncargosNoFrete);

    If blnErro Then
    Begin
      Result := False;
      FreeAndNil(cdsItens);
      Exit;
    End;

    {*****************************************}
    {* CASO NÃO TENHA NENHUM ITEM, SAI       *}
    {**************************************MV*}
    If (cdsItens.IsEmpty) Then
    Begin
      FreeAndNil(cdsItens);
      Exit;
    End;

    pCriarFormularios(TfrmEntAutorizacaoRedPreco, frmEntAutorizacaoRedPreco);

    With frmEntAutorizacaoRedPreco Do
    Begin
      dtsItens.DataSet := cdsItens;

      FNumDoc := strNumdoc;
      FEspDoc := strEspDoc;
      FCodEmp := strCodEmp;
      FCodFor := strCodFor;
      FSerie  := strSerie;
    End;

    frmEntAutorizacaoRedPreco.ShowModal;

    Result := frmEntAutorizacaoRedPreco.blnConfirma;

    FreeAndNil(frmEntAutorizacaoRedPreco);

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[pAbreTelaAutorizacao]');
    End;
  End;

  FreeAndNil(cdsItens);
end;

function fAbreTelaAutorizacao(cdsItens: TUniClientDataSet;
                                    strNumDoc,
                                    strEspDoc,
                                    strCodEmp,
                                    strSerie,
                                    strCodFor: String): Boolean;

begin
  Try
    Result := True;

    If (cdsItens.IsEmpty) Then
      Exit;
    

    pCriarFormularios(TfrmEntAutorizacaoRedPreco, frmEntAutorizacaoRedPreco);

    With frmEntAutorizacaoRedPreco Do
    Begin
      dtsItens.DataSet := cdsItens;

      FNumDoc := strNumdoc;
      FEspDoc := strEspDoc;
      FCodEmp := strCodEmp;
      FCodFor := strCodFor;
      FSerie  := strSerie;
    End;

    frmEntAutorizacaoRedPreco.ShowModal;

    Result := frmEntAutorizacaoRedPreco.blnConfirma;

    FreeAndNil(frmEntAutorizacaoRedPreco);

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[pAbreTelaAutorizacao]');
    End;
  End;

end;

procedure TfrmEntAutorizacaoRedPreco.dbgItensKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If Key = VK_ESCAPE Then
    btnSair.Click;
end;

procedure TfrmEntAutorizacaoRedPreco.FormCreate(Sender: TObject);
begin
  inherited;

   blnConfirma := False;
end;

procedure TfrmEntAutorizacaoRedPreco.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If key = VK_F10 Then
    btnAutoriz.Click;
end;

procedure TfrmEntAutorizacaoRedPreco.FormShow(Sender: TObject);
begin
  inherited;

  pSetFocus(dbgItens);
end;

end.
