unit untEntDivergenciaOscilacao;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, AppEvnts, Menus, StdCtrls, Buttons, BitBtnLockedIncrem,
  ExtCtrls, Grids, DBGridCitel, DBGrids, untPaiConfirma, UniClientDataSet, DB,
  frxClass, frxExportCSVTestabilidade, untLiberacao, untMsgLiberacao;


type
  TfrmEntDivergenciaOscilacao = class(TfrmPaiConfirma)
    dbgItens: TDBGridCitel;
    procedure FormCreate(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    FCdsItens : TUniClientDataSet;
    FDtsItens : TDataSource;
    strForDec : String;
    objLiberacao : TLiberacao;
  public
    function fAddItemDivergente(strDesIte : String; fltVlrPed, fltVlrDig : Double) : Boolean;
    function fValidaUsuario : Boolean;
  end;

var
  frmEntDivergenciaOscilacao: TfrmEntDivergenciaOscilacao;

implementation

uses  untPai, untFuncoesSimples, untFuncFat, untTypesSistema;

{$R *.dfm}

procedure TfrmEntDivergenciaOscilacao.btnConfirmaClick(Sender: TObject);
var
  objTabela : TRegistroMsgLiberaTabela;
	objLinha  : TLinhaMsgLibera;
begin
  objLiberacao.Clear;
  objLiberacao.objMsgLibera.pAddTexto('Os seguintes itens estão fora do limite de oscilação de preços:');

  With FCdsItens Do
  Begin
    FCdsItens.First;
    FCdsItens.DisableControls;

    objTabela := TRegistroMsgLiberaTabela.Create;

    objLinha  := TLinhaMsgLibera.Create;
    objLinha.enuTipoLinha := tlCabecalho;
    objLinha.pAddColuna(''  , 'Item'           , 40 , alEsquerda , teAutcom);
    objLinha.pAddColuna(''  , 'Valor Pedido'   , 10 , alEsquerda , teAutcom);
    objLinha.pAddColuna(''  , 'Valor Digitado' , 10 , alEsquerda   , teAutcom);
    objTabela.lstLinhas.Add(objLinha);

    While not Eof Do
    Begin

      objLinha  := TLinhaMsgLibera.Create;
      objLinha.enuTipoLinha := tlValor;
      objLinha.pAddColuna('Item'           , FieldByName('DESITE').AsString                        , 40 , alEsquerda , teAutcom);
      objLinha.pAddColuna('Valor Pedido'   , FormatFloat(strForDec, FieldByName('VLRPED').AsFloat) , 10 , alEsquerda , teAutcom);
      objLinha.pAddColuna('Valor Digitado' , FormatFloat(strForDec, FieldByName('VLRDIG').AsFloat) , 10 , alEsquerda   , teAutcom);
      objTabela.lstLinhas.Add(objLinha);

      Next;
    End;

    objLiberacao.objMsgLibera.lstRegistros.Add(objTabela);

    FCdsItens.First;
    FCdsItens.EnableControls;
  End;

  objLiberacao.strDirAce := 'LIBOSC';
  objLiberacao.strMsgSen := 'Entrada de Mercadorias';
  objLiberacao.blnMosMen := True;
  objLiberacao.strCodOpe := strLoginUsuarioLogado;

  If (Not objLiberacao.fLibera) Then
    Exit;

  ModalResult := MrOk;


  inherited;

end;

function TfrmEntDivergenciaOscilacao.fAddItemDivergente(strDesIte: String;
  fltVlrPed, fltVlrDig: Double): Boolean;
begin
  Try
    With FCdsItens Do
    Begin
      Insert;

      FieldByName('DESITE').AsString := strDesIte;
      FieldByName('VLRPED').AsFloat := fltVlrPed;
      FieldByName('VLRDIG').AsFloat := fltVlrDig;

      Post;
      Result := True;
    End;
  Except
    On E : Exception Do
    Begin
      pMensagensErro(e.Message, '[TfrmEntDivergenciaOscilacao.fAddItemDivergente]');
      Result := False;
    End;

  End;
end;

procedure TfrmEntDivergenciaOscilacao.FormCreate(Sender: TObject);
begin
  inherited;
  FCdsItens := TUniClientDataSet.Create(Self);
  With FCdsItens Do
  Begin
    With FieldDefs.AddFieldDef Do
    Begin
      Name := 'DESITE';
      DataType := ftString;
      Size := 80;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name := 'VLRPED';
      DataType := ftFloat;
    End;

    With FieldDefs.AddFieldDef Do
    Begin
      Name := 'VLRDIG';
      DataType := ftFloat;
    End;

    CreateDataSet;

    strForDec := '#,##0.' + fPadL('', fCfgSis('DECUNI', varInteger), '0');
    TFloatField(FieldByname('VLRPED')).DisplayFormat := strForDec;
    TFloatField(FieldByname('VLRDIG')).DisplayFormat := strForDec;

    Open;

  End;

  FDtsItens := TDataSource.Create(Self);
  FDtsItens.DataSet := FCdsItens;

  dbgItens.DataSource := FDtsItens;

  objLiberacao := TLiberacao.create;

end;

procedure TfrmEntDivergenciaOscilacao.FormDestroy(Sender: TObject);
begin

  if assigned(objLiberacao) then
    freeandnil(objLiberacao);
  inherited;

end;

function TfrmEntDivergenciaOscilacao.fValidaUsuario: Boolean;
begin
  If FCdsItens.RecordCount <= 0 Then
  Begin
    Result := True;
    Exit;
  End;

  Result := (frmEntDivergenciaOscilacao.ShowModal = mrOK);

end;

end.
