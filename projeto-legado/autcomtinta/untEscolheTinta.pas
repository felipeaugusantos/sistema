unit untEscolheTinta;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls, cxStyles,
  cxCustomData, cxGraphics, cxFilter, cxData, cxDataStorage, cxEdit, DB,
  cxDBData, cxGridLevel, cxClasses, cxControls, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  UniClientDataSet, StrUtils, cxImage, BitBtnLockedIncrem,
  cxLookAndFeels, cxLookAndFeelPainters, cxNavigator, frxClass, frxExportCSVTestabilidade,Uni, Datasnap.DBClient,
  cxDataControllerConditionalFormattingRulesManagerDialog;

type
  TfrmEscolheTinta = class(TfrmPai)
    dbgViewTintasDisponiveis: TcxGridDBTableView;
    dbgLvlTintasDisponiveis: TcxGridLevel;
    dbgTintasDisponiveis: TcxGrid;
    cdsTintasDisponiveis: TUniClientDataSet;
    dtsTintasDisponiveis: TDataSource;
    dbgViewTintasDisponiveisIDEPRO: TcxGridDBColumn;
    dbgViewTintasDisponiveisDESCRI: TcxGridDBColumn;
    cxstylrpstryFonte: TcxStyleRepository;
    cxstylFonte: TcxStyle;
    cdsTintasDisponiveisIDEPRO: TStringField;
    cdsTintasDisponiveisDESCRI: TStringField;
    pnlImagem: TPanel;
    imgLogo: TImage;
    btnConfirma: TBitBtnLocked;
    dbgViewTintasDisponiveisVERDTA: TcxGridDBColumn;
    cdsTintasDisponiveisVERDTA: TStringField;
    procedure FormCreate(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure dbgViewTintasDisponiveisKeyPress(Sender: TObject;
      var Key: Char);
    procedure cdsTintasDisponiveisAfterScroll(DataSet: TDataSet);
    procedure FormActivate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    FstrIdePro: String;
    blnProAca,
    blnCampanha,
    blnIniciou: Boolean;
    FCarregaLogos: Boolean;

    procedure pCarregar;
    function fRetornaClienteFilial(strCodCli : String ) : Boolean;
    procedure pVerificaTintasDllDiretorio;
    procedure pSetaProAca;
    function fRetornaVersaoData(strIdePro: String): String;

    { Private declarations }
  public
    property strIdePro: String read FstrIdePro;
    { Public declarations }

    Constructor Create(Owner: TComponent; blnProAca: Boolean; blnCampanha: Boolean); reintroduce; overload;
  end;

  function fMostraMenu:Boolean;
  function fEscolheTinta(strCodCli : String = ''; blnProAca: Boolean = True; blnCampanha: Boolean = False): ShortString; stdcall;
  function fGetListaTintas(strCodCli : String = ''; blnProAca: Boolean = True; blnCampanha: Boolean = False): TStringList; stdcall;

var
  frmEscolheTinta: TfrmEscolheTinta;
  sCodCli: String;

implementation

uses
  untFuncoesSimples, untTintaMaquina,untITintasDeMaquina, untVerificadorTintaExistente;

{$R *.dfm}

procedure TfrmEscolheTinta.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(dbgTintasDisponiveis);
end;

procedure TfrmEscolheTinta.FormCreate(Sender: TObject);
  Var
    strPathOpcoes: String;
begin
  inherited;
  FstrIdePro := '';
  pSetaProAca;
  strPathOpcoes := ExtractFilePath(Application.ExeName);
  If (Not AnsiEndsText('auttin', strPathOpcoes)) And (Not AnsiEndsText('auttin\', strPathOpcoes)) Then
    strPathOpcoes := strPathOpcoes + '\auttin\';

  strPathOpcoes := strPathOpcoes + 'opcoestinta.ini';
  pCarregar;
end;

procedure TfrmEscolheTinta.FormShow(Sender: TObject);
begin
  inherited;
  FCarregaLogos := True;
end;

procedure TfrmEscolheTinta.pCarregar;
  Var
    intCont: Integer;
    iTintas: ITintasDeMaquina;
begin
  cdsTintasDisponiveis.CreateDataSet;

  iTintas := fGetTintasdeMaquina;

  For intCont := 0 To iTintas.fGetQtdTintas - 1 Do
  Begin
    If Not (blnCampanha And (Pos(iTintas.fGetIdePro(intCont),iTintas.fGetAutomotivas)>0)) Then
    Begin
      If ((iTintas.fEstaDisponivel(intCont)) And (iTintas.fGetNomeTinta(intCont) <> '')) Then
      begin
        If (fCfgSis('HABACA') = 'S') and (fRetornaClienteFilial(sCodCli)) Then
        begin
           If (iTintas.fGetIdePro(intCont) = 'ACA') Then
             cdsTintasDisponiveis.AppendRecord([iTintas.fGetIdePro(intCont), iTintas.fGetNomeTinta(intCont), fRetornaVersaoData(iTintas.fGetIdePro(intCont))]);
        end
        else
        begin
          If ((iTintas.fGetIdePro(intCont) = 'ACA') And blnProAca) Or
            (iTintas.fGetIdePro(intCont) <> 'ACA') Then
          cdsTintasDisponiveis.AppendRecord([iTintas.fGetIdePro(intCont), iTintas.fGetNomeTinta(intCont), fRetornaVersaoData(iTintas.fGetIdePro(intCont))]);
        end;
      end;
    End;
  End;

  //Foi pedido para que se a tinta estiver disponivel no CFGTIN e nao
  //estiver no diretorio auttin\tintas mostrar mensagem que a dll da tinta nao esta no diretorio.
  pVerificaTintasDllDiretorio;

  cdsTintasDisponiveis.First;
end;

procedure TfrmEscolheTinta.pVerificaTintasDllDiretorio;
var
  qryUsaTin: TUniQuery;
begin
  Try
    qryUsaTin := fCriaQuery;

    With qryUsaTin Do
    Begin
      Close;
      SQL.Clear;
      SQL.Text := 'SELECT CFG_IDEPRO, CFG_VALCFG FROM CFGTIN WHERE CFG_CODEMP = :CODEMP AND CFG_CODCFG = "USATIN" AND CFG_VALCFG = "S"';
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      Open;

      If Not IsEmpty Then
      Begin
        First;
        While Not Eof Do
        Begin
          //Se estiver utilizando no cfgtin e nao adicionou na lista para vender entao a dll da tinta especifica nao esta na pasta
          If (FieldByName('CFG_VALCFG').AsString = 'S') And (Not cdsTintasDisponiveis.Locate('IDEPRO', FieldByName('CFG_IDEPRO').AsString, [])) Then
          Begin
            IsTintaExistente(FieldByName('CFG_IDEPRO').AsString);
          End;

          Next;
        End;
      End;
    End;
  Finally
    FreeAndNil(qryUsaTin);
  End;
end;

function fMostraMenu:Boolean;
Var
  blnMostraMenu: Boolean;
Begin
  blnMostraMenu := True;

  If (fCfgSis('TIPTIN') = '2') Then
  Begin
    If (fMensagem('', 'Escolha o tipo de Tinta:', ['&Imobiliaria', '&Automotiva']) = 1) Then
      blnMostraMenu := False;
  End;

  Result := blnMostraMenu;
End;

function fEscolheTinta(strCodCli : String = ''; blnProAca: Boolean = True; blnCampanha: Boolean = False): ShortString; stdcall;
begin
  sCodCli := strCodCli;

  If fMostraMenu then
  Begin
    Try
      frmEscolheTinta := TfrmEscolheTinta.Create(Nil, blnProAca, blnCampanha);
      frmEscolheTinta.ShowModal;

      Result := ShortString(frmEscolheTinta.strIdePro);

    Except
      On E: Exception Do
      Begin
        Result := 'TP2';
        pMensagensErro(E.Message, '[fEscolheTinta]');
      End;
    End;

    FreeAndNil(frmEscolheTinta);
  End
  Else
  Begin
    Result := 'TP2';
  End;
end;

function fGetListaTintas(strCodCli : String = ''; blnProAca: Boolean = True; blnCampanha: Boolean = False): TStringList; stdcall;
Var
  lstTintas  : TStringList;
Begin
  sCodCli := strCodCli;

  If fMostraMenu then
  Begin
    lstTintas := TStringList.Create;
    frmEscolheTinta := TfrmEscolheTinta.Create(Nil, blnProAca, blnCampanha);

    frmEscolheTinta.cdsTintasDisponiveis.First;
    While Not frmEscolheTinta.cdsTintasDisponiveis.Eof Do
    Begin
      lstTintas.Add(frmEscolheTinta.cdsTintasDisponiveisDESCRI.AsString + '[' +
                    frmEscolheTinta.cdsTintasDisponiveisIDEPRO.AsString + ']');

      frmEscolheTinta.cdsTintasDisponiveis.Next;
    End;

    FreeAndNil(frmEscolheTinta);

    Result := lstTintas;
  End
  else
    Result := Nil;
End;

procedure TfrmEscolheTinta.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  FstrIdePro := cdsTintasDisponiveisIDEPRO.AsString;
  Close;
end;

procedure TfrmEscolheTinta.btnSairClick(Sender: TObject);
begin
  inherited;
  FstrIdePro := '';
  Close;
end;

procedure TfrmEscolheTinta.dbgViewTintasDisponiveisKeyPress(
  Sender: TObject; var Key: Char);
begin
  inherited;
  If Key = #13 Then
    btnConfirma.Click;

  If Key = #27 then
    btnSair.Click;
end;

procedure TfrmEscolheTinta.cdsTintasDisponiveisAfterScroll(
  DataSet: TDataSet);
  Var
    strPathImagens: String;
begin
  If Not FCarregaLogos Then
    Exit;

  strPathImagens := ExtractFilePath(Application.ExeName);
  strPathImagens := ExtractFilePath(Application.ExeName);
  If (Not AnsiEndsText('auttin', strPathImagens)) And (Not AnsiEndsText('auttin\', strPathImagens)) Then
    strPathImagens := strPathImagens + '\auttin\';

  If (Pos('/', cdsTintasDisponiveisDESCRI.AsString) > 0) And (FileExists(strPathImagens + '\' + AnsiReplaceStr(cdsTintasDisponiveisDESCRI.AsString, '/', '-') + '.jpg')) Then
    imgLogo.Picture.LoadFromFile(strPathImagens + '\' + AnsiReplaceStr(cdsTintasDisponiveisDESCRI.AsString, '/', '-') + '.jpg')
  Else If FileExists(strPathImagens + '\' + cdsTintasDisponiveisDESCRI.AsString + '.jpg') Then
    imgLogo.Picture.LoadFromFile(strPathImagens + '\' + cdsTintasDisponiveisDESCRI.AsString + '.jpg')
  Else
    imgLogo.Picture.Assign(Nil);
end;

constructor TfrmEscolheTinta.Create(Owner: TComponent; blnProAca: Boolean; blnCampanha: Boolean);
begin
  Self.blnIniciou  := True;
  Self.blnProAca   := blnProAca;
  Self.blnCampanha := blnCampanha;
  Self.FCarregaLogos := False;
  inherited Create(Owner);
end;

function TfrmEscolheTinta.fRetornaClienteFilial(strCodCli : String): Boolean;
  Var
    qryGenFil : TUniQuery;
begin

  Try
    qryGenFil := fCriaQuery;

    qryGenFil.SQL.Clear;
    qryGenFil.Close;

    qryGenFil.SQL.text := 'SELECT 1 FIRST ' +
                          '  FROM CADEMP  ' +
                          ' WHERE EMP_CLIFIL = :CODCLI ';

    qryGenFil.ParamByName('CODCLI').AsString := strCodCli;

    qryGenFil.Open;

    Result := not(qryGenFil.IsEmpty);

  Finally
    FreeAndNil(qryGenFil);
  End;

end;

function TfrmEscolheTinta.fRetornaVersaoData(strIdePro: String): String;
Var
  qryGen : TUniQuery;
  strVersao: String;
  strData: String;
begin
  Try
    qryGen := fCriaQuery;

    qryGen.SQL.Clear;
    qryGen.Close;

    qryGen.SQL.text := 'SELECT * ' +
                          '  FROM CFGTIN  ' +
                          ' WHERE CFG_CODEMP = :CODEMP  AND ' +
                          '       CFG_IDEPRO = :IDEPRO  AND ' +
                          '       CFG_GRUCFG = "CONFIGURACOES"  ';

    qryGen.ParamByName('CODEMP').AsString := VS_StrCodEmp;
    qryGen.ParamByName('IDEPRO').AsString := strIdePro;

    qryGen.Open;

    If qryGen.IsEmpty Then
    Begin
      Result := '';
      Exit;
    End;

    If qryGen.Locate('CFG_CODCFG', 'VERSAO', []) Then
      strVersao := qryGen.FieldByName('CFG_VALCFG').AsString;

    If qryGen.Locate('CFG_CODCFG', 'DTAATU', []) Then
      strData := qryGen.FieldByName('CFG_VALCFG').AsString;

    If fEmptyStr(strVersao) Then
    Begin
      Result := '';
      Exit;
    End;

    If fEmptyStr(strData) Then
    Begin
      Result := '';
      Exit;
    End;

    Result := ' Versão = ' + strVersao + ' - ' + strData;
  Finally
    FreeAndNil(qryGen);
  End;
end;

procedure TfrmEscolheTinta.pSetaProAca;
begin
  If Not blnIniciou Then
    blnProAca := True;
end;

end.
