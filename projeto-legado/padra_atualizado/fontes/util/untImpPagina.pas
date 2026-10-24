unit untImpPagina;

interface

uses Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, strUtils, ComObj, Vcl.Controls,
  Vcl.Forms, Vcl.Dialogs, untPai, frxClass, frxExportCSVTestabilidade, Vcl.AppEvnts,
  Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons, BitBtnLockedIncrem, Vcl.ExtCtrls, Vcl.ComCtrls,
  Vcl.Mask, FilenameEditFocus, untZClient, untFuncoesSimples, Uni, Data.DB,
  UniClientDataSet, cxGraphics, cxControls, cxLookAndFeels, Math,
  cxLookAndFeelPainters, cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxButtonEdit, cxButtons,
  untTValidaExcel, cxProgressBar, Datasnap.DBClient;

type
  TfrmImpPagina = class(TfrmPai)
    Label1: TLabel;
    opdFileName: TFilenameEditFocus;
    pgbGeral: TcxProgressBar;
    btnGravar: TBitBtnLocked;
    procedure btnGravarClick(Sender: TObject);
  private

    objValidaExcel: TValidadorExcel;
    blnArqCsv: Boolean;

    procedure pImportaArquivo;
    procedure pPreparaValidador;
    procedure pAtualizaInfoValidador;
    function fImportaRegistrosProgresso(cxProgresso : TcxProgressBar):Boolean;
    function fAtualizaPagina(intPagReg:Integer; strCodIte : String) : Boolean;
    function fConvetVazioToNull(texto: string): Variant;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmImpPagina: TfrmImpPagina;

const cQtdColunas = 2;

const cCODITE = 'A';  // CODITE
      cNUMPAG = 'B';  // NUMPAG

const cDesCODITE = 'Cód. Produto';
      cDesNUMPAG = 'Número da Pagina';


implementation

{$R *.dfm}

uses untGravando;

procedure TfrmImpPagina.btnGravarClick(Sender: TObject);
begin
  inherited;
  if FileExists(opdFileName.Text) Then
    pImportaArquivo;
end;

function TfrmImpPagina.fAtualizaPagina(intPagReg:Integer; strCodIte: String): Boolean;
  Var
    qryUpdate : TUniQuery;
begin
  If fEmptyStr(strCodIte) Then
    Exit(True);
  qryUpdate := fCriaQuery;
  Try
    With qryUpdate, SQL Do
    Begin
      Add (' UPDATE CADITE SET ITE_PAGREV = :PAGREV ');
      Add(' WHERE ITE_CODITE = :CODITE ');
      ParamByName('PAGREV').AsInteger := intPagReg;
      if intPagReg < 0 Then
        ParamByName('PAGREV').Clear;
      ParamByName('CODITE').AsString := strCodIte;

      Try
        ExecSql;
        Result := True;
      Except
        On E : Exception Do
        Begin
          pMensagensErro(E.Message, 'TfrmImpPagina.fAtualizaPagina');
          Result := False;
        End;
      End;

    End;
  Finally
    FreeAndNil(qryUpdate);
  End;

end;

function TfrmImpPagina.fConvetVazioToNull(texto: string): Variant;
begin
  If Texto = '' Then
    Result := null
  Else
    Result := texto;
end;



function TfrmImpPagina.fImportaRegistrosProgresso(cxProgresso: TcxProgressBar): Boolean;
  Var
    strCodIte: String;
    intPagRes:  Integer;
    intContador: Integer;
begin
  cxProgresso.Position := 0;
  result:= False;

  If Not (FileExists(opdFileName.Text)) Then
  Begin
    fMensagem('AVISO','Arquivo não encontrado : ' + opdFileName.Text + ' !', ['&O K']);
    Exit;
  End;

  frmGravando.lblGravando.Caption  := 'Preparando os Registros ... ';
  Application.ProcessMessages;
  Sleep(500);

  objValidaExcel := TValidadorExcel.Create(opdFileName.text, cQtdColunas, cCODITE, '', 0);

  If fMensagem('Atenção', 'Deseja validar os dados contidos no arquivo informado', ['&Sim', '&Não']) = 1 Then
  Begin
    Try
      pPreparaValidador;
      pgbGeral.Visible := True;
      If Not objValidaExcel.fValidaCampos(True, pgbGeral) Then
        Exit;
    Finally

    End;
  End;

  blnArqCsv := UpperCase(ExtractFileExt(objValidaExcel.NomeArquivo)) = '.CSV';

  try
    intPagRes:= 0;
    strCodIte := '';
    For intContador := 0 To (objValidaExcel.ArquivoCSV.Count -1) Do
    Begin
      try
        strCodIte := fConvetVazioToNull(fStrZero(objValidaExcel.fGetValueCSV(intContador, cCODITE),fTamCodIte));
        intPagRes := fConvetVazioToNull((objValidaExcel.fGetValueCSV(intContador, cNUMPAG)));

        if fEmptyStr(strCodIte) Then
          Continue;
      Except
        Continue;
      End;

      fAtualizaPagina(intPagRes, strCodIte);

      Application.ProcessMessages;
    End;

    cxProgresso.Properties.Max := 0;
    frmGravando.lblGravando.Caption  := 'Atualização Finalizada ... ';

    Result := True;

  Finally
    pnlInfo.Caption := '';
    FreeAndNil(objValidaExcel);
    pgbGeral.Visible := False;
  End;

end;


procedure TfrmImpPagina.pImportaArquivo;
begin
  If fMensagem('ATENÇÃO', 'Deseja Realmente Importar o Arquivo ?', ['&Sim', '&Não'], 2 ) = 2 Then
    Exit;

  Try
    pCriarFormularios(TfrmGravando, frmGravando);
    frmGravando.fExecutarAcao := fImportaRegistrosProgresso;
    frmGravando.ShowModal;

    fMensagem('ATENÇÃO', 'Fim da Importação!', ['&OK']);
    opdFileName.Clear;

  Finally
    FreeAndNil(frmGravando);
  End;

end;

procedure TfrmImpPagina.pAtualizaInfoValidador;
begin
  PnlInfo.Caption := objValidaExcel.TempoExtimado;
end;

procedure TfrmImpPagina.pPreparaValidador;
Begin
  If Not Assigned(objValidaExcel) Then
    Exit;

  objValidaExcel.FAtualizaStatus := pAtualizaInfoValidador;
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoString(cDesCODITE, cCODITE, fTamCodIte, True, False, '', ''));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoString(cDesNUMPAG, cNUMPAG, 0, False, False, '', ''));

End;


end.
