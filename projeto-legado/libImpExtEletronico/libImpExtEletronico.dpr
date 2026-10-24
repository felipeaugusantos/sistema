library libImpExtEletronico;

{ Important note about DLL memory management: ShareMem must be the
  first unit in your library's USES clause AND your project's (select
  Project-View Source) USES clause if your DLL exports any procedures or
  functions that pass strings as parameters or function results. This
  applies to all strings passed to and from your DLL--even those that
  are nested in records and classes. ShareMem is the interface unit to
  the BORLNDMM.DLL shared memory manager, which must be deployed along
  with your DLL. To avoid using BORLNDMM.DLL, pass string information
  using PChar or ShortString parameters. }

uses
  ShareMem,
  Windows,
  SysUtils,
  Classes,
  RlConsts,
  System.UiTypes,
  Vcl.Dialogs,
  dxCore,
  untDownloadExtratoBradesco in 'Fontes\untDownloadExtratoBradesco.pas' {frmDownloadExtratoBradesco},
  untGravando in 'Fontes\untGravando.pas' {frmGravando},
  untGravandoObs in 'Fontes\untGravandoObs.pas',
  untSubjectClass in 'Fontes\untSubjectClass.pas',
  untSubjectIntf in 'Fontes\untSubjectIntf.pas',
  untFuncoesSimples in 'Fontes\untFuncoesSimples.pas',
  untDownloadExtratoBB in 'Fontes\untDownloadExtratoBB.pas' {frmDownloadExtratoBB};

function fBaixarExtratoBancario(strCodBco : PChar; handlePrincipal: HWND; strLocalSalvarArquivo: PChar) : PChar; export;
  const
    BANCOS = '237_001_';
  begin
    Result := '';
    if Pos(strCodBco, BANCOS) > 0 then
    begin
      if strCodBco = '237' then
      begin
        frmDownloadExtratoBradesco := TfrmDownloadExtratoBradesco.Create(nil);

        frmDownloadExtratoBradesco.hwndAutcom         := handlePrincipal;
        frmDownloadExtratoBradesco.strDiretorioSalvar := strLocalSalvarArquivo;

        try
          frmDownloadExtratoBradesco.ShowModal;
        finally
          Result := Pchar(frmDownloadExtratoBradesco.strArquivoBaixado);
          FreeAndNil(frmDownloadExtratoBradesco);
        end;
      end
      {Else If strCodBco = '033' Then
      Begin
        frmDownloadExtratoSantander := TfrmDownloadExtratoSantander.Create(nil);

//        frmDownloadExtratoSantander.hwndAutcom         := handlePrincipal;
//        frmDownloadExtratoSantander.strDiretorioSalvar := strLocalSalvarArquivo;

        try
          frmDownloadExtratoSantander.ShowModal;
        finally
//          Result := Pchar(frmDownloadExtratoSantander.strArquivoBaixado);
          FreeAndNil(frmDownloadExtratoSantander);
        end;
      End}
      Else If strCodBco = '001' Then
      Begin
        frmDownloadExtratoBB := TfrmDownloadExtratoBB.Create(nil);
        frmDownloadExtratoBB.strDiretorioSalvar := strLocalSalvarArquivo;
        frmDownloadExtratoBB.hwndAutcom := handlePrincipal;

        try
          frmDownloadExtratoBB.ShowModal;
        finally
          Result := Pchar(frmDownloadExtratoBB.strArquivoBaixado);
          FreeAndNil(frmDownloadExtratoBB);
        end;
      End;
    end
    else
      MessageDlg('Banco ainda não configurado para download automático do arquivo .OFX!', mtInformation, [mbOK], 0);
  end;


exports
  dxInitialize,
  dxFinalize,
  fBaixarExtratoBancario;

{$R *.res}

begin
end.

