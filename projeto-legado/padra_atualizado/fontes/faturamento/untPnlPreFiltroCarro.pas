unit untPnlPreFiltroCarro;

interface

uses cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer,
  cxEdit, Vcl.Menus, Vcl.StdCtrls, Vcl.Controls, cxTextEdit, Winapi.Messages,
  cxMaskEdit, cxDropDownEdit, System.Classes, Vcl.ExtCtrls, Windows,
  untFuncoesSimples, Forms, Uni, SysUtils, dxGDIPlusClasses, cxImage,
  untPanelCxPreFiltro, strUtils, cxButtons, Vcl.Buttons, BitBtnLockedIncrem;

type
  TOpcaoFiltroCarro = (opFiltroMarca, opFiltroModelo, opFiltroAno,
    opFiltroDepartamento, opFiltroLinha);

  TfrmPnlPreFiltroCarro = class(TfrmPnlPreFiltro)
    PnlPreFiltroCarro: TPanel;
    cxImage1: TcxImage;
    pnlAcao: TPanel;
    btnBuscarPecas: TBitBtnLocked;
    btnLimpar: TBitBtnLocked;
    pnlTitulo: TPanel;
    pnlPlaca: TPanel;
    Label1: TLabel;
    edtPlaca: TEdit;
    pnlFiltros: TPanel;
    cmbValvula: TcxComboBox;
    cmbCilindrada: TcxComboBox;
    cmbLinhas: TcxComboBox;
    cmbDepartamentos: TcxComboBox;
    cmbModelos: TcxComboBox;
    cmbAnos: TcxComboBox;
    cmbMarcas: TcxComboBox;
    btnConsultaPlaca: TBitBtnLocked;
    edtObservacao: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure btnBuscarPecasClick(Sender: TObject);
    procedure cmbMarcasEnter(Sender: TObject);
    procedure cmbMarcasExit(Sender: TObject);
    procedure btnLimparClick(Sender: TObject);
    procedure cmbMarcasKeyPress(Sender: TObject; var Key: Char);
    procedure btnConsultaPlacaClick(Sender: TObject);
    procedure edtPlacaKeyPress(Sender: TObject; var Key: Char);
    procedure cmbMarcasPropertiesChange(Sender: TObject);
  private

    strDepOuGru : String;

    procedure pIniciarFiltros;

    function fGetSQLFiltroConsulta(): String;
    function fGetSQLPreFiltro(opFiltro: TOpcaoFiltroCarro): String;

    function fGetCodigoMarca(): String;
    function fGetCodigoModelo(): String;
    function fGetCodigoDepartamento(): String;
    function fGetCodigoLinha(): String;
    function fGetCodigoGrupoProduto() : String;

    procedure pCarregarMarcas;
    procedure pCarregarDepartamentos;
    procedure pCarregarLinhas;
    procedure pCarregarModelos;
    procedure pCarregarCilindrada;
    procedure pCarregarValvula;
    procedure pCarregarAnos;
    procedure pCarregarGrupoProdutos;
    function PossuiFiltroSelecionado: Boolean;
    procedure pConsultarPlaca;
    function fComboPossuiFiltro(Acmb: TcxComboBox; const AstrIgnorar: String): Boolean;
  end;

var
  frmPnlPreFiltroCarro: TfrmPnlPreFiltroCarro;

implementation

uses
  untConstantes, untCatalagoFraga.VehicleByPlate, untGravando;

Const
  SELECIONE_ANO = 'Ano';
  SELECIONE_MARCA = 'Selecione uma marca';
  SELECIONE_MODELO = 'Selecione um modelo';
  SELECIONE_DEPARTAMENTO = 'Selecione um departamento';
  SELECIONE_CILINDRADA = 'Selecione uma cilindrada';
  SELECIONE_VALVULA = 'Selecione uma válvula';
  SELECIONE_LINHA = 'Selecione uma linha';
  SELECIONE_GRUPOPRODUTO = 'Selecione um grupo de produto';

  JOIN_COM_VEICULOS = True;
  SEM_JOIN_COM_VEICULOS = False;

{$R *.dfm}
  { TfrmPnlPreFiltroCarro }

function TfrmPnlPreFiltroCarro.PossuiFiltroSelecionado: Boolean;
begin
  Result := False;

  if fComboPossuiFiltro(cmbMarcas, SELECIONE_MARCA) then
    Exit(True);

  if fComboPossuiFiltro(cmbModelos, SELECIONE_MODELO) then
    Exit(True);

  if fComboPossuiFiltro(cmbCilindrada, SELECIONE_CILINDRADA) then
    Exit(True);

  if fComboPossuiFiltro(cmbValvula, SELECIONE_VALVULA) then
    Exit(True);

  if fComboPossuiFiltro(cmbDepartamentos, SELECIONE_DEPARTAMENTO+'_'+SELECIONE_GRUPOPRODUTO) then
    Exit(True);

  if fComboPossuiFiltro(cmbLinhas, SELECIONE_LINHA) then
    Exit(True);

  if fComboPossuiFiltro(cmbMarcas, SELECIONE_MARCA) then
    Exit(True);

  if not fEmptyStr(edtObservacao.Text) then
    Exit(True);
end;

function TfrmPnlPreFiltroCarro.fComboPossuiFiltro(Acmb: TcxComboBox; const AstrIgnorar: String): Boolean;
begin
  Result := (not fEmptyStr(Acmb.Text)) and (Pos(Acmb.Text, AstrIgnorar) = 0);
end;

procedure TfrmPnlPreFiltroCarro.btnConsultaPlacaClick(Sender: TObject);
begin
  TfrmGravando.fExecutarModal(pConsultarPlaca, 'Aguarde... Consultando veículo!', '');
end;

procedure TfrmPnlPreFiltroCarro.pConsultarPlaca;
var
  strMarca,
  strModelo,
  strAno: String;
begin
  pIniciarFiltros;
  pCarregarMarcas;
  pCarregarModelos;
  pCarregarAnos;

  TFragaVehicleByPlate.pRetVeiculoPorPlaca(edtPlaca.Text, strMarca, strModelo, strAno);

  if not fEmptyStr(strMarca) then
    cmbMarcas.ItemIndex := cmbMarcas.Properties.Items.IndexOf(strMarca);

  if not fEmptyStr(strModelo) then
    cmbModelos.ItemIndex := cmbModelos.Properties.Items.IndexOf(strModelo);

  if not fEmptyStr(strAno) then
    cmbAnos.ItemIndex := cmbAnos.Properties.Items.IndexOf(strAno);

  if (not fEmptyStr(strMarca)) and (not fEmptyStr(strModelo)) and (not fEmptyStr(strAno)) then
    btnBuscarPecas.Click;
end;

procedure TfrmPnlPreFiltroCarro.btnBuscarPecasClick(Sender: TObject);
begin
  If Assigned(objPreFiltro) Then
    objPreFiltro.pSetSQLPreFiltro(fGetSQLFiltroConsulta);

  If Not PossuiFiltroSelecionado Then
  Begin
    pMensagemOk('Selecione algum filtro para buscar as peças!');
    Exit;
  End;

  PostMessage(GetParentForm(Self).Handle, WM_MESSAGEATUALIZAPESQUISA, 0, 0);
end;

procedure TfrmPnlPreFiltroCarro.btnLimparClick(Sender: TObject);
begin
  pIniciarFiltros;
end;

procedure TfrmPnlPreFiltroCarro.cmbMarcasEnter(Sender: TObject);
begin
  If Not Assigned(objPreFiltro) Then
    Exit;

  If TcxComboBox(Sender).Text = TcxComboBox(Sender).TextHint Then
    TcxComboBox(Sender).Text := '';

  If Sender = cmbMarcas Then
    pCarregarMarcas;

  If Sender = cmbModelos Then
    pCarregarModelos;

  If Sender = cmbAnos Then
    pCarregarAnos;

  If Sender = cmbDepartamentos Then
  Begin
    If strDepOuGru = '1' Then
     pCarregarGrupoProdutos
    Else
     pCarregarDepartamentos;
  End;

  If Sender = cmbLinhas Then
    pCarregarLinhas;

  If Sender = cmbCilindrada Then
    pCarregarCilindrada;

  If Sender = cmbValvula Then
    pCarregarValvula;
end;

procedure TfrmPnlPreFiltroCarro.cmbMarcasExit(Sender: TObject);
begin
  If Assigned(objPreFiltro) Then
    If TcxComboBox(Sender).Text = '' Then
      TcxComboBox(Sender).Text := TcxComboBox(Sender).TextHint;
end;

procedure TfrmPnlPreFiltroCarro.cmbMarcasKeyPress(Sender: TObject;
  var Key: Char);
begin
  If Key = #13 Then
  Begin
    If Sender = cmbMarcas Then
      pSetFocus(cmbModelos);
    If Sender = cmbModelos Then
      pSetFocus(cmbAnos);
    If Sender = cmbAnos Then
      pSetFocus(cmbDepartamentos);
    If Sender = cmbDepartamentos Then
      pSetFocus(cmbLinhas);
    If Sender = cmbLinhas Then
      pSetFocus(btnBuscarPecas);
  End;
end;

procedure TfrmPnlPreFiltroCarro.cmbMarcasPropertiesChange(Sender: TObject);
begin
  If Assigned(objPreFiltro) Then
    objPreFiltro.pSetSQLPreFiltro(fGetSQLFiltroConsulta);
end;

procedure TfrmPnlPreFiltroCarro.edtPlacaKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = #13 then
  begin
    key := #0;
    if Length(edtPlaca.Text) < 7 then
      pSetFocus(cmbMarcas)
    else
      btnConsultaPlaca.Click;
  end;
end;

function TfrmPnlPreFiltroCarro.fGetCodigoDepartamento: String;
begin
  Result := EmptyStr;

  If fEmptyStr(cmbDepartamentos.Text) Then
    Exit;

  Result := fCampoTabela('DEP_CODIGO', 'CADDEP', ['DEP_DESCRI'],
    [cmbDepartamentos.Text], False);
end;

function TfrmPnlPreFiltroCarro.fGetCodigoLinha: String;
begin
  Result := EmptyStr;

  if fEmptyStr(cmbLinhas.Text) then
    Exit;

  Result := fCampoTabela('GRU_CODGRU', 'CADGRU',
    ['GRU_DESGRU', 'RIGHT(GRU_CODGRU, 3)'], [cmbLinhas.Text, '000'], False);
end;

function TfrmPnlPreFiltroCarro.fGetCodigoMarca: String;
begin
  Result := EmptyStr;

  If fEmptyStr(cmbMarcas.Text) Then
    Exit;

  Result := fCampoTabela('MAR_CODMAR', 'MARVEI', ['MAR_DESMAR'],
    [cmbMarcas.Text], False);
end;

function TfrmPnlPreFiltroCarro.fGetCodigoModelo: String;
begin
  Result := EmptyStr;

  if fEmptyStr(cmbModelos.Text) then
    Exit;

  If fEmptyStr(cmbMarcas.Text) Then
    Result := fCampoTabela('MOD_CODMOD', 'MODVEI', ['MOD_DESMOD'],
      [cmbModelos.Text], False)
  Else
    Result := fCampoTabela('MOD_CODMOD', 'MODVEI', ['MOD_DESMOD', 'MOD_CODMAR'],
      [cmbModelos.Text, fGetCodigoMarca], False);
end;

function TfrmPnlPreFiltroCarro.fGetCodigoGrupoProduto: String;
begin
  Result := EmptyStr;

  if fEmptyStr(cmbDepartamentos.Text) then
    Exit;

  Result := fCampoTabela('PRD_CODGRU', 'GRPPRD', ['PRD_DESGRU'],
    [cmbDepartamentos.Text], False);
end;

function TfrmPnlPreFiltroCarro.fGetSQLFiltroConsulta: String;
begin
  Result := ' TRUE ';

  If PossuiFiltroSelecionado Then
  Begin
    Result := Result + ' AND EXISTS (';
    Result := Result + '( SELECT VEIPRO.AUTOINCREM ';
    Result := Result + '  FROM VEIPRO ';
    Result := Result +
      '    INNER JOIN DETMOD ON DETMOD.AUTOINCREM = VEI_CODMOD ';

    Result := Result +
      '    INNER JOIN MODVEI ON MODVEI.MOD_CODMOD = DETMOD.MOD_CODMOD ';

    Result := Result +
      '    INNER JOIN MARVEI ON MARVEI.MAR_CODMAR = MODVEI.MOD_CODMAR ';

    Result := Result + '  WHERE VEI_CODITE = I.ITE_CODITE ';

    If cmbModelos.ItemIndex > 0 Then
      Result := Result + '    AND MODVEI.MOD_CODMOD = ' +
        fGetCodigoModelo.QuotedString;

    If cmbMarcas.ItemIndex > 0 Then
      Result := Result + '    AND MODVEI.MOD_CODMAR = ' +
        fGetCodigoMarca.QuotedString;

    If cmbCilindrada.ItemIndex > 0 Then
      Result := Result + ' AND DETMOD.MOD_CILIND = "' + cmbCilindrada.Text + '" ';
    If cmbValvula.ItemIndex > 0 Then
      Result := Result + ' AND DETMOD.MOD_VALVUL = "' + cmbValvula.Text + '" ';

    If Not fEmptyStr(edtObservacao.Text) Then
      Result := Result + ' AND DETMOD.MOD_OBSERV LIKE "%' + edtObservacao.Text + '%" ';

    If cmbAnos.ItemIndex > 0 Then
      Result := Result + ' AND ( '+
                             cmbAnos.Text + ' BETWEEN MOD_ANOINI '+
                         '   AND IFNULL(NULLIF(MOD_ANOFIN, 0), YEAR(CURRENT_DATE)) '+
                         '     ) ';

    Result := Result + ' ) ) ';
  End;

  If cmbDepartamentos.ItemIndex > 0 Then
  Begin
    If strDepOuGru = '1' Then
      Result := Result + ' AND I.ITE_PRDGRU = ' + fGetCodigoGrupoProduto.QuotedString + ' '
    Else
      Result := Result + ' AND I.ITE_CODDEP = ' + fGetCodigoDepartamento.QuotedString + ' '
  End;

  If cmbLinhas.ItemIndex > 0 Then
    Result := Result + ' AND I.ITE_CODGRU LIKE "' + LeftStr(fGetCodigoLinha,
      3) + '%" ';
end;

function TfrmPnlPreFiltroCarro.fGetSQLPreFiltro
  (opFiltro: TOpcaoFiltroCarro): String;
Var
  strCampos: String;
  blnJoinVeiculos: Boolean;
begin
  strCampos := '';
  blnJoinVeiculos := True;

  Case opFiltro Of
    opFiltroMarca:
      strCampos := 'DISTINCT MAR_DESMAR';
    opFiltroModelo:
      strCampos := 'DISTINCT MOD_DESMOD';
    opFiltroAno:
      strCampos := 'MIN(MOD_ANOINI) AS ANOINI, MAX(MOD_ANOFIN) AS ANOFIN';
    opFiltroDepartamento:
      If strDepOuGru = '1' Then
        strCampos := 'DISTINCT PRD_DESGRU'
      Else
        strCampos := 'DISTINCT DEP_DESCRI';
    opFiltroLinha:
      strCampos := 'DISTINCT GRU_DESGRU';
  end;

  Case opFiltro Of
    opFiltroMarca, opFiltroModelo, opFiltroAno:
      blnJoinVeiculos := True;
    opFiltroDepartamento, opFiltroLinha:
      blnJoinVeiculos := cmbMarcas.ItemIndex + cmbModelos.ItemIndex +
        cmbAnos.ItemIndex > 0;
  end;

  Result := '';
  Result := Result + ' SELECT ';
  Result := Result + '   ' + strCampos;
  Result := Result + ' FROM ';
  Result := Result + '   CADITE ';

  If opFiltro = opFiltroDepartamento Then
  Begin
    If strDepOuGru = '1' Then
      Result := Result + '   INNER JOIN GRPPRD ON CADITE.ITE_PRDGRU = GRPPRD.PRD_CODGRU '
    Else
      Result := Result + '   INNER JOIN CADDEP ON CADITE.ITE_CODDEP = CADDEP.DEP_CODIGO ';
  End;

  If opFiltro = opFiltroLinha Then
    Result := Result +
      '   INNER JOIN CADGRU ON CONCAT(LEFT(CADITE.ITE_CODGRU, 3), "000") = CADGRU.GRU_CODGRU ';

  If blnJoinVeiculos Then
  Begin
    Result := Result +
      '   INNER JOIN VEIPRO ON VEIPRO.VEI_CODITE = CADITE.ITE_CODITE ';

    Result := Result +
      '   INNER JOIN DETMOD ON DETMOD.AUTOINCREM = VEIPRO.VEI_CODMOD ';

    Result := Result +
      '   INNER JOIN MODVEI ON MODVEI.MOD_CODMOD = DETMOD.MOD_CODMOD ';

    Result := Result +
      '   INNER JOIN MARVEI ON MARVEI.MAR_CODMAR = MODVEI.MOD_CODMAR ';
  End;

  Result := Result + ' WHERE TRUE ';

  If blnJoinVeiculos Then
  Begin
    If opFiltro <> opFiltroModelo Then
      If cmbModelos.ItemIndex > 0 Then
        Result := Result + '    AND MODVEI.MOD_CODMOD = ' +
          fGetCodigoModelo.QuotedString;

    If opFiltro <> opFiltroMarca Then
      If cmbMarcas.ItemIndex > 0 Then
        Result := Result + '    AND MODVEI.MOD_CODMAR = ' +
          fGetCodigoMarca.QuotedString;

    If opFiltro <> opFiltroAno Then
      If cmbAnos.ItemIndex > 0 Then
        Result := Result + '  AND ((' + cmbAnos.Text +
          ' BETWEEN MOD_ANOINI AND MOD_ANOFIN) OR (MOD_ANOFIN IS NULL)) ';
  End;

  If opFiltro <> opFiltroDepartamento Then
  Begin
    If cmbDepartamentos.ItemIndex > 0 Then
    Begin
       If strDepOuGru = '1' Then
         Result := Result + ' AND ITE_PRDGRU = ' + fGetCodigoGrupoProduto.QuotedString + ' '
       Else
         Result := Result + ' AND ITE_CODDEP = ' + fGetCodigoDepartamento.QuotedString + ' ';
    End;
  End;

  If opFiltro <> opFiltroLinha Then
    If cmbLinhas.ItemIndex > 0 Then
      Result := Result + ' AND ITE_CODGRU LIKE "' + LeftStr(fGetCodigoLinha,
        3) + '%" ';
end;

procedure TfrmPnlPreFiltroCarro.FormCreate(Sender: TObject);
begin
  strDepOuGru := fCfgSis('DEPGRU', varString);
  pIniciarFiltros;

  if not ((fCfgSis('CLIVEI', varString) = 'S') and (fCfgSis('PROVEI', varString) = 'S')) then
  begin
    cmbCilindrada.Visible := False;
    cmbValvula.Visible := False;
    edtObservacao.Visible := False;
  end;

  pnlPlaca.Visible := fCfgSis('UTIFRA', varBoolean);
end;
procedure TfrmPnlPreFiltroCarro.pCarregarAnos;
Var
  qryAnos: TUniQuery;
  intAno: Integer;
  intAnoInicial: Integer;
  intAnoFinal: Integer;
begin
  qryAnos := fCriaQuery;
  Try
    cmbAnos.Properties.Items.Clear;
    cmbAnos.Properties.Items.Add(SELECIONE_ANO);
    cmbAnos.ItemIndex := 0;

    qryAnos.SQL.Text := fGetSQLPreFiltro(opFiltroAno);
    qryAnos.Open;

    intAnoInicial := qryAnos.FieldByName('ANOINI').AsInteger;
    intAnoFinal := qryAnos.FieldByName('ANOFIN').AsInteger;

    If intAnoInicial = 0 Then
      intAnoInicial := 1900;

    If intAnoFinal = 0 Then
      intAnoFinal := CurrentYear;

    For intAno := intAnoFinal Downto intAnoInicial Do
    Begin
      cmbAnos.Properties.Items.Add(intAno.ToString());
    End;

    cmbAnos.ItemIndex := 0;
  Finally
    FreeAndNil(qryAnos);
  End;
End;

procedure TfrmPnlPreFiltroCarro.pCarregarCilindrada;
Var
  qryCilindrada: TUniQuery;
begin
  qryCilindrada := fCriaQuery;
  Try
    cmbCilindrada.Properties.Items.Clear;
    cmbCilindrada.Properties.Items.Add(SELECIONE_CILINDRADA);
    cmbCilindrada.ItemIndex := 0;

    qryCilindrada.SQL.Text := 'SELECT DISTINCT(MOD_CILIND) MOD_CILIND FROM DETMOD WHERE IFNULL(MOD_CILIND,"")<>"" ORDER BY 1';
    qryCilindrada.Open;

    qryCilindrada.First;
    While Not qryCilindrada.Eof Do
    Begin
      cmbCilindrada.Properties.Items.Add(
        qryCilindrada.FieldByName('MOD_CILIND').AsString
      );
      qryCilindrada.Next;
    End;

    cmbCilindrada.ItemIndex := 0;
  Finally
    FreeAndNil(qryCilindrada);
  End;
end;

procedure TfrmPnlPreFiltroCarro.pCarregarDepartamentos;
Var
  qryDepartamentos: TUniQuery;
begin
  qryDepartamentos := fCriaQuery;
  Try
    qryDepartamentos.SQL.Text := fGetSQLPreFiltro(opFiltroDepartamento);
    qryDepartamentos.Open;

    cmbDepartamentos.Properties.Items.Clear;
    cmbDepartamentos.Properties.Items.Add(SELECIONE_DEPARTAMENTO);

    qryDepartamentos.First;
    While Not qryDepartamentos.Eof Do
    Begin
      cmbDepartamentos.Properties.Items.Add
        (qryDepartamentos.FieldByName('DEP_DESCRI').AsString);
      qryDepartamentos.Next;
    End;

    cmbDepartamentos.ItemIndex := 0;
  Finally
    FreeAndNil(qryDepartamentos);
  End;
end;

procedure TfrmPnlPreFiltroCarro.pCarregarGrupoProdutos;
Var
  qryGrupoProdutos: TUniQuery;
begin
  qryGrupoProdutos := fCriaQuery;
  Try
    qryGrupoProdutos.SQL.Text := fGetSQLPreFiltro(opFiltroDepartamento);
    qryGrupoProdutos.Open;

    cmbDepartamentos.Properties.Items.Clear;
    cmbDepartamentos.Properties.Items.Add(SELECIONE_GRUPOPRODUTO);

    qryGrupoProdutos.First;
    While Not qryGrupoProdutos.Eof Do
    Begin
      cmbDepartamentos.Properties.Items.Add
        (qryGrupoProdutos.FieldByName('PRD_DESGRU').AsString);
      qryGrupoProdutos.Next;
    End;

    cmbDepartamentos.ItemIndex := 0;
  Finally
    FreeAndNil(qryGrupoProdutos);
  End;
end;

procedure TfrmPnlPreFiltroCarro.pCarregarLinhas;
Var
  qryLinhas: TUniQuery;
begin
  qryLinhas := fCriaQuery;
  Try
    qryLinhas.SQL.Text := fGetSQLPreFiltro(opFiltroLinha);
    qryLinhas.Open;

    cmbLinhas.Properties.Items.Clear;
    cmbLinhas.Properties.Items.Add(SELECIONE_LINHA);

    qryLinhas.First;
    While Not qryLinhas.Eof Do
    Begin
      cmbLinhas.Properties.Items.Add(qryLinhas.FieldByName('GRU_DESGRU')
        .AsString);
      qryLinhas.Next;
    End;

    cmbLinhas.ItemIndex := 0;
  Finally
    FreeAndNil(qryLinhas);
  End;
end;

procedure TfrmPnlPreFiltroCarro.pCarregarModelos;
Var
  qryModelos: TUniQuery;
begin
  qryModelos := fCriaQuery;
  Try
    cmbModelos.Properties.Items.Clear;
    cmbModelos.Properties.Items.Add(SELECIONE_MODELO);
    cmbModelos.ItemIndex := 0;

    qryModelos.SQL.Text := fGetSQLPreFiltro(opFiltroModelo);
    qryModelos.Open;

    qryModelos.First;
    While Not qryModelos.Eof Do
    Begin
      cmbModelos.Properties.Items.Add(qryModelos.FieldByName('MOD_DESMOD')
        .AsString);
      qryModelos.Next;
    End;

    cmbModelos.ItemIndex := 0;
  Finally
    FreeAndNil(qryModelos);
  End;
end;

procedure TfrmPnlPreFiltroCarro.pCarregarValvula;
Var
  qryValvula: TUniQuery;
begin
  qryValvula := fCriaQuery;
  Try
    cmbValvula.Properties.Items.Clear;
    cmbValvula.Properties.Items.Add(SELECIONE_VALVULA);
    cmbValvula.ItemIndex := 0;

    qryValvula.SQL.Text := 'SELECT DISTINCT(MOD_VALVUL) MOD_VALVUL FROM DETMOD WHERE IFNULL(MOD_VALVUL,"")<>"" ORDER BY 1';
    qryValvula.Open;

    qryValvula.First;
    While Not qryValvula.Eof Do
    Begin
      cmbValvula.Properties.Items.Add(
        qryValvula.FieldByName('MOD_VALVUL').AsString
      );
      qryValvula.Next;
    End;

    cmbValvula.ItemIndex := 0;
  Finally
    FreeAndNil(qryValvula);
  End;

end;

procedure TfrmPnlPreFiltroCarro.pIniciarFiltros;
begin
  cmbMarcas.TextHint := SELECIONE_MARCA;
  cmbMarcas.Properties.Items.Clear;
  cmbMarcas.Properties.Items.Add(SELECIONE_MARCA);
  cmbMarcas.ItemIndex := 0;

  cmbModelos.TextHint := SELECIONE_MODELO;
  cmbModelos.Properties.Items.Clear;
  cmbModelos.Properties.Items.Add(SELECIONE_MODELO);
  cmbModelos.ItemIndex := 0;

  cmbAnos.TextHint := SELECIONE_ANO;
  cmbAnos.Properties.Items.Clear;
  cmbAnos.Properties.Items.Add(SELECIONE_ANO);
  cmbAnos.ItemIndex := 0;

  cmbDepartamentos.Properties.Items.Clear;
  cmbDepartamentos.ItemIndex := 0;

  If strDepOuGru = '1' Then
  Begin
    cmbDepartamentos.TextHint := SELECIONE_GRUPOPRODUTO;
    cmbDepartamentos.Properties.Items.Add(SELECIONE_GRUPOPRODUTO);
  End
  Else
  Begin
    cmbDepartamentos.TextHint := SELECIONE_DEPARTAMENTO;
    cmbDepartamentos.Properties.Items.Add(SELECIONE_DEPARTAMENTO);
  End;

  cmbLinhas.TextHint := SELECIONE_LINHA;
  cmbLinhas.Properties.Items.Clear;
  cmbLinhas.Properties.Items.Add(SELECIONE_LINHA);
  cmbLinhas.ItemIndex := 0;

  cmbValvula.TextHint := SELECIONE_VALVULA;
  cmbValvula.Properties.Items.Clear;
  cmbValvula.Properties.Items.Add(SELECIONE_VALVULA);
  cmbValvula.ItemIndex := 0;

  cmbCilindrada.TextHint := SELECIONE_CILINDRADA;
  cmbCilindrada.Properties.Items.Clear;
  cmbCilindrada.Properties.Items.Add(SELECIONE_CILINDRADA);
  cmbCilindrada.ItemIndex := 0;

  edtObservacao.Text := '';
end;

procedure TfrmPnlPreFiltroCarro.pCarregarMarcas();
Var
  qryMarcas: TUniQuery;
begin
  qryMarcas := fCriaQuery;
  Try
    qryMarcas.SQL.Text := fGetSQLPreFiltro(opFiltroMarca);
    qryMarcas.Open;

    cmbMarcas.Properties.Items.Clear;
    cmbMarcas.Properties.Items.Add(SELECIONE_MARCA);

    qryMarcas.First;
    While Not qryMarcas.Eof Do
    Begin
      cmbMarcas.Properties.Items.Add(qryMarcas.FieldByName('MAR_DESMAR')
        .AsString);
      qryMarcas.Next;
    End;

    cmbMarcas.ItemIndex := 0;
  Finally
    FreeAndNil(qryMarcas);
  End;
end;

end.
